/*Ejercicio 7: Dada la siguiente base de datos

	Auto	(Matricula, Modelo, Anio)
	Chofer	(NroLicencia, Nombre, Apellido, FechaIngreso, Telefono)
	Viaje	(FechaHoraInicio, FechaHoraFin, Chofer, Cliente, Auto, KmTotales, EsperaTotal, CostoEspera, CostoKms)
	Cliente	(NroCliente, Calle, Nro, Localidad)*/

-- 1. Indique cuales son los autos con mayor cantidad de kilometros realizados en el �ltimo mes.

GO

CREATE OR ALTER VIEW vCantidadDeKmPorAutoEnElUltimoMes AS (
	SELECT v.Auto, SUM(v.KmTotales) [Cantidad de kilometros]
	FROM Viaje AS v
	WHERE v.FechaHoraInicio >= DATEADD(MONTH, -1, GETDATE()) AND v.FechaHoraFin <= GETDATE()
	GROUP BY v.Auto
)

GO

SELECT v.Auto
FROM vCantidadDeKmPorAutoEnElUltimoMes AS v
WHERE v.[Cantidad de kilometros] = (SELECT MAX([Cantidad de kilometros]) FROM vCantidadDeKmPorAutoEnElUltimoMes)

-- 2. Indique los clientes que mas viajes hayan realizado con el mismo chofer.

GO

CREATE OR ALTER VIEW vCantidadDeViajesSegunChoferYCliente AS (
	SELECT v.Cliente, v.Chofer, COUNT(*) [Cantidad de viajes]
	FROM Viaje AS v
	GROUP BY v.Cliente, v.Chofer
)

GO

SELECT *
FROM vCantidadDeViajesSegunChoferYCliente AS v1
WHERE v1.[Cantidad de viajes] = (SELECT MAX([Cantidad de viajes])
								FROM vCantidadDeViajesSegunChoferYCliente)

-- 3. Indique el o los clientes con mayor cantidad de viajes en este anio.

GO

CREATE OR ALTER VIEW vCantidadDeViajesPorClienteEnEsteAnio AS (
	SELECT v.Cliente, COUNT(*) [Cantidad de viajes]
	FROM Viaje AS v
	WHERE YEAR(v.FechaHoraFin) = YEAR(GETDATE()) AND YEAR(v.FechaHoraInicio) = YEAR(GETDATE())
	GROUP BY v.Cliente
)

GO

SELECT *
FROM vCantidadDeViajesPorClienteEnEsteAnio AS v
WHERE v.[Cantidad de viajes] = (SELECT MAX([Cantidad de viajes]) 
								FROM vCantidadDeViajesPorClienteEnEsteAnio)

-- 4. Obtenga nombre y apellido de los choferes que no manejaron todos los vehiculos que disponemos.

GO

CREATE VIEW vChoferesQueNoManejaronTodosLosAutos AS (
	SELECT c.NroLicencia
	FROM Chofer AS c
	EXCEPT
	SELECT v.Chofer
	FROM Viaje AS v
	GROUP BY v.Chofer 
	HAVING COUNT(DISTINCT v.Auto) = (SELECT COUNT(*) FROM Auto)
)

GO

SELECT c.Nombre, c.Apellido
FROM vChoferesQueNoManejaronTodosLosAutos AS v JOIN Chofer AS c ON v.NroLicencia = c.NroLicencia

-- 5. Obtenga el nombre y apellido de los clientes que hayan viajado en todos nuestros autos.

SELECT v.Cliente
FROM Viaje AS v
GROUP BY v.Cliente
HAVING COUNT(DISTINCT v.Auto) = (SELECT COUNT(*) FROM Auto)

-- 6. Queremos conocer el tiempo de espera promedio de los viajes de los ultimos 2 meses

SELECT AVG(v.EsperaTotal) [Tiempo promedio]
FROM Viaje AS v
WHERE v.FechaHoraInicio >= DATEADD(MONTH, -2, GETDATE()) AND v.FechaHoraFin <= GETDATE()

-- 7. Indique los kilometros realizados en viajes por cada auto.

SELECT v.Auto, SUM(v.KmTotales) [Kilometros totales]
FROM Viaje AS v
GROUP BY v.Auto

-- 8. Indique el costo promedio de los viajes realizados por cada auto.

SELECT v.Auto, CAST(ROUND(AVG(v.CostoKms), 2)AS DECIMAL(10,2)) AS [Costo promedio]
FROM Viaje AS v
GROUP BY v.Auto

-- Fuente: 
-- https://www.sqlservertutorial.net/sql-server-aggregate-functions/sql-server-avg/
-- https://www.w3schools.com/sql/func_sqlserver_round.asp

-- 9. Indique el costo total de los viajes realizados por cada chofer en el ultimo mes.

SELECT v.Chofer, SUM(v.CostoEspera) AS [Costo total]
FROM Viaje AS v
WHERE v.FechaHoraInicio >= DATEADD(MONTH, -1, GETDATE()) AND v.FechaHoraFin <= GETDATE()
GROUP BY v.Chofer

-- 10. Indique la fecha inicial, el chofer y el cliente que hayan realizado el viaje mas largo de este anio.

GO

CREATE OR ALTER VIEW vViajesEnElUltimoAnio AS (
	SELECT v.FechaHoraInicio, v.Chofer, v.Cliente, v.KmTotales
	FROM Viaje AS v
	WHERE YEAR(v.FechaHoraFin) = YEAR(GETDATE()) AND YEAR(v.FechaHoraInicio) = YEAR(GETDATE())
)

GO

SELECT v.FechaHoraInicio, v.Chofer, v.Cliente
FROM vViajesEnElUltimoAnio AS v
WHERE v.KmTotales = (SELECT MAX(KmTotales) FROM vViajesEnElUltimoAnio)