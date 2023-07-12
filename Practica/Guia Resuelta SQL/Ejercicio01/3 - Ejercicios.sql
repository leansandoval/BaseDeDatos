/*Ejercicio 1: Dado el siguiente esquema de relacion

	Alumno (DNI, Apellido, Nombre, Escuela)
	HermanoDe (DNIAlumno, DNIHermano)
	Escuela (Codigo, Nombre, Direccion)
	Alimento (Id, Descripcion, Marca)
	AlmuerzaEn (DNIAlumno, IdAlimento, CodigoEscuela)*/

/* a) Listar a todos los alumnos que asisten a escuelas donde no sirven alimentos y almuerzan en otro 
establecimiento.*/

SELECT DISTINCT a.*		-- Alumnos que almuerzan en otro establecimiento
FROM Alumno AS a JOIN AlmuerzaEn ae ON a.DNI = ae.DNIAlumno
WHERE a.CodigoEscuela <> ae.CodigoEscuela AND a.CodigoEscuela NOT IN (SELECT ae.CodigoEscuela		
																	  FROM AlmuerzaEn AS ae)
											-- Alumnos que asisten a las escuelas que no sirven alimentos

/* b) Mostrar todas las escuelas que sirven alimentos a todos sus alumnos que no tienen mas de dos hermanos.*/

-- Alumnos que NO tienen mas de dos hermanos

GO

CREATE OR ALTER VIEW v_Alumnos_Menos_De_2_Hermanos AS (
	SELECT a.DNI
	FROM Alumno AS a
	WHERE a.DNI NOT IN (SELECT hd.DNIAlumno
						FROM HermanoDe AS hd
						GROUP BY hd.DNIAlumno
						HAVING COUNT (*) > 2)
)

GO

SELECT *
FROM Escuela AS e
WHERE NOT EXISTS (SELECT 1
				  FROM v_Alumnos_Menos_De_2_Hermanos AS a
				  WHERE NOT EXISTS (SELECT 1
									FROM AlmuerzaEn AS ae
									WHERE ae.CodigoEscuela = e.Codigo AND ae.DNIAlumno = a.DNI))
