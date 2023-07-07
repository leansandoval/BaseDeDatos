/*Ejercicio 4: Dada la siguiente base de datos
	Persona (DNI, Nombre, Telefono)
	Empresa (Nombre, Telefono)
	Vive (DNI, Calle, Ciudad)
	Trabaja (DNI, NombreEmpresa, Salario, FechaIngreso, FechaEgreso)
	SituadaEn (nomEmpresa, Ciudad)
	Supervisa (DNIPer, DNISup)*/

USE Ejercicio_4;
GO

-- a. Encontrar el nombre de todas las personas que trabajan en la empresa “Banelco”.

SELECT p.Nombre
FROM Trabaja AS t JOIN Persona AS p ON t.DNI = p.DNI
WHERE t.NombreEmpresa = 'Banelco'

-- b. Localizar el nombre y la ciudad de todas las personas que trabajan para la empresa “Telecom”.

SELECT p.Nombre, v.Ciudad
FROM Trabaja AS t JOIN Persona AS p ON t.DNI = p.DNI JOIN Vive AS v ON v.DNI = p.DNI
WHERE t.NombreEmpresa = 'Telecom'

-- c. Buscar el nombre, calle y ciudad de todas las personas que trabajan para la empresa “Paulinas” y ganan más de $1500.

SELECT p.Nombre, v.Calle, v.Ciudad
FROM Trabaja AS t JOIN Persona AS p ON t.DNI = p.DNI JOIN Vive AS v ON v.DNI = p.DNI
WHERE t.NombreEmpresa = 'Paulinas' AND t.Salario > 1500

-- d. Encontrar las personas que viven en la misma ciudad en la que se halla la empresa en donde trabajan.

SELECT p.*
FROM Trabaja AS t JOIN Persona AS p ON t.DNI = p.DNI 
				  JOIN Vive AS v ON v.DNI = p.DNI 
				  JOIN SituadaEn AS se ON se.NombreEmpresa = t.NombreEmpresa AND se.Ciudad = v.Ciudad

-- e. Hallar todas las personas que viven en la misma ciudad y en la misma calle que su supervisor.

SELECT s.DNIPer
FROM Supervisa AS s JOIN Vive v1 ON s.DNIPer = v1.DNI 
					JOIN Vive v2 ON s.DNISup = v2.DNI AND v1.Calle = v2.Calle AND v1.Ciudad = v2.Ciudad
	
-- f. Encontrar todas las personas que ganan más que cualquier empleado de la empresa “Clarín”.

SELECT t.DNI
FROM Trabaja AS t
WHERE t.NombreEmpresa LIKE 'Clar_n' AND t.Salario = (SELECT MAX(Salario) 
													 FROM Trabaja 
													 WHERE NombreEmpresa LIKE 'Clar_n')

-- g. Localizar las ciudades en las que todos los trabajadores que vienen en ellas ganan más de $1000.

SELECT v.Ciudad
FROM Vive AS v
EXCEPT
SELECT v.Ciudad
FROM Trabaja AS t JOIN Vive AS v ON t.DNI = v.DNI
WHERE t.Salario < 1000

-- h. Listar los primeros empleados que la compañía “Sony” contrató.

SELECT t.DNI
FROM Trabaja AS t
WHERE t.NombreEmpresa = 'Sony' AND t.FechaIngreso = (SELECT MIN(FechaIngreso)
													 FROM Trabaja
													 WHERE NombreEmpresa = 'Sony')

-- i. Listar los empleados que hayan ingresado en mas de 4 Empresas en el periodo 01-01-2000 y 31-03-2004 y que no hayan tenido menos de 5 supervisores

SELECT p4e.DNI
FROM (SELECT t.DNI
	  FROM Trabaja AS t
	  WHERE t.FechaIngreso BETWEEN '2000-01-01' AND '2004-03-31'
	  GROUP BY t.DNI
	  HAVING COUNT(DISTINCT t.NombreEmpresa) > 4) AS p4e

INTERSECT

SELECT pys.DNIPer
FROM (SELECT s.DNIPer
	  FROM Supervisa AS s
	  GROUP BY s.DNIPer
	  HAVING COUNT(*) > 5) AS pys