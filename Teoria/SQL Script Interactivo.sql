-- LENGUAJE SQL. ESTANDAR. ANSI-SQL (ver 92, 97, 99, 2007, 2014, etc)
-- MOTORES TIENEN LENGUAJES PROPIOS: 
		-- POSTGRES PG/PLSQL
		-- ORACLE PLSQL
		-- ETC
		-- MS SQL (SQL SERVER) TRANSACT SQL (TSQL) link: https://go.microsoft.com/fwlink/?linkid=866662
		-- link MS-SQLMS https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16
		
-- BASES DE DATOS
-- Una base de datos, es un elemento dentro del motor de bases de datos. Esta compuesto por dos o más archivos físicos, 
-- donde las tablas serán elementos dentro de estos archivos. 
-- Uno de los archivos es el que contiene la base de datos en sí, mientras que el otro es un archivo de log.

/*
DDL = Data Definition Language
	Ejemplo: CREATE -, Alter, DROP, etc

DML = lenguaje de manipulación de datos
	Ejemplo: SELECT, insert, update, etc

DCL = DATA CONTROL LANGUAGE
   Ejemplo: GRANT,remoke, etc

TCL = Lenguaje CONTROL DE TRANSACCIÓN 
	Ejemplo: COMMIT, rollback,etc
*/

----Crear una base de datos
CREATE DATABASE Ejemplo123;
--CREATE DATABASE CLASE SABADO								--> DA ERROR PORQUE NO RECONOCE EL CARACTER DE ESPACIO
CREATE DATABASE [CLASE SABADO '22]

-- Ejemplo de modificación de parametros. Modificar parametro de cierre de transacciones
ALTER DATABASE [CLASE SABADO '22] MODIFY NAME = new_database_name

--ALTER DATABASE new_database_name MODIFY NAME = ejemplo123 --> DA ERROR PORQUE YA EXISTIA UNA DB CON ESE NOMBRE

-- Borrado de una base de datos
 DROP DATABASE new_database_name;

-- Validar si existe la base de datos
SELECT * 
FROM sys.databases 

-- Usar la base de datos;
USE Ejemplo123;

----Que es un esquema?
-- Un esquema es un conjunto o agrupador de elementos dentro de la base de datos. Por ejemplo, podemos tener dentro de una misma 
-- base de datos, 1 esquema para desarrollo, 1 para testing y uno para producción.

-- CREAR Esquema
CREATE SCHEMA Desarrollo;

-- BORRAR Esquema
DROP SCHEMA Desarrollo;

--> dbo -> ESQUEMA POR DEFECTO DE MSSQL SERVER 

/**************************************************** Tipos de datos ****************************************************/

-- Dentro de un motor de base de datos (SQL server 2017)

-- ENTEROS --
BIGINT			--> Entero 8 bytes
INT				--> Entero 4 bytes
SMALLINT		--> Entero 2 bytes
TINYINT			--> Entero 1 byte

-- BOOLEANO --
BIT				--> Entero 1 byte 1 / 0 / NULL

-- CON DECIMALES --
NUMERIC (L, d)	--> L = Largo total (parte entera + decimal)
				--> d = Cantidad de decimales 1.000.000,00 DECIMAL(9,2)
DECIMAL	(L, d) 

FLOAT , REAL
SMALLMONEY		--> 4 Bytes. Representa numeros con simbolo de dinero. 
MONEY			--> 8 bytes

-- CADENAS DE TEXTO --
CHAR (L)		--> Almacena la cantidad indicada en "L". si pongo Char(5) y guardo ANA, guarará 3 carateres para ANA y 2 más hasta llegar a 5
VARCHAR (L)     --> Almacena la cadena ingresada y si es de largo menor a "L" guarda la cantidad de la cadena. 
				--> Ejemplo: VARCHAR(5) "ANA" guarda ANA y 3. si guarda JUAN guarda la cadena y 4.
VARCHAR(MAX)    --> MAXIMO PERMITIDO POR EL MOTOR 

-- CADENAS DE TEXTO UNICODE --
NCHAR (L)
NVARCHAR (L)

-- FECHAS & HORAS --
--> Todos los datos de fecha se guardan como un número, numero que se toma como 0 un momento dado en el tiempo y luego en milisegundos a partir de ahí.

DATE			--> El ANSI SQL (estándar) indica que el 0 es 1582, 10, 15, y llegaría hasta el 9999, 12, 31, según el tamaño en bytes del campo
TIME			--> Horas
DATETIME		--> Fecha y hora. Arrancando 1753, 1 de enero.
SMALLDATETIME	--> Fecha y hora, pero el "0" es un valor más próximo que 1753, arrancando de 1900, 1, 1. 
DATETIME2		--> Arranca en 1900, 1, 1 y almacena en 6 bytes el tamaño, para mayor precisión en los milisegundos

-->> QUE VALOR TIENE, EN MILISEGUNDOS, LA FECHA DE INICIO DE LA CLASE DE HOY? 2022/10/30 08:35:00.0000

/******************************************************** Tablas ********************************************************/

----Crear una tabla
CREATE TABLE NombreTabla
(
	Campo1 INT,
	Campo2 VARCHAR(6),
	[Nombre Largo Campo] DECIMAL(12,2)
);

CREATE TABLE Desarrollo.NombreTabla
(
	Campo1 INT,
	Campo2 VARCHAR(6)
);	

--EJEMPLO SCHEMA ERRONEO
/*
CREATE TABLE SCHEMA_INEXISTENTE.NombreTabla
(
	Campo1 INT,
	Campo2 VARCHAR(6)
)	
*/

SELECT * FROM NombreTabla;						-- Solo nombre de la tabla
SELECT * FROM ejemplo123.dbo.NombreTabla;		-- Nombre de la DB.SCHEMA.TABLA
SELECT * FROM ejemplo123.Desarrollo.NombreTabla;

-- MODIFICAR
ALTER TABLE NombreTabla
	ADD Campo3 BIGINT;

ALTER TABLE NombreTabla
	ALTER COLUMN Campo3 DATETIME;

ALTER TABLE NombreTabla
	DROP COLUMN Campo3;

-- BORRAR
DROP TABLE NombreTabla;

----Mostrar pk
-- PARA CREAR UNA TABLA CON CLAVE PRIMARIA O PRIMARY KEY, HAY DOS OPCIONES
CREATE TABLE TablaUno
(
	Campo1 INT PRIMARY KEY,
	Campo2 VARCHAR(6)
);

CREATE TABLE TablaDos
(
	Campo1 INT,
	Campo2 NVARCHAR(MAX),   -- <<--- si agregamos la palabra reservada MAX tendremos el largo máximo del tipo NVARCHAR
	PRIMARY KEY (Campo1)
);	

--> PK's compuestas
CREATE TABLE TablaTres
(
	Campo1 INT,
	Campo2 VARCHAR(6),
	PRIMARY KEY (Campo1, Campo2)
);

/*No se puede*/
CREATE TABLE TablaCuatro
(
	Campo1 INT PRIMARY KEY,
	Campo2 VARCHAR(6),
	PRIMARY KEY (Campo1, Campo2)
);

-- EJEMPLO
CREATE TABLE Persona1
(
	NroDoc INT,
	TipoDoc VARCHAR(3),
	PRIMARY KEY (NroDoc, TipoDoc)
);

-- NO DISCRIMNA ENTRE MAYUSCULAS Y MIN.
Select * from tablaTres
Select * frOm TABLATRES
Select * from tAblAtREs
SeLeCt * FrOm TABLATRES

-- Ejemplo
CREATE TABLE Persona
(
	NroDoc BIGINT, 
	TipoDoc CHAR(3),
	Nombre VARCHAR(40),
	Apellido VARCHAR(40),
	PRIMARY KEY (NroDoc, TipoDoc)
)

DROP TABLE Persona

-- CLAVES FORÁNEAS -- 
-- Las claves foráneas estan asociadas a campos clave de otras tablas

CREATE TABLE TablaPk
(
	Campo1 INT PRIMARY KEY,
	Campo2 VARCHAR(6)
)	

-- NO PUEDO CAMBIAR EL TIPO DE DATO AL SER UN CAMPO CLAVE PRIMARIA
ALTER TABLE TablaPk
	ALTER COLUMN Campo1 VARCHAR(50)

CREATE TABLE TablaFk
(
	CampoA INT PRIMARY KEY,
	CampoB VARCHAR(6),
	CampoC INT,
	FOREIGN KEY (CampoC) REFERENCES TablaPk(Campo1) -- Indicamos que campo de la TablaFk apunta a que campo de la TablaPk
)

-- ELIMINAR
DROP TABLE TablaPk
DROP TABLE TablaFk

--Eliminar PK o FK
ALTER TABLE TablaFk
	DROP CONSTRAINT [PK__TablaFk__7A1E290F6CFAB148];

-- Ejemplo

CREATE TABLE Provincia
(
	Id INT,
	Nombre VARCHAR(40),
	PRIMARY KEY(Id)
)

-- DROP TABLE Provincia

-- Comentario de una linea

/*	Comentario
	de muchas lineas
*/

CREATE TABLE Localidad
(
	Codigo INT,
	Nombre VARCHAR(40),
	Codigo_Tabla_Provincia INT, 
	PRIMARY KEY(Codigo),
	FOREIGN KEY (Codigo_Tabla_Provincia) REFERENCES Provincia(Id)
)

-- COMO CONOCER LA ESTRUCTURA DE UNA TABLA?
SP_HELP  Localidad

-- ERROR AL REFERENCIAR CON DISTINTO TIPO
CREATE TABLE TablaFk_ERROR
(
	CampoA INT PRIMARY KEY,
	CampoB VARCHAR(6),
	CampoC VARCHAR(5),
	FOREIGN KEY (CampoC) REFERENCES TablaPk(Campo1) -- Indicamos que campo de la tablaFk apunta a que campo de la tablaPk
)

----------->>> EJEMPLO TERNARIA 
-- A (a1 PK, a2, a3)
-- B (b1 PK, b2, b3)
-- C (c1 PK, c2, c3)
-- R (a1, b1, c1) donde todos son PK y FK

CREATE TABLE A 
(
	a1 INT PRIMARY KEY,
	a2 INT,
	a3 INT
);

CREATE TABLE B
(
	b1 INT PRIMARY KEY,
	b2 INT,
	b3 INT
);

CREATE TABLE C
(
	c1 INT PRIMARY KEY,
	c INT,
	c3 INT
);

CREATE TABLE R
(
	a1 INT,
	b1 INT,
	c1 INT,
	PRIMARY KEY (a1, b1, c1),
	FOREIGN KEY (a1) REFERENCES A(a1),
	FOREIGN KEY (b1) REFERENCES B(b1),
	FOREIGN KEY (c1) REFERENCES C(c1)
);

SP_HELP R

-<<<<<---------- EJEMPLO TERNARIA 

-- TRABAJANDO CON DATOS

-- INSERT / UPDATE / DELETE 

----Insertar en tabla
-- Hay varias formas de insertar datos en una base de datos, por fila o tupla o con muchas filas o tuplas

-- INSERTAR 1 FILA
sp_help TablaUno

INSERT INTO TablaUno (Campo1, Campo2) VALUES (1, 'A');				-- ORDEN RELATIVO AL CONJUNTO DE CAMPOS
INSERT INTO TablaUno (Campo2, Campo1) VALUES ('A', 10);				-- ORDEN RELATIVO AL CONJUNTO DE CAMPOS
INSERT INTO TablaUno VALUES (2, 'B');								-- ORDEN POR POSICIÓN

-- INSERTANDO MÁS DE UNA TUPLA A LA VEZ
INSERT INTO TablaUno VALUES (3, 'C'), (4, 'H'), (5, 'G'), (6, 'F'); -- ORDEN POR POSICIÓN

-- Resulatdo:
SELECT * 
FROM TablaUno;

-- INSERTANDO MAS DE UNA TUPLA DESDE OTRA TABLA

INSERT INTO TablaDos (Campo1, Campo2)
SELECT database_id, NAME
FROM sys.Databases -- << inserto todos los elementos de la tabla sys.databases

-- Resultado:
SELECT * FROM tablaUno;
SELECT * FROM tablaDos;
-- DELETE FROM tablaDos;

----MODIFICAR TUPLAS DE UNA TABLA
--PRUEBA:
SELECT *, upper(Campo2) + ' - MODIFICADO' as [Campo2 en mayuscula]	-- Listo el contenido de la tabla
FROM TablaDos 

UPDATE TablaDos									-- INDICO LA TABLA A MODIFICARLE INFORMACION
SET Campo2 = UPPER(Campo2) + ' - MODIFICADO'	-- INDICO EL CAMPO Y SU NUEVO VALOR
WHERE Campo2 = 'Master';						-- FILTRO 

SELECT * FROM TablaDos							-- Listo el contenido de la tabla, para ver los cambios.

----Borrar
DELETE FROM TablaDos	-- Indico la tabla donde voy a borrar info
WHERE Campo2 = 'msdb'	-- Indico la condicion

----OBTENIENDO INFORMACIÓN
-- Para obtener información de las tablas, se debe utilizar lo que llamamos consultas tipo "SELECT"

-->> CONSULTAS SIN CONDICIÓN --> SIMILAR A LA SELECCION
SELECT *				-- Indicamos la palabra SELECT y luego "*" asterisco para listar todos los campos, o detallo los campos 1 a 1
FROM TablaDos			-- detallamos la tabla


---- CON CONDICIÓN --> (ES LA SELECCION EN AR)
SELECT * 
FROM TablaDos 
WHERE Campo1 = 3;		-- Con la clausula WHERE, podemos detallar las condiciones, para hacer un filtro horizontal de filas
						-- operadores: = <= >= <>, LIKE, EXISTS, IN, NOT, OR, AND

-- EJEMPLO: IN
SELECT * 
FROM TablaDos 
WHERE Campo1 IN (3, 6, 5)  

--- Equivalente a 
SELECT * 
FROM TablaDos 
WHERE Campo1 = 3 OR Campo1 = 6 OR Campo1 = 5

---- NOT IN
SELECT * 
FROM TablaDos 
WHERE Campo1 NOT IN (3, 6, 5)

--- Equivalente a 
SELECT * 
FROM TablaDos 
WHERE Campo1 <> 3 AND Campo1 <> 6 AND Campo1 <> 5

SELECT * 
FROM TablaDos 
WHERE Campo1 = 4 OR 	-- << LIKE SIRVE PARA COMPARAR TEXTOS, CAMPOS TIPO CHAR / VARCHAR.
 Campo2 LIKE '%MOD%'	-- << SE PUEDEN USAR "wildcards" o comodines "%", 0 o más caracteres
						-- << "_" UN CARACTER

SELECT * 
FROM TablaDos 
WHERE Campo2 LIKE 'mo_el'			-- << "_" UN CARACTER en medio de otros 

--- Unión: el operador unión "une" dos consultas en un único resultado

SP_HELP TablaUno
SP_HELP TablaDos

SELECT * 
FROM TablaUno
UNION 
SELECT *	-- Campo1, Campo2
FROM TablaDos

----Resta
SELECT * 
FROM TablaUno
EXCEPT
SELECT * 
FROM TablaDos

----Eliminar duplicados DISTINCT

SELECT DISTINCT Campo2
FROM TablaUno

----Inserción

/**Para que de resulatdos*/
UPDATE TablaDos
SET Campo1 = 1, Campo2 = 'A'
WHERE Campo1 = 8

SELECT * 
FROM TablaUno
INTERSECT 
SELECT * 
FROM TablaDos

----Producto 
SELECT *
FROM TablaUno, TablaDos -- << separando en el FROM las tablas por comas, se realiza un producto cartesiano.
--> AR: TablaUno X TablaDos 

/******************************************************** Juntas ********************************************************/

SELECT * 
FROM TablaUno JOIN TablaDos ON TablaUno.Campo1 = TablaDos.Campo1
-- Luego del "ON" se indica los campos relacionados entre las tablas
--> AR: tablaUno |X| tablaDos

-- Esto es equivalente a
SELECT * 
FROM TablaUno, TablaDos 
WHERE TablaUno.Campo1 = TablaDos.Campo1 -- < PRODUCTO CARTESIANO + UNA SELECCION

---- JUNTAS A IZQUIERDA
-- ESTE tipo de juntas mostrará todas las filas de la tabla a izquierda, lo que pueda juntar a derecha. Cuando no tenga con que 
-- emparejar.
SELECT * 
FROM TablaUno LEFT JOIN TablaDos ON TablaUno.Campo1 = TablaDos.Campo1
 --> AR: tablaUno |X tablaDos

---- JUNTAS A DERECHA
-- ESTE tipo de juntas mostrará todas las filas de la tabla a DERECHA, lo que pueda juntar a derecha. Cuando no tenga con que 
-- emparejar.
SELECT * 
FROM TablaUno RIGHT JOIN TablaDos ON TablaUno.Campo1 = TablaDos.Campo1
--> AR: tablaUno X| tablaDos

-- EJEMPLO DE REEMPLAZO DE NULOS POR UN VALOR QUE YO QUIERA
SELECT ISNULL(tablaUno.Campo1, 0) as Campo1, tablaUno.Campo2, tablaDos.Campo1, tablaDos.Campo2
FROM tablaUno RIGHT JOIN tablaDos ON tablaUno.Campo1 = tablaDos.Campo1

---- JUNTAS COMPLETAS
-- ESTE tipo de juntas mostrará todas las filas de la tabla a izquierda y derecha, 
-- lo que pueda juntar a derecha. Cuando no tenga con que emparejar.
SELECT * 
FROM TablaUno FULL JOIN TablaDos ON TablaUno.Campo1 = TablaDos.Campo1

-- PARA SABER CUALES VALORES DE AMBAS TABLAS NO TIENEN CORRESPONDENCIA EN LA OTRA.
SELECT *
FROM TablaUno FULL JOIN TablaDos ON TablaUno.Campo1 = TablaDos.Campo1
WHERE TablaUno.Campo1 IS NULL OR TablaDos.Campo1 IS NULL

/******************************************************** Group by ********************************************************/

-- Los grupos son el equivalente a la AGRUPACIÓN de AR.
SELECT Campo2
FROM TablaUno
GROUP BY Campo2  -- << SE LISTARÁ, CON ESTE EJEMPLO, LOS VALORES DISTINTOS QUE SE TENGAN EN "CAMPO2" 

-- EJEMPLO, CUENTO CUANTAS OCURRENCIAS HAY DE CADA UNA
SELECT Campo2 , COUNT(*) AS [Cantidad de ocurrencias]
FROM TablaUno
GROUP BY Campo2  -- << SE LISTARÁ, CON ESTE EJEMPLO, LOS VALORES DISTINTOS QUE SE TENGAN EN "CAMPO2" 

/******************************************************** Having ********************************************************/

-- SI SE QUIERE REALIZAR SELECCIONES O APLICAR CONDICIONES LUEGO DEL GROUP BY, SE UTILIZA LA PALABRA RESERVADA HAVING
SELECT Campo2
FROM TablaUno
WHERE Campo2 IN('A','C')
GROUP BY Campo2
HAVING Campo2 LIKE 'C' -- << ES IMPORTATE QUE LOS CAMPOS A UTILIZAR EN EL HAVING DEBEN ESTAR CONTENIDOS EN EL GROUP BY

/******************************************************** Order by ********************************************************/

-- LA ULTIMA LINEA QUE SE TIENE EN EL SELECT ES EL order by. como su nombre lo indica, sirve para ordenar el resultado. 
-- con los decoradores ASC y DESC se indica ordenar ascendente o descendente.

SELECT *
FROM TablaUno
ORDER BY Campo1				-- por defecto, ordena de forma ascendente

SELECT *
FROM TablaUno
ORDER BY Campo2				-- por defecto, ordena de forma ascendente

SELECT *
FROM tablaUno
ORDER BY CAMPO2, CAMPO1 ASC

SELECT *
FROM TablaUno
ORDER BY Campo2, Campo1 DESC -- ORDENAMOS Primero por el campo 2, luego por el campo 1. El campo2 de forma asc y el 2 de forma desc

/************************************************** Funciones de agregado **************************************************/

MIN			-- Toma el minimo de un conjunto
SUM			-- Suma el conjunto
COUNT		-- Cuenta los elementos de un conjunto. Es la UNICA que si no hay elementos en el conjunto no da NULL, da 0.
MAX			-- Toma el maximo de un conjunto.
AVG			-- Promedia el conjunto
STRING_AGG	-- Acumula strings (concatena)

-- EJEMPLO CON TABLA VACIA
CREATE TABLE EjemploFuncAgr (Campo1 INT);
INSERT INTO EjemploFuncAgr VALUES (1), (2), (3), (4), (5), (1), (2), (3), (4), (5), (1), (2), (3), (4), (5)
SELECT * FROM EjemploFuncAgr;

SELECT MIN(Campo1) AS Minimo, MAX(Campo1) Maximo, SUM(Campo1) Suma, COUNT(Campo1) Cuenta 
FROM EjemploFuncAgr;

-- EJEMPLO CON DATOS
SELECT MAX(Campo1) AS Maximo, MIN(Campo1) Minimo, AVG(Campo1), COUNT(Campo1), STRING_AGG(Campo2, ', ')
FROM TablaUno

-- FUNCIONES DE AGREGADO CON AGRUPADORES
SELECT * 
FROM TablaUno;

SELECT MAX(Campo1) as Maximo, MIN(Campo1) Minimo, AVG(Campo1) [El promedio], COUNT(Campo1)[Conteo de filas], Campo2
FROM TablaUno
GROUP BY Campo2
HAVING MAX(Campo1) > 4

-- FUNCIONES DE AGREGADO CON AGRUPADORES Y FILTRO 
SELECT MAX(Campo1) AS [Campo Max], MIN(Campo1), AVG(Campo1), COUNT(Campo1), Campo2
FROM TablaUno
GROUP BY Campo2
HAVING MAX(Campo1) > 4

/******************************************************** Alias ********************************************************/
-- Renombrar tablas o columnas
SELECT Campo1 AS c1, Campo2 c2
FROM TablaUno t
WHERE t.Campo1 = 1
-- AR -->>>> TablaX (c1, c2) <- SEL Campo1 = 1 (Tabla1)

/***************************************************** Distinct *****************************************************/

---> LISTAR SOLO LOS VALORES DISTINTOS DE UNA QUERY
--SIN
SELECT Campo2 FROM TablaUno
--CON
SELECT DISTINCT Campo2 FROM TablaUno

/***************************************************** Sub Consultas *****************************************************/

--> Ejemplo de subconsulta en AR: liste todas las personas que cursaron todas las materias
--      R <- personas / materia (no lo escribiamos así, sino que.....)
--      R <- PRO id(PERSONAS) - PRO id (  PRO id(PERSONAS) x PRO cod (MATERIAS) ) - PRO persona,materia (CURSA))
-- Las subconsultas se pueden hacer en el SELECT, FROM, WHERE o HAVING. 

-- En el SELECT
SELECT *, (SELECT Campo2 FROM tablaDos d WHERE u.Campo1 = d.Campo1)
FROM TablaUno u
-- ES IMPORTANTE ACLARAR QUE LAS SUB CONSULTAS EN EL SELECT DEBEN DEVOLVER 1 SOLA FILA POR CADA UNA DE LAS DEL SELECT PRINCIPAL
-- LA SUBCONSULTA DEL SELECT SE EJECUTARÁ TANTAS VECES COMO FILAS TENGA LA CONSULTA PRINCIPAL

-- En el FROM 
SELECT * 
FROM (
	SELECT Campo1 AS Id, Campo2 AS Descripcion 
	FROM TablaDos WHERE Campo1 > 3
	) AS t
WHERE t.Descripcion LIKE '%pruebas'
-- ES IMPORTANTE ACLARAR QUE LAS SUB CONSUTLAS EN EL FROM, TIENE QUE TENER SIEMPRE UN ALIAS!!!

-- En el WHERE
SELECT *
FROM TablaUno
WHERE Campo1 IN (
		SELECT Campo1
		FROM TablaDos
		WHERE Campo2 LIKE 'm%'
		)

SELECT *
FROM TablaUno u
WHERE EXISTS (
		SELECT 'A'
		FROM TablaDos d
		WHERE Campo2 LIKE 'm%' AND u.Campo1 = d.Campo1
		)
-- MISMA CONSULTA CON EXISTS E IN

/******************************************************** Cociente ********************************************************/

-- OPERADOR DE DIVISIÓN
-- SUPONGAMOS QUE TENEMOS LA CONSULTA, LISTE TODOS LOS ELEMENTOS DE X CONJUNTO QUE TENGA CORRESPONDENCIA CON TODOS LOS 
-- ELEMENTOS DEL 2do CONJUNTO.

-- conjuntos -->> tablas

CREATE TABLE Alumno
(
	Legajo VARCHAR(2) PRIMARY KEY, 
	Nombre VARCHAR(50)
);

CREATE TABLE Materia
(
	Codigo VARCHAR(2) PRIMARY KEY,
	Nombre VARCHAR(50)
)

CREATE TABLE Rinde
(
	Alumno VARCHAR(2), 
	Materia VARCHAR(2),
	PRIMARY KEY (Materia, Alumno),
	FOREIGN KEY (Alumno) REFERENCES Alumno (Legajo),
	FOREIGN KEY (Materia) REFERENCES Materia (Codigo)
)

INSERT INTO Alumno  VALUES ('A1', 'Juan'), ('A2', 'Ana'), ('A3', 'Diego');
INSERT INTO Materia VALUES ('M1', 'Base de Datos'), ('M2', 'Programacion 2'), ('M3', 'Ingles');
INSERT INTO Rinde VALUES ('A1', 'M1'), ('A1', 'M2'), ('A1', 'M3'), ('A2', 'M1'), ('A3', 'M1'),('A3', 'M3');
 
SELECT * FROM Rinde ORDER BY Alumno
SELECT * FROM Alumno
SELECT * FROM Materia

-- Liste el/los alumnos que rindieron todas las materias
-- AR: RESULTADO <- PRO idAlumno(ALUMNO) - PROYECTAR idAlumno ((PROYECTAR idAlumno  (alumno) X PROYECTAR codMat (mat)) - rinde)

SELECT *
FROM Alumno a			-- Ponemos 'a' como ALIAS de alumno
WHERE NOT EXISTS 
	(
	SELECT 'A'			-- Ingreso una costante para optimizar la query
	FROM Materia M		-- Ponemos "M" como alias de Materia
	WHERE NOT EXISTS
		(
		SELECT 1		-- Ingreso una costante para optimizar la query
		FROM Rinde R	-- Ponemos "R" como alias de Rinde
		WHERE a.Legajo = r.Alumno AND m.Codigo = r.Materia	-- Usamos los alias para acceder a las columnas de las tablas
		)
	)

-- Pasos:
--1 - Toma alumno A1, con materia M1
--2 - Toma alumno A1, con materia M2
--3 - Toma alumno A1, con materia M3
-- LISTA EL ALUMNO A1
--4 - Toma alumno A2, con materia M1
--5 - Toma alumno A2, con materia M2 
--6 - Toma alumno A2, con materia M3
-- LISTA LAS MATERIAS M2 Y M3 QUE EL ALUMNO NO RINDIÓ, ENTONCES EL NOT EXISTS DA FALSO, ENTONCES NO LISTA AL ALUMNO A2
--7 - Toma alumno A3, con materia M1
--8 - Toma alumno A3, con materia M2 
--9 - Toma alumno A3, con materia M3
-- LISTA LA MATERIA M2, QUE EL ALUMNO A3 NO RINDIÓ, ENTONCES EL NOT EXISTS DA FALSO, ENTONCES NO LISTA AL ALUMNO A3

-- OTRA FORMA DE RESOLVER LO MISMO:

-- Que sabemos? O que podemos saber?

--1) La cantidad de materias

SELECT COUNT(CODIGO) [Total de materias]
FROM Materia

--2) La cantidad de materias que rindió cada alumno

SELECT Alumno, COUNT(DISTINCT Materia) [Cant materias rendidas]
FROM Rinde
GROUP BY Alumno
ORDER BY Alumno

--3) AHORA JUNTAMOS AMBAS QUERIES 

SELECT Alumno, COUNT(DISTINCT Materia) [Cant materias rendidas]
FROM Rinde
GROUP BY Alumno
HAVING COUNT(DISTINCT Materia) = (SELECT COUNT(Codigo) FROM Materia)
ORDER BY Alumno

-- ¿Que esta comparando en la query anterior? columna 2 (Cant de rendidas) con la 3 (Total de materias).

SELECT Alumno, COUNT(DISTINCT Materia) [Cant materias rendidas], (SELECT COUNT(Codigo) FROM Materia) [Cant total de materias]
FROM Rinde
GROUP BY Alumno

-- MISMA QUERY PERO CON MAS INFO

SELECT a.*, COUNT (r.Materia) AS Cantidad, STRING_AGG(m.Nombre, ', ')
FROM Rinde r JOIN Alumno a ON r.Alumno = a.Legajo JOIN Materia m ON r.Materia = m.Codigo 
GROUP BY a.Legajo, a.Nombre
HAVING COUNT (r.Materia) = (SELECT COUNT (*) FROM Materia)

/******************************************************** Vistas ********************************************************/

---- Las vistas son una forma de guardar CODIGO de una consulta. No se almacena el resultado, SI la consulta y su TXT.

CREATE VIEW Vista1 (Alumno)
AS

	SELECT a.Nombre
	FROM Rinde r JOIN Alumno a ON r.Alumno = a.Legajo
	GROUP BY a.Legajo, a.Nombre 
	HAVING COUNT (r.Materia) = (SELECT COUNT (*) FROM Materia)

---
SELECT * 
FROM Vista1; -- << luego, se puede hacer uso de la vista en el from, como si fuera una tabla

-- El SELECT anterior es equivalente a realizar la siguiente sub consulta:

SELECT *
FROM 
(
	SELECT a.Nombre
	FROM Rinde r JOIN Alumno a ON r.Alumno = a.Legajo
	GROUP BY a.Legajo, a.Nombre 
	HAVING COUNT (r.Materia) = (SELECT COUNT (*) FROM Materia)
) AS Vista1

-- SI ACTUALIZO LA INFO DE LAS TABLAS, SE VE REFLEJADO EN LAS VISTAS
UPDATE Alumno 
SET Nombre = 'Juana'
WHERE Nombre = 'Juan'

-- QUE PASA SI MODIFICO LA INFORMACI�N AGREGANDO MAS VALORES EN RINDE? 
INSERT INTO Rinde VALUES ('A2', 'M2') , ('A2', 'M3') 

SELECT * FROM Vista1;

-- EQUIVALENTE A
SELECT * 
FROM 
(
	SELECT a.Nombre
	FROM Rinde r JOIN Alumno a ON r.Alumno = a.Legajo
	GROUP BY a.Legajo, a.Nombre 
	HAVING COUNT (r.Materia) = (SELECT COUNT (*) FROM Materia)
) AS Vista1

-- BORRADO
DROP VIEW Vista1;

/******************************************************** Funciones ********************************************************/

-- Las funciones son un conjunto de código que retornan valores. 
-- Pueden ser 1 escalar, o una tabla

-- Devolviendo escalar.

CREATE FUNCTION dbo.miFuncion (@Param INT)
RETURNS INT
AS
	BEGIN
		RETURN @Param * 2
	END;

	-- NOTAS: SE CREA UNA FUNCION Que recibe un parametro entero, que además, retorna otro entero.
	-- Luego, con las palabras reservadas BEGIN/END generamos un grupo sin nombre de codigo

-- Ejecución de prueba de la funcion
SELECT dbo.miFuncion(2), dbo.miFuncion(3), dbo.miFuncion(20)

-- Devolviendo tabla
CREATE FUNCTION dbo.miFuncionTabla (@Param INT)
RETURNS TABLE
AS
	RETURN
		(
			SELECT POWER(Campo1, @Param) AS Id, Campo2
			FROM TablaUno
		);
--NOTA: Como se ve, hacemos un RETURN en linea, no hace falta usar un BEGIN/END

-- Ejecución de prueba de la funcion
SELECT * FROM dbo.miFuncionTabla(2);		
SELECT * FROM dbo.miFuncionTabla(3);
SELECT * FROM dbo.miFuncionTabla(4);

-- Para borrar una funcion:
DROP FUNCTION dbo.miFuncion;
DROP FUNCTION dbo.miFuncionTabla;

/******************************** Procedimientos Almacenados (Stored Procedure) ********************************/

-- Un Prodicimento es un conjunto de operaciones que se deben ejecutar de forma reiterativa. 

CREATE PROCEDURE Borra(@Legajo VARCHAR(2))
AS
	DELETE FROM Rinde WHERE Alumno = @Legajo;
	DELETE FROM Alumno WHERE Legajo = @Legajo;

-- Ejecutar procedimiento: 
DELETE FROM Alumno WHERE legajo = 'A1'

EXEC Borra 'A3'
EXECUTE Borra 'A3'

SELECT * FROM Alumno;

/************************************************ Triggers ************************************************/

-- SON ESTRUCTURAS DE CODIGO QUE SE "DISPARAN" CUANDO OCURRE UN EVENTO. 
-- POR EJEMPLO, INSERT, DELETE, UPDATE DE UNA TABLA
 
CREATE TABLE Cliente 
(
	NroCli INT NOT NULL,
	NomCli  VARCHAR(20), 
	CiudadCli VARCHAR(20)
	CONSTRAINT PK_Cliente PRIMARY KEY (NroCli)
)

INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (1,'Cli1','Laferrere')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (2,'Cli2','Laferrere')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (3,'Cli3','San Justo')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (4,'Cli4','Ramos Mejia')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (5,'Cli5','Gonzalez Catan')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (6,'Cli6','San Justo')
INSERT INTO [dbo].[Cliente] (NroCli, [NomCli], [CiudadCli]) VALUES (7,'Cli7','Ramos Mejia')

CREATE TABLE ClienteHistorico
(
	NroCli INT NOT NULL,
	NomCli VARCHAR(20), 
	CiudadCli VARCHAR(20),
	FechaCambio DATETIME NOT NULL,
	Usuario VARCHAR(20),
	Accion VARCHAR(20),
	CONSTRAINT PK_ClienteHistorico PRIMARY KEY (NroCli, FechaCambio)
)

SELECT * 
FROM ClienteHistorico

-- CREAR UN TRIGGER SOBRE CLIENTES, PARA LAS ACCIONES DE BORRADO Y MODIFICACION. ESTE TRIGGER DEBE
--    GUARDAR EN LA TABLA DE HISTORIAL DE CLIENTES EL VALOR PREVIO AL CAMBIO 

-- Se ejecutará el trigger cuando SE HAGA UN DELETE O UN UPDATE en la tabla cliente
DELETE FROM Cliente WHERE NroCli  = 7
UPDATE Cliente set NomCli = '' WHERE NroCli = 6

-- CREACION DEL TRIGGER
CREATE TRIGGER trHistoricoClientes ON Cliente FOR UPDATE, DELETE
AS
	-- IMPORTANTE, LAS ESTRUCTURAS DEL DELETED E INSERTED 
	-- CUANDO SE INSERTA, TENGO LAS TUPLAS NUEVAS, EN INSERTED
	-- CUANDO SE BORRA, TENGO LAS TUPLAS BORRADAS EN DELETED
	-- CUANDO SE ACTUALIZA, TENGO LAS TUPLAS NUEVAS EN INSERTED Y LAS VIEJAS EN DELETED
	-- CUANDO SE ACTUALIZA TENGO LA INFO NUEVA EN INSERTED Y LA VIEJA EN DELETED
	-- EN OTROS MOTORES, SE LLAMAN NEW|OLD.

	IF EXISTS (SELECT * FROM Inserted) -->> ES UN UPDATE 
		INSERT INTO ClienteHistorico  (NroCli, [NomCli], [CiudadCli], FechaCambio, Accion)
		SELECT *, GETDATE(), 'UPDATE'
		FROM Deleted
	ELSE
		INSERT INTO ClienteHistorico  (NroCli, [NomCli], [CiudadCli], FechaCambio, Accion)
		SELECT *, GETDATE(), 'DELETE'
		FROM Deleted
	
-- PRUEBA DEL TRIGGER

UPDATE Cliente
SET CiudadCli = 'San Rafael'
WHERE NroCli = 6

SELECT * FROM Cliente WHERE NroCli = 6
SELECT * FROM ClienteHistorico WHERE NroCli = 6

DELETE FROM Cliente WHERE NroCli = 5

SELECT * FROM Cliente WHERE NroCli = 5
SELECT * FROM ClienteHistorico WHERE NroCli = 5

UPDATE Cliente
SET CiudadCli = 'Tartagal'
WHERE NroCli = 6

SELECT * FROM Cliente WHERE NroCli = 6
SELECT * FROM ClienteHistorico WHERE NroCli = 6