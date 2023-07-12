/* Ejercicio 12: Dado el siguiente esquema de relacion:
	Producto (CodProd, Descripcion, CodProv, StockActual)
	Stock (Nro, Fecha, CodProd, Cantidad)
	Proveedor (CodProv, RazonSocial, FechaInicio)

Realizar las siguientes tareas utilizando lenguaje SQL	*/

-- 1. p_EliminaSinstock(): Realizar un procedimiento que elimine los productos que no poseen stock.

GO

CREATE OR ALTER PROCEDURE p_EliminaSinstock AS
BEGIN
	DELETE FROM Producto WHERE CodProd IN (SELECT p.CodProd
										   FROM Producto AS p
										   WHERE p.CodProd NOT IN (SELECT DISTINCT s.CodProd
																   FROM Stock AS s))
END

GO

-- Otra resolucion

CREATE PROCEDURE p_EliminaSinstockV2 AS
BEGIN
	DELETE FROM Producto WHERE CodProd IN (SELECT p.CodProd 
											FROM Stock AS s RIGHT JOIN Producto AS p ON s.CodProd=p.CodProd 
											WHERE ISNULL(s.Cantidad,0) = 0)
END

GO

-- Prueba
EXECUTE p_EliminaSinstock

-- Para borrarlo: DROP PROCEDURE p_EliminaSinstock 

-----------------------------------------------------------------------------------------------------------
/* 2. p_ActualizaStock(): Para los casos que se presenten inconvenientes en los datos, se necesita realizar 
un procedimiento que permita actualizar todos los Stock_Actual de los productos, tomando los datos de la
entidad Stock. Para ello, se utilizara como stock valido la ultima fecha en la cual se haya cargado el 
stock.*/

GO

CREATE OR ALTER VIEW v_Productos_Ultima_Fecha_Stock AS (
	SELECT s.CodProd, MAX(s.Fecha) AS 'Ultima Fecha'
	FROM Stock AS s
	GROUP BY s.CodProd
)

GO

CREATE OR ALTER PROCEDURE p_ActualizaStock AS
BEGIN
	DECLARE @cantidadProductos INT = (SELECT COUNT(*) 'Cantidad de productos' FROM Producto)
	DECLARE @cantidadStock INT;
	WHILE(@cantidadProductos > 0)
	BEGIN
		SET @cantidadStock = ISNULL((SELECT MAX(s.Cantidad)
								     FROM v_Productos_Ultima_Fecha_Stock AS pufs INNER JOIN Stock AS s ON 
									 (pufs.CodProd = s.CodProd AND pufs.[Ultima Fecha] = s.Fecha)
								     WHERE pufs.CodProd = @cantidadProductos),0)
		UPDATE Producto
		SET StockActual = @cantidadStock
		WHERE CodProd = @cantidadProductos

		SET @cantidadProductos = @cantidadProductos - 1
	END
END

GO

EXECUTE p_ActualizaStock

-- Otro wachin

GO

CREATE OR ALTER PROCEDURE p_ActualizarStockV2 AS 
BEGIN
	DECLARE @IdProducto int, @Stock int  
	SET @IdProducto = (SELECT MAX(s.CodProd) FROM Stock AS s)
	WHILE(@IdProducto > 0) 
	BEGIN
		SET @Stock = ISNULL((SELECT TOP 1 s.Cantidad 
							 FROM Stock AS s 
							 WHERE s.CodProd = @IdProducto 
							 ORDER BY s.Fecha DESC),0)
		UPDATE Producto  
		SET StockActual = @Stock
		WHERE CodProd = @IdProducto 
		SET @IdProducto = @IdProducto - 1
	END
END

GO

-----------------------------------------------------------------------------------------------------------
-- 3. p_DepuraProveedor(): Realizar un procedimiento que permita depurar todos los proveedores de los 
-- cuales no se posea stock de ningun producto provisto desde hace mas de 1 anio.

GO

CREATE OR ALTER PROCEDURE p_DepurarProveedor AS 
BEGIN
	DELETE Proveedor
	WHERE CodProv IN (SELECT prov.CodProv
					  FROM Stock AS s INNER JOIN Producto AS prod ON s.CodProd = prod.CodProd 
						   INNER JOIN Proveedor AS prov ON prov.CodProv = prod.CodProv
					  WHERE s.Fecha < DATEADD(YY,-1,GETDATE()))
END

GO

EXECUTE p_DepurarProveedor

-----------------------------------------------------------------------------------------------------------
/* 4. p_InsertStock(nro,fecha,prod,cantidad): Realizar un procedimiento que permita agregar stocks de 
productos. Al realizar la insercion se debera validar que:

a. El producto debe ser un producto existente
b. La cantidad de stock del producto debe ser cualquier numero entero mayor a cero.
c. El numero de stock sera un valor correlativo que se ira agregando por cada nuevo stock de producto.*/

GO

CREATE OR ALTER PROCEDURE p_InsertartStock (@nro INT OUTPUT, @fecha DATE, @codProd INT, @cantidad INT) AS
BEGIN
	DECLARE @aux int
	SET @aux = ISNULL((SELECT p.CodProd 
					   FROM Producto AS p 
					   WHERE p.CodProd = @codProd),-1) -- item a)
	-- Si el producto es un producto inexistente (NULL) retorna -1 y por lo tanto no entra al IF
	SET @nro = (SELECT MAX(s.Nro) 
				FROM Stock AS s) + 1	
	-- El numero de Stock es consecutivo e incremental (Fijarse que es una variable OUTPUT)
	IF(@aux > 0) 
	BEGIN  
		IF(@cantidad > 0) -- item b)
		-- Si la variable cantidad que se le asigna no es mayor a cero, tampoco inserta nada
		BEGIN  
			 SET @cantidad = @cantidad + ISNULL((SELECT SUM(s.Cantidad) 
												 FROM Stock AS s 
												 WHERE s.CodProd = @codProd),0) --item c)
			 -- En esta linea se le suma lo que anteriomente tenia en Stock, lo mismo seria en C como cantidad += nuevaCantidad
			 -- En el caso de que ese producto sea la primera vez que se encuentra en Stock (NULL) se le deberea sumar 0 ya que no habia nada anteriormente
			 -- Para este ultimo caso seria igual a cantidad = nuevaCantidad + 0
			 INSERT INTO Stock VALUES(@nro, @fecha, @codProd, @cantidad)
		END
	END
END

GO

-- Prueba
DECLARE @nro INT
DECLARE @fecha DATE = '2020-02-29'
DECLARE @codProd INT = 2
DECLARE @cantidad INT = 50
EXECUTE p_InsertartStock @nro, @fecha, @codProd, @cantidad

SELECT *
FROM Stock AS s

/* 5. tg_CrearStock: Realizar un trigger que permita automaticamente agregar un registro en la entidad 
Stock, cada vez que se inserte un nuevo producto. El stock inicial a tomar, sera el valor del campo 
StockActual.*/

GO

CREATE OR ALTER TRIGGER tg_CrearStock ON Producto AFTER INSERT AS
BEGIN
	DECLARE @NumeroStock INT = COALESCE((SELECT MAX(s.Numero) FROM Stock AS s) + 1, 1)
	DECLARE @CodProd INT = (SELECT i.CodProd FROM Inserted AS i)
	DECLARE @Cantidad INT = (SELECT i.StockActual FROM Inserted AS i)
	INSERT INTO Stock VALUES (@NumeroStock, GETDATE(), @CodProd, @Cantidad)
END

GO

INSERT INTO Producto (CodProd, Descripcion, CodProv, StockActual) VALUES (11,'Monitor Curvo',3,40)

/* 6. p_ListaSinStock(): Crear un procedimiento que permita listar los productos que no posean stock en 
este momento y que no haya ingresado ninguno en este ultimo mes. De estos productos, listar el codigo 
y nombre del producto, razon social del proveedor y stock que se tenia al mes anterior.*/

GO

CREATE PROCEDURE p_ListaSinStock AS
BEGIN
	SELECT prod.CodProd,prod.Descripcion,prov.RazonSocial,s.Cantidad
	FROM Producto AS prod INNER JOIN Stock AS s ON prod.CodProd = s.CodProd 
						  INNER JOIN Proveedor AS prov ON prov.CodProv = prod.CodProv
	WHERE prod.CodProd IN ( -- Productos que no poseen stock actualmente
							SELECT p.CodProd
							FROM Producto AS p
							WHERE p.StockActual = 0
							INTERSECT
							-- Productos que poseen (o poseian) stock pero no se ingreso en este ultimo mes
							SELECT s.CodProd--, MAX(s.Fecha) AS UltimaFechaStock
							FROM Stock AS s
							GROUP BY s.CodProd
							HAVING MAX(s.Fecha) < GETDATE() - DAY(GETDATE())
						  )
END

GO

EXECUTE p_ListaSinStock

/* 7. p_ListaStock(): Realizar un procedimiento que permita generar el siguiente reporte:

							Fecha			>1000		<1000		=0
							01/08/2009		100			8			3
							03/08/2009		53			50			7
							04/08/2009		50			20			40
							.....			.....		.....		.....

En este listado se observa que se contara la cantidad de productos que posean a una determinada fecha 
mas de 1000 unidades, menos de 1000 unidades o que no existan unidades de ese producto.
Segun el ejemplo, el 01/08/2009 existen 100 productos que poseen mas de 1000 unidades, en cambio el 
03/08/2009 solo hubo 53 productos con mas de 1000 unidades.*/

GO

-- Productos con mas de 1000 unidades
CREATE OR ALTER VIEW v_Productos_por_fecha_mayor_a_1000 AS (
	SELECT s.Fecha, s.CodProd, SUM(s.Cantidad) 'Cantidad'
	FROM Stock AS s INNER JOIN Producto AS p ON s.CodProd = p.CodProd
	GROUP BY s.Fecha, s.CodProd
	HAVING SUM(s.Cantidad) > 1000
)

GO

CREATE OR ALTER VIEW v_aux_mayor_mil AS (
	SELECT cpf.Fecha, COUNT(*) 'Cantidad de productos con mas de mil unidades'
	FROM v_Productos_por_fecha_mayor_a_1000 AS cpf
	GROUP BY cpf.Fecha
)

GO

-- Productos con menos de 1000 unidades

GO

CREATE OR ALTER VIEW v_Productos_por_fecha_menor_a_1000 AS (
	SELECT s.Fecha, s.CodProd, SUM(s.Cantidad) 'Cantidad'
	FROM Stock AS s INNER JOIN Producto AS p ON s.CodProd = p.CodProd
	GROUP BY s.Fecha, s.CodProd
	HAVING SUM(s.Cantidad) < 1000
)

GO

CREATE OR ALTER VIEW v_aux_menor_mil AS (
	SELECT cpf.Fecha, COUNT(*) 'Cantidad de productos con menos de mil unidades'
	FROM v_Productos_por_fecha_menor_a_1000 AS cpf
	GROUP BY cpf.Fecha
)

GO

-- Productos sin unidades

GO

CREATE OR ALTER VIEW v_Productos_sin_cantidad_por_fecha AS (
	SELECT s.Fecha, p.CodProd
	FROM Stock AS s CROSS JOIN Producto AS p
	EXCEPT
	SELECT s.Fecha, s.CodProd
	FROM Stock AS s
)

GO

CREATE OR ALTER VIEW v_aux_ceros AS (
	SELECT pscpf.Fecha, COUNT(*) 'Cantidad de productos sin unidades'
	FROM v_Productos_sin_cantidad_por_fecha AS pscpf
	GROUP BY pscpf.Fecha
)

GO

-- Respuesta
SELECT DISTINCT s.Fecha, ISNULL(amay.[Cantidad de productos con mas de mil unidades],0) '> 1000',
						 ISNULL(amen.[Cantidad de productos con menos de mil unidades],0) '< 1000',
						 ISNULL(acer.[Cantidad de productos sin unidades],0) '= 0' 
FROM Stock AS s LEFT JOIN v_aux_mayor_mil AS amay ON s.Fecha = amay.Fecha
			    LEFT JOIN v_aux_menor_mil AS amen ON s.Fecha = amen.Fecha
				LEFT JOIN v_aux_ceros AS acer ON s.Fecha = acer.Fecha

/* 8. El siguiente requerimiento consiste en actualizar el campo StockActual de la entidad Producto, cada 
vez que se altere una cantidad (positiva o negativa) de ese producto. El stock actual reflejara el stock 
que exista del producto, sabiendo que en la entidad Stock se almacenara la cantidad que ingrese o egrese. 
Ademas, se debe impedir que el campo [StockActual] pueda ser actualizado manualmente. Si esto sucede, 
se debera dar marcha atras a la operacion indicando que no esta permitido.*/

GO

CREATE OR ALTER TRIGGER tg_Actualizar_StockActual ON Stock AFTER INSERT AS
BEGIN
	DECLARE @CantidadVieja INT = (SELECT p.StockActual FROM Producto AS p WHERE p.CodProd IN (SELECT d.CodProd FROM Inserted AS d))
	DECLARE @CantidadNueva INT = (SELECT i.Cantidad FROM Inserted AS i)
	IF (@CantidadNueva < @CantidadVieja)
		UPDATE Producto SET StockActual = (@CantidadVieja - @CantidadNueva) WHERE CodProd IN (SELECT d.CodProd FROM Inserted AS d)
END

GO

INSERT INTO Stock (Numero, Fecha, CodProd, Cantidad) VALUES (10,GETDATE(),1,15)

GO

CREATE OR ALTER TRIGGER tg_Impedir_Actualizar_StockActual ON Producto AFTER UPDATE AS
BEGIN
	DECLARE @StockViejo INT = (SELECT i.StockActual FROM Deleted AS i)
	DECLARE @StockNuevo INT = (SELECT i.StockActual FROM Inserted AS i)
	IF (@StockViejo != @StockNuevo)
	BEGIN
		UPDATE Producto SET StockActual = @StockViejo WHERE CodProd IN (SELECT i.CodProd FROM Inserted AS i)
		--PRINT 'No es posible actualizar manualmente el stock actual'
		RAISERROR ('No es posible actualizar manualmente el stock actual',11,1);
	END
END

GO

UPDATE Producto SET StockActual = 100 WHERE CodProd = 2