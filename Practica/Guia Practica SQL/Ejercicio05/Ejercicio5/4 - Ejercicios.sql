/*Ejercicio 5: Dada la siguiente base de datos

	Pelicula (CodPel, Titulo, Duracion, Anio, CodRubro)
	Rubro (CodRubro, NombRubro)
	Ejemplar (CodEj, CodPel, Estado, Ubicacion)	Estado: Libre, Ocupado
	Cliente (CodCli, Nombre, Apellido, Direccion, Tel, Email)
	Prestamo (CodPrest, CodEj, CodPel, CodCli, FechaPrest, FechaDev)

Nota: FechaDev -> Se carga cuando el cliente efectia la devolucion del ejemplar.*/

-- 1. Listar los clientes que no hayan reportado prestamos del rubro 'Policial'.

SELECT c.CodCli
FROM Cliente AS c
EXCEPT
SELECT pre.CodCli
FROM Prestamo AS pre JOIN Pelicula AS pel ON pre.CodPel = pel.CodPel JOIN Rubro AS r ON r.CodRubro = pel.CodRubro
WHERE r.NombRubro LIKE 'Policial'

-- 2. Listar las peliculas de mayor duracion que alguna vez fueron prestadas.

SELECT DISTINCT pel.*
FROM Pelicula AS pel JOIN Prestamo AS pre ON pel.CodPel = pre.CodPel
WHERE pel.Duracion = (SELECT MAX(pel.Duracion) 
					  FROM Pelicula AS pel JOIN Prestamo AS pre ON pel.CodPel = pre.CodPel)

-- 3. Listar los clientes que tienen mas de un prestamo sobre la misma pelicula 
-- (listar Cliente, Pelicula y cantidad de prestamos).

SELECT p.CodCli, p.CodPel
FROM Prestamo AS p
GROUP BY p.CodCli, p.CodPel
HAVING COUNT(p.CodPrest) > 1

-- 4. Listar los clientes que han realizado prestamos del titulo [Rey Leon] y [Terminador3] (Ambos).

SELECT pre.CodCli
FROM Prestamo AS pre JOIN Pelicula AS pel ON pre.CodPel = pel.CodPel
WHERE pel.Titulo LIKE 'Rey Le_n'
INTERSECT
SELECT pre.CodCli
FROM Prestamo AS pre JOIN Pelicula AS pel ON pre.CodPel = pel.CodPel
WHERE pel.Titulo LIKE 'Terminador_3'

-- 5. Listar las peliculas mas vistas en cada mes (Mes, Pelicula, Cantidad de Alquileres).

GO

CREATE OR ALTER VIEW vCantidadDeVistasDePeliculasPorMes AS (
	SELECT MONTH(pre1.FechaPrest) AS Mes, pre1.CodPel, COUNT(*) [Cantidad de vistas]
	FROM Prestamo AS pre1
	GROUP BY MONTH(pre1.FechaPrest), pre1.CodPel
)

GO

SELECT *
FROM vCantidadDeVistasDePeliculasPorMes AS v1
WHERE v1.[Cantidad de vistas] = (SELECT MAX(v2.[Cantidad de vistas])
								FROM vCantidadDeVistasDePeliculasPorMes AS v2
								WHERE v1.Mes = v2.Mes)
ORDER BY v1.Mes, v1.CodPel

-- 6. Listar los clientes que hayan alquilado todas las peliculas del video.

SELECT c.CodCli
FROM Cliente AS c
WHERE NOT EXISTS (
	SELECT 1
	FROM Pelicula AS pel
	WHERE NOT EXISTS (
		SELECT 1
		FROM Prestamo AS pre
		WHERE pre.CodPel = pel.CodPel AND c.CodCli = pre.CodCli
					)
				)

SELECT p.CodCli
FROM Prestamo AS p
GROUP BY p.CodCli
HAVING COUNT(DISTINCT p.CodPel) = (SELECT COUNT(*) FROM Pelicula)

-- 7. Listar las peliculas que no han registrado ningun prestamo a la fecha.

SELECT pel.CodPel
FROM Pelicula AS pel
EXCEPT
SELECT pre.CodPel
FROM Prestamo AS pre

-- 8. Listar los clientes que no han efectuado la devolucion de ejemplares.

SELECT pre.CodCli
FROM Prestamo AS pre
WHERE pre.FechaDev IS NULL
ORDER BY pre.CodCli

-- 9. Listar los titulos de las peliculas que tienen la mayor cantidad de prestamos.

GO

CREATE OR ALTER VIEW vCantidadDePrestamosPorPeliculas AS (
	SELECT pre.CodPel, COUNT(*) AS [Cantidad de prestamos]
	FROM Prestamo AS pre
	GROUP BY pre.CodPel
)

GO

SELECT p.Titulo
FROM vCantidadDePrestamosPorPeliculas AS v JOIN Pelicula AS p ON v.CodPel = p.CodPel
WHERE v.[Cantidad de prestamos] = (SELECT MAX(v.[Cantidad de prestamos]) 
								   FROM vCantidadDePrestamosPorPeliculas AS v)

-- 10. Listar las peliculas que tienen todos los ejemplares prestados.

SELECT e.CodPel, COUNT(*) AS [Cantidad de ejemplares]
FROM Ejemplar AS e
GROUP BY e.CodPel
HAVING COUNT(*) = (SELECT COUNT(*)
					FROM Prestamo AS p
					WHERE p.CodPel = e.CodPel
					AND p.FechaDev IS NULL)