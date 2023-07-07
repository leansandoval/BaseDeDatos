-- CLASE TEORICA SQL PARTE I

/* Crear base de datos

-- Con parametros

CREATE DATABASE UNLAM2021  --Pone por default [] para caracteres especiales, en este caso lo puedo sacar
 CONTAINMENT = NONE
 ON  PRIMARY	-- Es el archivo de datos que voy a definir. Toda BDD tiene un archivo .log y otro archivo de datos
( NAME = N'UNLAM2021', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UNLAM2021.mdf' , 
SIZE = 512KB , MAXSIZE = 102400KB , FILEGROWTH = 1MB )
 LOG ON 
( NAME = N'UNLAM2021_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\UNLAM2021.ldf' , 
SIZE = 512KB , MAXSIZE = 51200KB , FILEGROWTH = 1MB )	-- Establezco un tamanio inicial, tamanio maximo y de a cuanto va a crecer esta BDD
GO

-- Voy a crearla sin parametros con la instruccion CREATE 

CREATE DATABASE UNLAM2021_B
DROP DATABASE UNLAM2021_B

-- Crear una tabla
CREATE TABLE ALUMNO(Legajo int not null,nya varchar(100))
*/

/*Uso del INSERT*/

USE [AdventureWorks2017]						-- Indica en que base de datos voy a trabajar
SELECT * FROM Person.Person						-- Muestra todos los campos de la tabla
SELECT FirstName FROM Person.Person				-- Muestra unicamente el campo FirstName
SELECT FirstName,LastName FROM Person.Person	-- Muestra unicamente los campos FirstName y LastName

--Otra forma de declaracion (Con enters)
SELECT
	FirstName,
	LastName
FROM
	Person.Person

-- Otra forma
-- SELECT TOP 5							-- TOP 5 = cantidad maxima que quiero que muestre, muestra las primeras 5 en este caso, si el la cantidad de TOP supera la cantidad que hay en los campos, muestra todos
SELECT DISTINCT FirstName--,LastName	-- DISTINCT= ofrece valores distintos por fila (si hay nombres repetidos los omite)
FROM Person.Person
WHERE
	--FirstName='Alan' OR FirstName='Jenny' OR FirstName='Bianca'
	--FirstName IN('Alan','Jenny','Bianca')
	(FirstName='Alan' AND LastName='Xu') OR FirstName='Bianca'
--ORDER BY LastName DESC, FirstName ASC	--ORDER BY= ordena por campo

SELECT 
	--FirstName as Nombre,LastName as Apellido
	FirstName Nombre,LastName Apellido,LastName Apellido2,p.MiddleName,UPPER(LastName) AS ApellidoMayuscula
FROM
	--Person.Person as p
	Person.Person p
WHERE
	--FirstName LIKE 'A%'			-- Muestra todas aquellas personas que comienzen con A. El % es parecido al *, muestra todos los valores posible que siguen
	--FirstName LIKE 'Al%'			-- Muestra todas aquellas personas que comienzen con Al
	FirstName LIKE 'Al%a'			-- Muestra todas aquellas personas que comienzen con Al y que terminen en a
	--FirstName LIKE '%a'			-- Muestra todas aquellas personas que terminen con a
	--FirstName LIKE 'Ale%a'		-- Muestra todas aquellas personas que comienzen con Ale y que terminen en a
	--FirstName LIKE 'ale_a'		-- Muestra todas aquellas personas que comienzen con ale y que terminen en a. El _ hace referencia a que muestra un unico caracter
	--FirstName LIKE 'ale%a' AND ApellidoMayuscula='BELL'	-- MAL!! No ejecuta porque no reconoce alias
	--FirstName LIKE 'ale%a' AND upper(LastName)='BELL'		-- Forma correcta
ORDER BY
	ApellidoMayuscula

--Crear una tabla
CREATE TABLE AlgunosValores(Nombre VARCHAR(100))

--Insertar valores
INSERT INTO AlgunosValores VALUES('Alexia')
INSERT INTO AlgunosValores VALUES('Alexandria')
INSERT INTO AlgunosValores VALUES('Ken')

--Borra todos los valores de AlgunosValores (No la tabla)
DELETE FROM AlgunosValores		

SELECT * 
FROM AlgunosValores	

--Uso de alias
SELECT *
FROM Person.Person AS P	
/*Si uso IN
WHERE FirstName IN (SELECT Nombre FROM AlgunosValores) 
WHERE FirstName IN ('Alexia','Alexandria')
*/

/*Si uso ANY o SOME
--Devuelve aquellas personas cuyo primer nombre sea igual a cualquiera de estos valores que se encuentra en AlgunosValores
--WHERE FirstName = ANY (SELECT Nombre FROM AlgunosValores)  
--La diferencia entre ANY e IN es que ANY requiere un operador porque es mas grande que IN. IN es un caso especifico de = en ANY
--WHERE FirstName >= ANY (SELECT Nombre FROM AlgunosValores)
--Puedo hacer un nivel de comparacion >= (Compara por string). ANY permite otro tipos de operadores. IN es solo operador de =
*/

/*Si uso ALL
--Devuelve aquellas personas cuyo primer nombre sea mayor o igual a los valores que se encuentra en AlgunosValores
--Al tratarse de una AND siempre sera la condicion del Nombre que sea mayor a los demas (en este caso Ken)
*/
WHERE FirstName >= ALL (
						SELECT Nombre 
						FROM AlgunosValores
					   )
ORDER BY FirstName

/*--Uso del EXISTS
--Devuelve todos los valores, ya que en AlgunosValores hay al menos un valor
WHERE EXISTS (SELECT * FROM AlgunosValores)	--V o F
--Aunque se encuentre el nombre Ken en AlgunosValores, devuelve TODOS los valores ya que da verdadero
WHERE EXISTS (SELECT * FROM AlgunosValores WHERE Nombre='Ken')

--Esto es equivalente a
if exists(select * from AlgunosValores)
	print 'Verdadero'	--V
else
	print 'Falso'		--F

--Quiero traer solo aquellos datos cuyo nombre este en AlgunosValores
SELECT *
FROM Person.Person p	--Bloque de afuera
WHERE EXISTS(SELECT * FROM AlgunosValores a WHERE p.FirstName=a.Nombre)	--Bloque de adentro
--Cada condicion que de verdadero de esta igualdad, lo imprime (es necesario agregar alias)

/*En general, el EXISTS se usa cuando tenemos que comparar algo que esta en el bloque de afuera con el bloque de adentro
Todo lo que esta en Person.Person existe adentro de los parentesis de EXISTS eso quiere decir que todos los campos de 
Person.Person se pueden utilizar dentro de el, pero no los campos que estan en la tabla AlgunosValores. Siempre la existencia 
de los campos es de afuera hacia la subconsulta de adentro pero no de la subconsulta de adentro hacia afuera
Ejemplo: ORDER BY Nombre	--Esto es invalido
Es importante los alias porque necesito saber de que tabla es FirstName dentro de EXISTS y con que tabla hay que compararla con
Nombre*/
