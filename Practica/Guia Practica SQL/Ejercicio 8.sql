/* Ejercicio 8: Dada la siguiente base de datos
	Frecuenta (persona, bar)
	Sirve (bar, cerveza)
	Gusta (persona, cerveza)*/

CREATE DATABASE Ejercicio8;
GO
USE Ejercicio8;

CREATE TABLE [dbo].[Frecuenta]
(
	[NombrePersona] [varchar](50) NOT NULL,
	[NombreBar] [varchar](50) NOT NULL,
);

CREATE TABLE [dbo].[Sirve]
(
	[NombreBar] [varchar](50) NOT NULL,
	[NombreCerveza] [varchar](50) NOT NULL,
	CONSTRAINT [PK_Sirve] PRIMARY KEY CLUSTERED ([NombreBar] ASC, [NombreCerveza] ASC)
);

CREATE TABLE [dbo].[Gusta]
(
	[NombreCerveza] [varchar](50) NOT NULL,
	[NombrePersona] [varchar](50) NOT NULL,
	CONSTRAINT [PK_Gusta] PRIMARY KEY CLUSTERED ([NombreCerveza] ASC,[NombrePersona] ASC)
 );

INSERT INTO Frecuenta (nombrePersona,nombreBar) VALUES 
('Juan','Valinor'),
('Andrea','Valinor'),
('Mariano','Valinor'),
('Barbara','Duarte'),
('Barbara','Vita'),
('Barbara','Santa Birra'),
('Nicolas','Byra'),
('Nicolas','La Quintana'),
('Marcos','Jobs'),
('Marcos','La Birreria'),
('Francisco','La Birreria'),
('Francisco','Jobs'),
('Francisco','Vita'),
('Chloe','Vita'),
('Zoe','La Ferneteria');

INSERT INTO Gusta (nombrePersona,nombreCerveza) VALUES 
('Juan','Quilmes'),
('Juan','Brahma'),
('Andrea','Stella'),
('Andrea','Andes'),
('Andrea','Quilmes'),
('Mariano','Stella'),
('Mariano','Andes'),
('Barbara','Brahma'),
('Barbara','Stella'),
('Bianca','Corona'),
('Chloe','Brahma'),
('Chloe','Stella') ,
('Dominic','Corona'),
('Francisco','Sapporo'), 
('Nicolas','Quilmes'),
('Nicolas','Stella'),
('Nicolas','Brahma'),
('Nicolas','Budweiser'),
('Marcos','Flensburger'),
('Marcos','Stella'),
('Zoe','Corona');

INSERT INTO Sirve (nombreBar,nombreCerveza) VALUES 
('Valinor','Stella'),
('Valinor','Quilmes'),
('Duarte','Brahma'),
('Duarte','Stella'),
('Santa Birra','Quilmes'),
('Byra','Quilmes'),
('Byra','Stella'),
('Byra','Brahma'),
('Byra','Andes'),
('La Quintana','Andes'),
('La Quintana','Budweiser'),
('Jobs','Budweiser'),
('Jobs','Flensburger'),
('Jobs','Stella'),
('La Birreria','Flensburger'),
('Vita','Stella'),
('Vita','Brahma'),
('Florida 165','Sapporo');

-- Usar el SQL para hallar las personas que:

-- 1. Frecuentan solamente bares que sirven alguna cerveza que les guste.

-- Personas que van a bares que no sirven ninguna cerveza que les guste.
-- (Personas que frecuentan bares que no) Voy por el camino inverso
CREATE OR ALTER VIEW v_Personas_Frecuentan_Bar_NO AS
(
	-- Personas que frecuentan bares
	SELECT f.NombrePersona, f.NombreBar
	FROM Frecuenta AS f
	EXCEPT
	-- Personas y bares donde sirven la cerveza que les gusta
	(SELECT DISTINCT g.NombrePersona, s.NombreBar
	FROM Gusta AS g INNER JOIN Sirve AS s ON s.NombreCerveza = g.NombreCerveza)
)

-- Personas que solamente frecuentan bares que sirven alguna cerveza que les gusta
SELECT DISTINCT f2.NombrePersona
FROM Frecuenta AS f2
WHERE f2.NombrePersona NOT IN (SELECT pNO.NombrePersona
							   FROM v_Personas_Frecuentan_Bar_NO AS pNO)

-- 2. No frecuentan ningún bar que sirva alguna cerveza que les guste.
SELECT DISTINCT rta.NombrePersona
FROM (SELECT *
	  FROM Frecuenta AS f2
	  EXCEPT
	  SELECT f.NombrePersona, f.NombreBar
	  FROM Frecuenta AS f INNER JOIN Sirve AS s ON s.NombreBar = f.NombreBar
						  INNER JOIN Gusta AS g ON g.NombreCerveza = s.NombreCerveza 
						  AND g.NombrePersona = f.NombrePersona) AS rta

-- 3. Frecuentan solamente los bares que sirven todas las cervezas que les gustan.

-- Combinacion de personas que frecuentan algun bar que no sirve alguna de las cervezas que le gustan
CREATE OR ALTER VIEW v_PerBarNO AS
(
-- Parte A: Cervezas que le gustan
	SELECT f.NombrePersona, f.NombreBar, g.NombreCerveza
	FROM Frecuenta AS f INNER JOIN Gusta AS g ON f.NombrePersona = g.NombrePersona
	EXCEPT
-- Parte B: Cervezas que sirven
	SELECT f.NombrePersona, f.NombreBar, s.NombreCerveza
	FROM Frecuenta AS f INNER JOIN Sirve AS s ON f.NombreBar = s.NombreBar
)

SELECT f.NombrePersona
FROM Frecuenta AS f 
WHERE f.NombrePersona NOT IN (SELECT pNO.NombrePersona
							  FROM v_PerBarNO AS pNO)

-- Otra resolucion:

CREATE OR ALTER FUNCTION f_Cantidad_Cerveza (@NombrePersona VARCHAR(30)) RETURNS INT
AS
BEGIN
	DECLARE @Cantidad INT
	SET @Cantidad = (SELECT COUNT(g.NombreCerveza)
					 FROM Frecuenta AS f INNER JOIN Gusta AS g ON f.NombrePersona = g.NombrePersona
					 WHERE f.NombrePersona = @NombrePersona)
	RETURN @Cantidad;
END

SELECT f.NombrePersona
FROM Frecuenta AS f INNER JOIN Sirve AS s ON f.NombreBar = s.NombreBar
					INNER JOIN Gusta AS g ON (f.NombrePersona = g.NombrePersona AND s.NombreCerveza = g.NombreCerveza)
GROUP BY f.NombrePersona
HAVING COUNT(s.NombreCerveza) = (SELECT dbo.f_Cantidad_Cerveza (f.NombrePersona))

-- 4. Frecuentan solamente los bares que no sirven ninguna de las cervezas que no les gusta.
SELECT f.NombrePersona
FROM Frecuenta AS f
INTERSECT
(SELECT f.NombrePersona
FROM Frecuenta AS f INNER JOIN Sirve AS s ON f.NombreBar = s.NombreBar
INTERSECT
SELECT g.NombrePersona
FROM Gusta AS g)