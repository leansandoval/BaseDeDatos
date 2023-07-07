/* Ejercicio 9: Dada la siguiente base de datos
	Persona (TipoDoc, NroDoc, Nombre, Dirección, FechaNac, Sexo)
	Progenitor (TipoDoc, NroDoc, TipoDocHijo, NroDocHijo)*/

USE Ejercicio_9
GO

/*1. Hallar para una persona dada, por ejemplo José Pérez, los tipos y números de documentos, nombres, 
dirección y fecha de nacimiento de todos sus hijos.*/

DECLARE @Persona VARCHAR(30)
SET @Persona = 'Jose Perez'
--SET @Persona = 'Martina Diaz'

SELECT per.TipoDoc, per.NroDoc, per.Nombre, per.Direccion, per.FechaNac
FROM Persona AS per JOIN (SELECT pro.TipoDocHijo, pro.NroDocHijo
						  FROM Progenitor AS pro JOIN Persona AS per 
						  ON per.TipoDoc = pro.TipoDoc AND per.NroDoc = pro.NroDoc
						  WHERE per.Nombre = @Persona) AS hijos 
ON per.TipoDoc = hijos.TipoDocHijo AND per.NroDoc = hijos.NroDocHijo

/* 2. Hallar para cada persona los tipos y números de documento, nombre, domicilio y fecha de nacimiento de:
a. Todos sus hermanos, incluyendo medios hermanos.
b. Su madre
c. Su abuelo materno
d. Todos sus nietos*/

-- 2.a. Todos sus hermanos, incluyendo medios hermanos.

SELECT herm.TipoDocHijo [TipoDoc], herm.NroDocHijo [NroDoc],
	   herm.[TipoDoc Hermano], herm.[NroDoc Hermano], per.Nombre [Nombre Hermano], per.Direccion [Direccion Hermano], per.FechaNac [FechaNac Hermano]
FROM Persona AS per JOIN (SELECT DISTINCT pro1.TipoDocHijo, pro1.NroDocHijo, pro2.TipoDocHijo [TipoDoc Hermano], pro2.NroDocHijo [NroDoc Hermano]
						  FROM Progenitor AS pro1 JOIN Progenitor AS pro2 
						  ON pro1.TipoDoc = pro2.TipoDoc AND pro2.NroDoc = pro1.NroDoc) AS herm
ON per.TipoDoc = herm.[TipoDoc Hermano] AND per.NroDoc = herm.[NroDoc Hermano]

-- 2.b

CREATE OR ALTER VIEW vMadresDePersonas AS
(
	SELECT pro.TipoDocHijo [TipoDoc], pro.NroDocHijo [NroDoc], 
		   per.TipoDoc [TipoDoc Madre], per.NroDoc [NroDoc Madre], per.Nombre [Nombre Madre], per.Direccion [Direccion Madre], per.FechaNac [FechaNac Madre]
	FROM Progenitor AS pro JOIN Persona AS per ON pro.TipoDoc = per.TipoDoc AND pro.NroDoc = per.NroDoc
	WHERE per.Sexo = 'Femenino'
)

SELECT *
FROM vMadresDePersonas

-- 2.c Su abuelo materno

SELECT am.TipoDoc, am.NroDoc, 
	   am.[TipoDoc Abuelo materno], am.[NroDoc Abuelo materno], per.Nombre [Nombre Abuelo materno] ,per.Direccion [Direccion Abuelo materno], per.FechaNac [FechaNac Abuelo materno]
FROM Persona AS per JOIN (SELECT mdp.TipoDoc, mdp.NroDoc, pro.TipoDoc [TipoDoc Abuelo materno], pro.NroDoc [NroDoc Abuelo materno]
						  FROM vMadresDePersonas AS mdp JOIN Progenitor AS pro 
						  ON mdp.[TipoDoc Madre] = pro.TipoDocHijo AND mdp.[NroDoc Madre] = pro.NroDocHijo) AS am
ON per.TipoDoc = am.[TipoDoc Abuelo materno] AND per.NroDoc = am.[NroDoc Abuelo materno]

-- 2.d. Todos sus nietos
SELECT nieto.TipoDoc, nieto.NroDoc, 
	   nieto.[TipoDoc Nieto], nieto.[NroDoc Nieto], per.Nombre [Nombre Nieto], per.Direccion [Direccion Nieto], per.FechaNac [FechaNac Nieto]
FROM Persona  AS per JOIN (SELECT pro1.TipoDoc, pro1.NroDoc, pro2.TipoDocHijo [TipoDoc Nieto], pro2.NroDocHijo [NroDoc Nieto]
						   FROM Progenitor AS pro1 JOIN Progenitor AS pro2 
						   ON pro1.TipoDocHijo = pro2.TipoDoc AND pro1.NroDocHijo = pro2.NroDoc) AS nieto
ON per.TipoDoc = nieto.[TipoDoc Nieto] AND per.NroDoc = nieto.[NroDoc Nieto]
