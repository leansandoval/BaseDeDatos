-- 0. SETEO DE DB
USE Ejercicio_2
GO

/*
Proveedor (NroProv, NomProv, Categoria, CiudadProv)
Artículo  (NroArt, Descripción, CiudadArt, Precio)
Cliente   (NroCli, NomCli, CiudadCli)
Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
Stock     (NroArt, fecha, cantidad)
*/

-- 1. Hallar el código (NroProv) de los proveedores que proveen el artículo Art146.

SELECT DISTINCT p.NroProv
FROM Pedido AS p JOIN Articulo AS a ON p.NroArt = a.NroArt
WHERE a.Descripcion = 'Art146'

-- 2. Hallar los clientes (NomCli) que solicitan artículos provistos por Prov015.

SELECT DISTINCT c.NomCli
FROM Pedido AS ped JOIN Proveedor pro ON ped.NroProv = pro.NroProv JOIN Cliente c ON ped.NroCli = c.NroCli
WHERE pro.NomProv = 'Prov015'

--3. Hallar los clientes que solicitan algún item provisto por proveedores con categoría mayor que 4.

SELECT ped.NroCli
FROM Pedido AS ped JOIN Proveedor AS pro ON ped.NroProv = pro.NroProv
WHERE pro.Categoria > 4

-- 4. Hallar los pedidos en los que un cliente de Rosario solicita artículos producidos en la ciudad de Mendoza.

SELECT p.NroPed
FROM Pedido AS p JOIN Cliente AS c ON p.NroCli = c.NroCli JOIN Articulo AS a ON a.NroArt = p.NroArt
WHERE c.CiudadCli = 'Rosario' AND a.CiudadArt = 'Mendoza'

-- 5. Hallar los pedidos en los que el cliente Cli23 solicita artículos solicitados por el cliente Cli30.

CREATE OR ALTER VIEW vArticulosPedidosPorCli23YCli30 AS
(
	SELECT p.NroArt
	FROM Pedido AS p JOIN Cliente AS c ON p.NroCli = c.NroCli
	WHERE c.NomCli = 'Cli23'
	INTERSECT
	SELECT p.NroArt
	FROM Pedido AS p JOIN Cliente AS c ON p.NroCli = c.NroCli
	WHERE c.NomCli = 'Cli30'
)

SELECT p.*, c.*
FROM vArticulosPedidosPorCli23YCli30 AS v JOIN Pedido AS p ON v.NroArt = p.NroArt JOIN Cliente AS c ON p.NroCli = c.NroCli

/* Otra forma: Estos son los pedidos que el Cliente 23 los solicita pero ademas tambien son solicidatos por 
el cliente 30. Es por eso que se uso un IN para encontrar los NroArt que solicitaban ambos.*/

SELECT p.*
FROM Pedido AS p JOIN Cliente AS c ON c.NroCli = p.NroCli
WHERE c.NomCli = 'Cli23' AND p.NroArt IN (SELECT p.NroArt
										FROM Pedido AS p JOIN Cliente AS c ON c.NroCli = p.NroCli
										WHERE C.NomCli = 'Cli30')

-- 6. Hallar los proveedores que suministran todos los artículos cuyo precio es superior al precio promedio de los artículos que se producen en La Plata.

CREATE OR ALTER VIEW vArticulosConPrecioSuperiorAlPrecioPromedioDeArticulosEnLaPlata AS
(
	SELECT a.NroArt
	FROM Articulo AS a
	WHERE a.Precio > (SELECT AVG(a.Precio) 
					FROM Articulo AS a 
					WHERE a.CiudadArt = 'La Plata')
)

SELECT pro.NroProv
FROM Proveedor AS pro
WHERE NOT EXISTS (
		SELECT 1
		FROM vArticulosConPrecioSuperiorAlPrecioPromedioDeArticulosEnLaPlata AS a
		WHERE NOT EXISTS (
				SELECT 1
				FROM Pedido AS ped
				WHERE ped.NroArt = a.NroArt AND ped.NroProv = pro.NroProv
					)
				)

-- Prueba:

INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (7,2,1,GETDATE(),8,2800)
DELETE FROM Pedido WHERE NroPed = 34

-- 7. Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee a todos los clientes de Junín.

CREATE OR ALTER VIEW vProvQueProveenATodosLosCliDeJunin AS
(
	SELECT pro.NroProv
	FROM Proveedor AS pro
	WHERE NOT EXISTS (
					SELECT 1
					FROM Cliente AS c
					WHERE c.CiudadCli = 'Junín' 
					AND NOT EXISTS (
									SELECT 1
									FROM Pedido AS ped
									WHERE ped.NroCli = c.NroCli AND ped.NroProv = pro.NroProv
									)
					)
)

SELECT p.NroProv, COUNT(DISTINCT p.NroArt) AS [Cantidad articulos]
FROM Pedido AS p 
WHERE p.NroProv IN	(SELECT v.NroProv FROM vProvQueProveenATodosLosCliDeJunin AS v)
GROUP BY p.NroProv

----------------------------------------------------------------------------------------------------------------------

-- Todos los clientes de junin

SELECT COUNT (NroCli) [Cantidad de Clientes]
FROM CLIENTE 
WHERE CiudadCli LIKE 'Jun_n'

-- Provedores que provee a todos los clientes de Junin

SELECT p.NroProv, COUNT(DISTINCT c.NroCli) AS [Cantidad de Clientes]
FROM Pedido p JOIN Cliente c ON p.NroCli = c.NroCli
WHERE c.CiudadCli LIKE 'Jun_n'
GROUP BY p.NroProv
HAVING COUNT(DISTINCT c.NroCli) =	(
									SELECT COUNT (c.NroCli)
									FROM Cliente c
									WHERE CiudadCli LIKE 'Jun_n'
									)
ORDER BY p.NroProv

-- Todos los articulos diferentes que proveen los proveedores

SELECT DISTINCT NroProv, NroArt
FROM Pedido
ORDER BY NroProv

-- Hallar la cantidad de artículos diferentes provistos por cada proveedor que provee a todos los clientes de Junín.

SELECT t.*, a.NroArt
FROM 
	(
	SELECT p.NroProv, COUNT(DISTINCT c.NroCli) AS [Cantidad de Clientes]
	FROM Pedido p JOIN Cliente c ON p.NroCli = c.NroCli
	WHERE c.CiudadCli LIKE 'Jun_n'
	GROUP BY p.NroProv
	HAVING COUNT(DISTINCT c.NroCli) = (SELECT COUNT (c.NroCli) FROM Cliente c WHERE CiudadCli LIKE 'Jun_n')
	) AS t
	JOIN 
	(
	SELECT DISTINCT NroProv, NroArt
	FROM Pedido
	) AS a
	ON t.NroProv = a.NroProv
ORDER BY t.NroProv


-- 8. Hallar los nombres de los proveedores cuya categoría sea mayor que la de todos los proveedores que proveen el artículo cuaderno.

SELECT p.NomProv
FROM Proveedor AS p
WHERE p.Categoria > (
					SELECT MAX(pro.Categoria) AS [Max cat prov de cuardernos]
					FROM Articulo AS a JOIN Pedido AS ped ON a.NroArt = ped.NroArt JOIN Proveedor AS pro ON ped.NroProv = pro.NroProv
					WHERE a.Descripcion = 'Cuaderno'
					)

----------------------------------------------------------------------------------------------------------------------

-- PROVEEDORES CON LA CATEGORIA MAYOR

SELECT *
FROM Proveedor AS p
WHERE p.Categoria = (
					SELECT MAX(p.Categoria) as [MaxCategoria]
					FROM Proveedor AS p
				  )
ORDER BY NroProv

-- PROV DE ART CUADERNO

SELECT DISTINCT p.NroProv
FROM Articulo a JOIN Pedido p ON a.NroArt = p.NroArt
WHERE Descripcion LIKE '%cuaderno%'	-- cuaderno tapa dura | cuaderno espiralado | nuevo cuaderno. Cordoba Córdoba 

-- Categoria de los prov de cuadernos

SELECT DISTINCT p.NroProv, pr.Categoria
FROM Articulo a JOIN Pedido p ON a.NroArt = p.NroArt JOIN Proveedor pr ON p.NroProv = pr.NroProv
WHERE Descripcion LIKE '%cuaderno%' -- cuaderno tapa dura | cuaderno espiralado | nuevo cuaderno. Cordoba Córdoba 

-- Max categoria de los prov de cuadernos

SELECT MAX (pr.Categoria) [Max Categoria De Prov De Cuadernos]
FROM Articulo a JOIN Pedido p ON a.NroArt = p.NroArt JOIN Proveedor pr ON p.NroProv = pr.NroProv
WHERE Descripcion LIKE '%cuaderno%' -- cuaderno tapa dura | cuaderno espiralado | nuevo cuaderno. Cordoba Córdoba 

-- Hallar los nombres de los proveedores cuya categoría sea mayor que la de todos los proveedores que proveen el artículo cuaderno.

SELECT * 
FROM Proveedor 
WHERE Categoria >
		(
		SELECT MAX (pr.Categoria) [Max Categoria De Prov De Cuadernos]
		FROM Articulo a JOIN Pedido p ON a.NroArt = p.NroArt JOIN Proveedor pr ON p.NroProv = pr.NroProv
		WHERE Descripcion LIKE '%cuaderno%' -- cuaderno tapa dura | cuaderno espiralado | nuevo cuaderno. Cordoba Córdoba 
		)
ORDER BY NomProv

-- 9. Hallar los proveedores que han provisto más de 1000 unidades entre los artículos 1 y 100 .

SELECT p.NroProv, SUM(p.Cantidad) AS Unidades
FROM Pedido AS p
WHERE p.NroArt BETWEEN 1 AND 100
GROUP BY p.NroProv
HAVING SUM(p.Cantidad) > 1000

----------------------------------------------------------------------------------------------------------------------

SELECT p.NroProv, SUM(p.Cantidad) AS [Cantidad total art 1 y 100]
FROM Pedido AS p
WHERE p.NroArt IN (1, 100)
GROUP BY p.NroProv
HAVING SUM(p.Cantidad) > 1000
ORDER BY p.NroProv

-- Otra forma de ver la misma info

SELECT p1.NroProv, ISNULL(p1.totalP1, 0) AS Total1, ISNULL(P100.totalP100, 0) AS Total100, ISNULL(p1.totalP1, 0) + ISNULL(P100.totalP100, 0) AS [Total = p1 + p100]
FROM (
	SELECT NroProv, SUM(Cantidad) AS TotalP1
	FROM Pedido  
	WHERE NroArt = 1
	GROUP BY NroProv
	) AS p1
FULL JOIN 
	(
	SELECT NroProv, SUM(Cantidad) AS TotalP100
	FROM Pedido  
	WHERE NroArt = 100
	GROUP BY NroProv
	) AS p100
ON p1.NroProv = p100.NroProv

-- 10. Listar la cantidad y el precio total de cada artículo que han pedido los Clientes 
-- a sus proveedores entre las fechas 01-01-2004 y 31-03-2004 (Se requiere visualizar Cliente, Articulo, Proveedor, Cantidad y Precio).

SELECT p.NroArt, p.NroCli, p.NroProv, SUM(p.Cantidad) AS [Cantidad Total], SUM(p.PrecioTotal) AS [Precio Total]
FROM Pedido AS p
WHERE p.FechaPedido BETWEEN '01-01-2004' AND '31-03-2004'
GROUP BY p.NroArt, p.NroCli, p.NroProv

-- 11. Idem anterior y que además la Cantidad sea mayor o igual a 1000 o el Precio sea mayor a $1000

SELECT p.NroArt, p.NroCli, p.NroProv, SUM(p.Cantidad) [Cantidad Total], SUM(p.PrecioTotal) [Precio Total]
FROM Pedido p
WHERE p.FechaPedido BETWEEN '01-01-2004' AND '31-03-2004'
GROUP BY p.NroArt, p.NroCli, p.NroProv
HAVING SUM(p.PrecioTotal) > 1000 OR SUM(p.Cantidad) >= 1000

-- 12. Listar la descripción de los artículos en donde se hayan pedido en el día más del stock existente para ese mismo día.

SELECT a.Descripcion
FROM Stock AS s JOIN Pedido AS p ON s.NroArt = p.NroArt JOIN Articulo AS a ON p.NroArt = a.NroArt
WHERE s.Fecha = p.FechaPedido AND p.Cantidad > s.Cantidad

-- 13. Listar los datos de los proveedores que hayan pedido de todos los artículos en un mismo día. Verificar sólo en el último mes de pedidos.

SELECT p.NroProv, COUNT(DISTINCT p.NroArt) AS [Cant Articulos Provistos]
FROM Pedido AS p
WHERE p.FechaPedido BETWEEN DATEADD(MONTH, -1, GETDATE()) AND GETDATE()
GROUP BY p.NroProv
HAVING COUNT(DISTINCT p.NroArt)	= (
								 SELECT COUNT(a.NroArt) AS [Cant Articulos Totales]
								 FROM Articulo AS a
								 )

-- 14. Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el último mes, pero sí se les haya pedido en el mismo mes del año anterior.

CREATE OR ALTER VIEW vProveedoresSinArticulosEnElUltimoMes AS
(
	SELECT pro.NroProv
	FROM Proveedor AS pro
	EXCEPT
	SELECT DISTINCT ped.NroProv
	FROM Pedido AS ped
	WHERE ped.FechaPedido BETWEEN DATEADD(MONTH, -1, GETDATE()) AND GETDATE()
)

SELECT p.NroProv
FROM vProveedoresSinArticulosEnElUltimoMes AS v JOIN Pedido AS p ON v.NroProv = p.NroProv
WHERE p.FechaPedido BETWEEN DATEADD(YEAR, -1, DATEADD(MONTH, -1, GETDATE())) AND DATEADD(YEAR, -1, GETDATE())

-- 15. Listar los nombres de los clientes que hayan solicitado más de un artículo cuyo precio sea superior a $100
-- y que correspondan a proveedores de Capital Federal. Por ejemplo, se considerará si se ha solicitado el artículo a2 y a3, 
-- pero no si solicitaron 5 unidades del articulo a2.

SELECT ped.NroCli, COUNT(DISTINCT ped.NroArt) AS [Cant articulos provistos]
FROM Pedido AS ped JOIN Articulo AS a ON ped.NroArt = a.NroArt JOIN Proveedor AS pro ON ped.NroProv = pro.NroProv
WHERE a.Precio > 100 AND pro.CiudadProv = 'Capital Federal'
GROUP BY ped.NroCli
HAVING COUNT(DISTINCT ped.NroArt) > 1

/*======================================================================================================================================*/

-- TRABAJO CON FECHAS
SELECT GETDATE() [Fecha hoy], DATEADD(MONTH, -1, GETDATE()) [Un mes para atras], YEAR(GETDATE()) [Año], MONTH(GETDATE()) [Mes], DAY(GETDATE()) [Dia]

-- Proveedores que tuvieron pedidos durante el ultimo mes
SELECT *
FROM Pedido p
WHERE p.FechaPedido >= DATEADD(MONTH, -1, GETDATE()) AND p.FechaPedido <= GETDATE()

-- Proveedores que NO tuvieron pedidos durante el ultimo mes
SELECT *
FROM Proveedor pr
WHERE NOT EXISTS 
				(
				SELECT *
				FROM Pedido p
				WHERE p.FechaPedido >= DATEADD(MONTH, -1, GETDATE()) AND p.FechaPedido <= GETDATE() AND p.NroProv = pr.NroProv
				)

-- FECHAS DEL AÑO PASADO

SELECT DATEADD(YEAR ,-1, DATEADD(MONTH, -1, GETDATE())) [Año pasado y mes anterior],  DATEADD(YEAR, -1, GETDATE()) [Año pasado]

-- Proveedores que SI tuvieron pedidos durante el ultimo mes, pero del año anterior

SELECT *
FROM Pedido p
WHERE p.FechaPedido >= DATEADD(YEAR ,-1, DATEADD(MONTH, -1, GETDATE())) AND p.FechaPedido <= DATEADD(YEAR, -1, GETDATE())

--Listar los proveedores a los cuales no se les haya solicitado ningún artículo en el último mes, pero sí se les haya pedido en el mismo mes del año anterior.

SELECT pr.NroProv
FROM Proveedor pr
WHERE NOT EXISTS 
				(
				SELECT *
				FROM Pedido p
				WHERE p.FechaPedido >= DATEADD(MONTH, -1, GETDATE()) AND p.FechaPedido <= GETDATE() AND p.NroProv = pr.NroProv
				)
INTERSECT -- INTERSECT | UNION | UNION ALL | MINUS | SUBSTRACT
SELECT NroProv
FROM Pedido p
WHERE p.FechaPedido >= DATEADD(YEAR ,-1, DATEADD(MONTH, -1, GETDATE())) AND p.FechaPedido <= DATEADD(YEAR, -1, GETDATE())

-- datediff		= Muestra diferencia entre dos fechas
-- dateadd		= Agregar o substrae respecto de una fecha. puedo agregarle a una fecha dada, X segundos o Y minutos, o Z dias, etc 
-- getdate/now	= Retorna la fecha de hoy