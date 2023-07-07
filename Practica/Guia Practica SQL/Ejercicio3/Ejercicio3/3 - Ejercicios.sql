-- 1. Indique la cantidad de productos que tiene la empresa.

SELECT COUNT(p.IdProducto) AS [Cantidad de productos]
FROM Producto AS p

-- Usando MAX (No recomendado): Como el id del producto esta en una 
-- secuencia de numeros consecutivos de 1 hasta n productos, el maximo es n
SELECT MAX(p.IdProducto) AS [Cantidad de productos]
FROM Producto AS p

-- 1.b Indique la cantidad de productos vendidos
SELECT COUNT (DISTINCT dv.IdProducto) AS [Cantidad de productos vendidos]
FROM DetalleVenta AS dv

-- 2. Indique la cantidad de productos en estado 'Stock' que tiene la empresa. 

SELECT COUNT(p.IdProducto) [Cantidad de productos en Stock] 
FROM Producto AS p
WHERE p.Estado LIKE 'Stock'

-- 3. Indique los productos que nunca fueron vendidos. 

-- Con EXCEPT:

SELECT p.IdProducto
FROM Producto AS p
EXCEPT
SELECT dv.IdProducto
FROM DetalleVenta AS dv

-- Con NOT IN:

SELECT p.IdProducto
FROM Producto AS p
WHERE p.IdProducto NOT IN (SELECT dv.IdProducto
							FROM DetalleVenta AS dv)

-- Con NOT EXISTS:

SELECT p.IdProducto
FROM Producto AS p
WHERE NOT EXISTS (SELECT 1
			 	  FROM DetalleVenta AS dv
				  WHERE dv.IdProducto = p.IdProducto)

-- Con LEFT JOIN:

SELECT p.IdProducto
FROM Producto AS p LEFT JOIN DetalleVenta AS dv ON p.IdProducto = dv.IdProducto
GROUP BY p.IdProducto
HAVING COUNT(dv.NroDetalle) = 0

-- 4. Indique la cantidad de unidades que fueron vendidas de cada producto. 

SELECT p.IdProducto, ISNULL(SUM(dv.Cantidad), 0) AS [Cantidad de unidades vendidas]
FROM Producto AS p LEFT JOIN DetalleVenta AS dv ON p.IdProducto = dv.IdProducto
GROUP BY p.IdProducto

-- 5. Indique cual es la cantidad promedio de unidades vendidas de cada producto. 

SELECT p.IdProducto, ISNULL(AVG(dv.Cantidad), 0) AS [Cantidad de unidades promedio vendidas]
FROM Producto AS p LEFT JOIN DetalleVenta AS dv ON p.IdProducto = dv.IdProducto
GROUP BY p.IdProducto

-- 6. Indique quien es el vendedor con mas ventas realizadas.

CREATE OR ALTER VIEW vCantidadDeVentasPorVendedor AS
(
	SELECT v.IdVendedor, COUNT(v.NroFactura) AS [Cantidad de ventas]
	FROM Venta AS v
	GROUP BY v.IdVendedor
)

SELECT v.IdVendedor
FROM vCantidadDeVentasPorVendedor AS v
WHERE v.[Cantidad de ventas] = (SELECT MAX(v.[Cantidad de ventas]) AS [Maxima cantidad de ventas]
								FROM vCantidadDeVentasPorVendedor AS v)

-- Otra forma:

SELECT v.IdVendedor
FROM Venta AS v
GROUP BY v.IdVendedor
HAVING COUNT(v.NroFactura) >= ALL (SELECT COUNT(v.NroFactura)
								   FROM Venta AS v
								   GROUP BY v.IdVendedor)

-- 7. Indique todos los productos de lo que se hayan vendido más de 20 unidades. 

SELECT dv.IdProducto
FROM DetalleVenta AS dv
GROUP BY dv.IdProducto
HAVING SUM(dv.Cantidad) > 20

-- 7.b Indique todos los productos de lo que se hayan vendido exactamente 20 unidades 

SELECT dv.IdProducto
FROM DetalleVenta AS dv
GROUP BY dv.IdProducto
HAVING SUM(dv.Cantidad) = 20

-- 8. Indique los clientes que le han comprado a todos los vendedores.

SELECT *
FROM Cliente AS c
WHERE NOT EXISTS (
	SELECT 1
	FROM Vendedor AS v
	WHERE NOT EXISTS (
		SELECT 1
		FROM Venta AS vta
		WHERE vta.IdCliente = c.IdCliente AND v.IdVendedor = vta.IdVendedor
					)
				)

-- Prueba

INSERT INTO Venta (NroFactura, IdCliente, IdVendedor, Fecha) VALUES (574,1,16,'2021-06-26');
DELETE FROM Venta WHERE NroFactura = 574

-- Otra forma:

SELECT vta.IdCliente
FROM Venta AS vta
GROUP BY vta.IdCliente
HAVING COUNT(DISTINCT vta.IdVendedor) = (SELECT COUNT(*) [Cantidad de vendedores]
										 FROM Vendedor AS v)

-- 9. Genere un SP que permita crear un nuevo vendedor, pasando los parámetros del mismo.

CREATE OR ALTER PROCEDURE pCrearVendedor (@Nombre VARCHAR(50), @Apellido VARCHAR(50), @DNI BIGINT) AS
	IF EXISTS (SELECT 1 FROM Vendedor AS v WHERE v.DNI = @DNI)
		RAISERROR('Vendedor existente', 5, 1);
	ELSE
	BEGIN
		DECLARE @NuevoId INT = COALESCE((SELECT MAX(IdVendedor) + 1 FROM Vendedor), 1)
		INSERT INTO Vendedor (IdVendedor, Nombre, Apellido, DNI) VALUES (@NuevoId, @Nombre, @Apellido, @DNI)
	END

EXECUTE pCrearVendedor 'Cosme', 'Fulanito', 32204151

-- Otra forma:

CREATE OR ALTER PROCEDURE p_Nuevo_Vendedor (@IdVendedor INT OUTPUT, @Nombre VARCHAR(50), @Apellido VARCHAR(50), @DNI BIGINT)
AS
BEGIN
	-- Busco el maximo Id_vendedor y le sumo 1 para agregar el siguiente numero consecutivo
	SET @IdVendedor = COALESCE ((SELECT MAX(v.IdVendedor) + 1 
								 FROM Vendedor AS v), 1)
	-- Inserto los valores
	INSERT INTO Vendedor (IdVendedor, Nombre, Apellido, DNI) VALUES (@IdVendedor, @Nombre, @Apellido, @DNI)
END


-- 10. Genere una función que reciba por parametro un nro de factura y nos retorne el monto total de venta.

CREATE OR ALTER FUNCTION fMontoTotalVenta (@NroFactura BIGINT) RETURNS INT AS
BEGIN
	DECLARE @MontoTotal INT = -1;
	IF EXISTS (SELECT 1 FROM DetalleVenta WHERE NroFactura = @NroFactura)
		SET @MontoTotal = (SELECT SUM(dv.Cantidad) * dv.PrecioUnitario
							FROM DetalleVenta dv
							WHERE dv.NroFactura = @NroFactura
							GROUP BY dv.NroFactura, dv.PrecioUnitario)
	RETURN @MontoTotal;
END

SELECT dbo.fMontoTotalVenta(1) AS [Monto total]

-- 11. Genere un trigger que, al eliminarse tuplas en la tabla ventas, permita lo siguiente:
--	* Realice un respaldo de las tuplas eliminadas, en una tabla nueva, que se debe llamar historico_ventas.
--	* Elimine las tuplas vinculadas a esas ventas, que existen en el detalle de ventas pero previamente, 
--	* Realice un respaldo en una tabla nueva, que se debe llamar historico_detalle_ventas.

--Nota: Las tablas deben generarse previamente a desarrollar el trigger.

SELECT * INTO HistoricoVentas FROM Venta
SELECT * INTO HistoricoDetalleVentas FROM DetalleVenta

TRUNCATE TABLE HistoricoVentas
TRUNCATE TABLE HistoricoDetalleVentas

CREATE OR ALTER TRIGGER tEliminarVenta ON Venta INSTEAD OF DELETE AS
BEGIN
	INSERT INTO HistoricoVentas SELECT * FROM Deleted;
	INSERT INTO HistoricoDetalleVentas SELECT dv.* FROM DetalleVenta AS dv JOIN Deleted AS d ON dv.NroFactura = d.NroFactura 
	DELETE FROM DetalleVenta WHERE NroFactura IN (SELECT d.NroFactura FROM Deleted AS d) 
	DELETE FROM Venta WHERE NroFactura IN (SELECT d.NroFactura FROM Deleted AS d)
END

-- Prueba

SELECT * FROM Venta
SELECT * FROM DetalleVenta

DELETE FROM Venta WHERE NroFactura = 1

SELECT * FROM HistoricoVentas
SELECT * FROM HistoricoDetalleVentas
