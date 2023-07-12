-- Clase Teorica SQL Parte 3

USE AdventureWorks2019

SELECT *
FROM [Person].[Address]

declare @nro int
set @nro = 213
SELECT @nro AS ColumnaVariable
print @nro
-- Si abro una nueva ventana, la variable @nro no existe en la otra sesion, todo lo que esta en memoria tiene que ver con la sesion

	-- Total: 19972
	-- Personas que tengan 'Ms.' o 'Mr.': 992
	SELECT COUNT(*) AS CantidadTotal
	FROM Person.Person
	WHERE Title IN ('Ms.','Mr.')								-- Lista estatica
	--> Title = 'Ms.' OR Title = 'Mr.'

	-- Menos eficiente: la subconsulta se transforma en una lista fija, lo que va haciendo es una secuencia 
	-- de OR's por cada comparacion.
	SELECT COUNT(*) AS CantidadTotal
	FROM Person.Person
	WHERE Title IN (SELECT Campo1 FROM PruebaIN)				-- Lista dinamica
					-- Subconsulta

	-- Mas eficiente: el EXISTS se va a ejecutar por cada fila que recorra y se va fijar si esta en la otra tabla
	SELECT COUNT(*) AS CantidadTotal
	FROM Person.Person
	WHERE EXISTS (SELECT 1 FROM PruebaIN WHERE Title=Campo1)	-- Lista dinamica

	-- CREATE TABLE PruebaIN (Campo1 varchar(10))
	-- INSERT INTO PruebaIN VALUES ('Ms.'),('Mr.');

	-- sp_updatestats

	DBCC DROPCLEANBUFFERS
	DBCC FREEPROCCACHE

/********************************************** STORED PROCEDURE **********************************************/
-- Procedimiento almacenado: es un proceso que se ejecuta en la bdd para realizar alguna accion que querramos.

-- Create

GO

CREATE PROCEDURE P_CANT_ADDRES
AS
	SELECT *
	FROM Person.Person

GO

-- Alterar

GO

ALTER PROCEDURE P_CANT_ADDRES
AS
	DECLARE @CANT INT
	SET @CANT=(SELECT COUNT(*) 
				FROM Person.Address)
	SELECT @CANT AS CANT_ADDRESS

GO

-- Ejecucion
EXECUTE P_CANT_ADDRES

--=================================================================================================================

-- SP con parametros
-- OUTPUT --> Es necesario declararlo para variables que se reciben como parametros pero no fijos.

GO

CREATE PROCEDURE P_CANT_ADDRESS_PARAMETROS (@CANTOUTPUT INT OUTPUT)
AS
	SET @CANTOUTPUT=(SELECT COUNT(*) 
					FROM Person.Address)

GO

ALTER PROCEDURE P_CANT_ADDRESS_PARAMETROS (@RAZONSOCIAL VARCHAR(100), @CANTOUTPUT INT OUTPUT)
AS
	SET @CANTOUTPUT=(SELECT COUNT(*) 
					FROM Person.Address)

GO

-- Ejecucion

DECLARE @CC INT
--EXECUTE P_CANT_ADDRESS_PARAMETROS @CC
-- El resultado aparece vacio ya que en EXECUTE no se declaro el parametro como salida
-- Debo declarar @CC como OUTPUT:
EXECUTE P_CANT_ADDRESS_PARAMETROS @CC OUTPUT
PRINT 'Resultado:'
PRINT @CC
PRINT '=========='
IF @CC>10000
	PRINT 'MAYOR A 10000'
ELSE
	PRINT 'MENOR A 10000'
-- Debe ir OUTPUT tanto en CREATE como en EXECUTE

DECLARE @RZ VARCHAR(100)
SET @RZ='UNLAM'
PRINT @RZ
PRINT 'RAZON SOCIAL = '+@RZ
EXECUTE P_CANT_ADDRESS_PARAMETROS @RZ, @CC OUTPUT
PRINT 'RAZON SOCIAL 1 = '+@RZ

/********************************************** FUNCTIONS **********************************************/

-- Scalar Functions

-- Ejemplo (Funcion sacada de la base de datos AdventureWorks2019)

GO

CREATE FUNCTION [dbo].[ufnGetStock](@ProductID [int])
RETURNS [int] 
AS 
BEGIN
    DECLARE @ret int;
    SELECT @ret = SUM(p.[Quantity]) 
    FROM [Production].[ProductInventory] p 
    WHERE p.[ProductID] = @ProductID 
        AND p.[LocationID] = '6';
    IF (@ret IS NULL) 
        SET @ret = 0
    RETURN @ret
END;

GO

-- La funcion devuelve un entero
SELECT dbo.ufnGetStock (1) AS VALOR, 'RESULTADO FUNCION' AS RESULTADO

-- dbo (Data Base Ouner) es especifico de SQL Server: es el nombre del esquema
-- Lo que permiten los esquemas es agrupar los objetos segun como nos resulten mas comodo
-- visualizarlo, sirven para invocar al objeto

--=================================================================================================================

-- Table functions

-- Ejemplo (Trigger sacado de la base de datos AdventureWorks2019)

GO

CREATE FUNCTION [dbo].[ufnGetContactInformation](@PersonID int)
RETURNS @retContactInformation TABLE 
(
    -- Formato de la tabla que quiero que devuelva
	[PersonID] int NOT NULL, 
    [FirstName] [nvarchar](50) NULL, 
    [LastName] [nvarchar](50) NULL, 
	[JobTitle] [nvarchar](50) NULL,
    [BusinessEntityType] [nvarchar](50) NULL
)
AS 
BEGIN
	IF @PersonID IS NOT NULL 
		BEGIN
		IF EXISTS(SELECT * FROM [HumanResources].[Employee] e 
					WHERE e.[BusinessEntityID] = @PersonID) 
			INSERT INTO @retContactInformation
				SELECT @PersonID, p.FirstName, p.LastName, e.[JobTitle], 'Employee'
				FROM [HumanResources].[Employee] AS e
					INNER JOIN [Person].[Person] p
					ON p.[BusinessEntityID] = e.[BusinessEntityID]
				WHERE e.[BusinessEntityID] = @PersonID;

		IF EXISTS(SELECT * FROM [Purchasing].[Vendor] AS v
					INNER JOIN [Person].[BusinessEntityContact] bec 
					ON bec.[BusinessEntityID] = v.[BusinessEntityID]
					WHERE bec.[PersonID] = @PersonID)
			INSERT INTO @retContactInformation
				SELECT @PersonID, p.FirstName, p.LastName, ct.[Name], 'Vendor Contact' 
				FROM [Purchasing].[Vendor] AS v
					INNER JOIN [Person].[BusinessEntityContact] bec 
					ON bec.[BusinessEntityID] = v.[BusinessEntityID]
					INNER JOIN [Person].ContactType ct
					ON ct.[ContactTypeID] = bec.[ContactTypeID]
					INNER JOIN [Person].[Person] p
					ON p.[BusinessEntityID] = bec.[PersonID]
				WHERE bec.[PersonID] = @PersonID;
		
		IF EXISTS(SELECT * FROM [Sales].[Store] AS s
					INNER JOIN [Person].[BusinessEntityContact] bec 
					ON bec.[BusinessEntityID] = s.[BusinessEntityID]
					WHERE bec.[PersonID] = @PersonID)
			INSERT INTO @retContactInformation
				SELECT @PersonID, p.FirstName, p.LastName, ct.[Name], 'Store Contact' 
				FROM [Sales].[Store] AS s
					INNER JOIN [Person].[BusinessEntityContact] bec 
					ON bec.[BusinessEntityID] = s.[BusinessEntityID]
					INNER JOIN [Person].ContactType ct
					ON ct.[ContactTypeID] = bec.[ContactTypeID]
					INNER JOIN [Person].[Person] p
					ON p.[BusinessEntityID] = bec.[PersonID]
				WHERE bec.[PersonID] = @PersonID;

		IF EXISTS(SELECT * FROM [Person].[Person] AS p
					INNER JOIN [Sales].[Customer] AS c
					ON c.[PersonID] = p.[BusinessEntityID]
					WHERE p.[BusinessEntityID] = @PersonID AND c.[StoreID] IS NULL) 
			-- Inserta en la variable que esta definida los valores que quiero que retorne
			INSERT INTO @retContactInformation
				SELECT @PersonID, p.FirstName, p.LastName, NULL, 'Consumer' 
				FROM [Person].[Person] AS p
					INNER JOIN [Sales].[Customer] AS c
					ON c.[PersonID] = p.[BusinessEntityID]
					WHERE p.[BusinessEntityID] = @PersonID AND c.[StoreID] IS NULL; 
		END

	RETURN;
END;

GO

-- Invocacion:
SELECT *
FROM dbo.ufnGetContactInformation (1)
-- Lo que devuelve es la informacion (tabla) del contacto de PersonID 1

--=================================================================================================================

DECLARE @x TABLE (campo1 int)

INSERT INTO @x VALUES('1')
INSERT INTO @x VALUES('1')

SELECT *
FROM @x

--=================================================================================================================

GO

CREATE FUNCTION dbo.f_test()
RETURNS int
AS
BEGIN
	declare @valor int
	set @valor=(SELECT COUNT(*) FROM Person.Address)
	return @valor
END

GO

SELECT dbo.f_test ()

--=================================================================================================================

-- Funciones del sistema

-- LOWER = convierte el string en minuscula
-- LEFT = devuelve n caracter/caracteres a partir de la izquierda
SELECT TOP 10 City, LOWER(City) AS CiudadMinuscula, LEFT(City,1) AS CiudadPrimerCaracter
FROM Person.Address

-- MONTH = Dada una variable de tipo fecha, devuelve unicamente el mes
SELECT TOP 10 ModifiedDate, MONTH(ModifiedDate) AS Mes
FROM Person.Address

-- Muestra unicamente las primeras 10 que fueron modificadas en diciembre del 2008
SELECT TOP 10 ModifiedDate
FROM Person.Address
WHERE MONTH(ModifiedDate)=12 AND YEAR(ModifiedDate)=2008

/********************************************** TRIGGER **********************************************/

CREATE TABLE TABLAPRUEBA (campo1 int, campo2 varchar(10), fecha datetime)

INSERT INTO TABLAPRUEBA VALUES (1,'A',NULL)
INSERT INTO TABLAPRUEBA VALUES (1,'B',NULL)

SELECT * FROM TABLAPRUEBA

DROP TABLE TABLAPRUEBA

--=================================================================================================================

GO

CREATE TRIGGER tg_prueba ON TABLAPRUEBA AFTER INSERT
AS
	UPDATE TABLAPRUEBA SET fecha=GETDATE()

GO

INSERT INTO TABLAPRUEBA VALUES (2,'C',NULL)
-- Cuando se inserto actualizo en todas las filas del campo fecha (solo queria que cambia en la fila que inserte)

--=================================================================================================================

GO

ALTER TRIGGER tg_prueba ON TABLAPRUEBA AFTER INSERT
AS
	UPDATE TABLAPRUEBA SET fecha=GETDATE()
	WHERE campo1 IN (SELECT campo1 FROM inserted)	-- Faltaba esta linea

GO

INSERT INTO TABLAPRUEBA VALUES (3,'C',NULL)
SELECT * FROM TABLAPRUEBA

-- Si el INSERT no fue exitoso no se ejecuta el trigger

--=================================================================================================================
-- Como insertar valores tipo DATE
INSERT INTO ALUMNO VALUES (24493,'Sandoval','Leandro',CAST('22/10/1998' AS DATE),'M','Gonzalez Catan')

SELECT *
FROM ALUMNO AS a
WHERE a.CIUDAD='Gonzalez Catan'

DELETE FROM ALUMNO WHERE CIUDAD='Gonzalez Catan'

--=================================================================================================================

GO

CREATE TRIGGER tg_prueba2 ON TABLAPRUEBA INSTEAD OF INSERT
AS
	UPDATE TABLAPRUEBA SET fecha=GETDATE()
	WHERE campo1 IN (SELECT campo1 FROM inserted)

GO

INSERT INTO TABLAPRUEBA VALUES (3,'C',NULL)
SELECT * FROM TABLAPRUEBA

-- No se inserto el valor porque en ningun lado dentro del trigger hice el insert. Lo que sucede es que el insted of reemplaza
-- a la funcion original si esa no hace lo que la funcion original tenia que hacer. ?) 

--=================================================================================================================

GO

CREATE TRIGGER tg_prueba3 ON TABLAPRUEBA
INSTEAD OF DELETE
AS
	DECLARE @I INT
	SET @I=0

GO

-- En lugar de hacer un DELETE se ejecuta el trigger

DELETE FROM TABLAPRUEBA
SELECT * FROM TABLAPRUEBA

-- No se borra la tabla, en lugar de eso asigna un valor a una variable