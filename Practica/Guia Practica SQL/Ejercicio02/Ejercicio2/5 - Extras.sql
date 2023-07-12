-- 1. CREAR UNA TABLA DE HISTORICO PARA ARTICULOS CON LOS MISMOS CAMPOS QUE LA TABLA ORIGINAL Y ADEMAS LA FECHA DE CAMBIO Y EL USUARIO

USE Ejercicio_2
GO
 
CREATE TABLE ArticuloHistorico
(
	NroArt INT NOT NULL,
	Descripcion VARCHAR(20),
	CiudadArt  VARCHAR(20),
	Precio DECIMAL(10,4),
	FechaCambio DATETIME NOT NULL,
	Usuario VARCHAR(20),
	PRIMARY KEY  (NroArt, FechaCambio)
)

-- 2. CREAR UN STORE PROCEDURE PARA REALIZAR LA CREACION DE UN NUEVO ARTICULO QUE RECIBA POR PARAMETRO:
/*
	Descripcion VARCHAR(20),
	CiudadArt  VARCHAR(20),
	Precio DECIMAL(10,4),
*/

-- DROP PROCEDURE sCrearArticulo

GO

CREATE OR ALTER PROCEDURE sCrearArticulo (@Descripcion VARCHAR(20), @CiudadArt VARCHAR(20), @Precio DECIMAL(10,4))
AS
	-- Valido si existe la descripcion, si no existe, creo el articulo
	IF NOT EXISTS (SELECT 1 FROM Articulo WHERE Descripcion LIKE @Descripcion)
	BEGIN
		-- Como se inserta el NroArt?
		INSERT INTO [dbo].[Articulo] ([Descripcion], [CiudadArt], [Precio])
		VALUES (LOWER (@Descripcion),  UPPER (@CiudadArt), @Precio) 
	END
	ELSE 
	BEGIN
		-- Si existe, devuelvo un error
		RAISERROR('Descripcion ya existente', 16, 10)
	END

GO

-- MODIFICO CON ALTER PROC ....
-- BORRO CON DROP PROC ...
-- EJECUTO CON EXEC nombreProc

EXEC sCrearArticulo 'Desc 1', 'Ciudad 1', 10

SELECT * FROM Articulo

-- 3. CREAR UN SP QUE MODIFIQUE EL PRECIO DE LOS ARTICULOS. ESTE SP DEBE ALMACENAR EN LA TABLA DE HISTORICOS EL VALOR ANTERIOR DEL ARTICULO
/*
PARAMETROS
	NroArt INT,
	Precio DECIMAL(10,4),
	Usuario VARCHAR(20),
*/

--DROP PROCEDURE sActualizaPrecioArticulo

GO

CREATE OR ALTER PROCEDURE sActualizaPrecioArticulo (@NroArt INT, @PrecioNuevo DECIMAL(10,4), @Usuario VARCHAR(20))
AS
	-- Guardo en el historico, el valor actual
	INSERT INTO ArticuloHistorico  (NroArt, [Descripcion], [CiudadArt], [Precio], FechaCambio, Usuario)
	SELECT NroArt, [Descripcion], [CiudadArt], [Precio], GETDATE(), @Usuario
	FROM Articulo
	WHERE NroArt = @NroArt

	UPDATE Articulo
	SET Precio = @PrecioNuevo
	WHERE NroArt = @NroArt

GO

-- Ejecuto
EXEC sActualizaPrecioArticulo 1000, 90.50, 'Alfonso'

-- Listo y pruebo
SELECT * 
FROM Articulo AS a
WHERE a.NroArt = 1

SELECT * 
FROM ArticuloHistorico AS ah
WHERE ah.NroArt = 1

-- 4. CREAR UN SP QUE BORRE UN ARTICULO. TENER CUIDADO! LA TABLA DE ARTICULOS ESTA RELACIONADA CON LA TABLA Pedido!
--    SI EL ARTICULO FUE USADO EN ALGUN pedido NO BORRARLO. RETORNAR UN CUSTOM ERROR (Ver notas)
/*
PARAMETROS
	NroArt INT,
	Usuario VARCHAR(20),
*/

GO

CREATE OR ALTER PROCEDURE sDeleteArticulo (@NroArt INT, @Usuario VARCHAR(20))
AS
	IF EXISTS (SELECT 1 FROM Pedido WHERE NroArt = @NroArt)
	BEGIN 
		RAISERROR('Producto usado en pedidos', 16, 1)
	END

	INSERT INTO ArticuloHistorico  (NroArt, [Descripcion], [CiudadArt], [Precio], FechaCambio, Usuario)
	SELECT NroArt, [Descripcion], [CiudadArt], [Precio], GETDATE(), @Usuario
	FROM Articulo
	WHERE NroArt = @NroArt

	DELETE FROM Articulo WHERE NroArt = @NroArt

GO

-- Ejecuto
EXEC sDeleteArticulo 8, 'Juan'

-- Listo y pruebo
SELECT * 
FROM Articulo 
WHERE NroArt = 8

SELECT * 
FROM ArticuloHistorico 
WHERE NroArt = 8

-- 5. CREAR UNA TABLA PARA HISTORIAL DE CAMBIOS DE CLIENTES. 

CREATE TABLE ClienteHistorico
(
	NroCli INT NOT NULL,
	NomCli  VARCHAR(20), 
	CiudadCli VARCHAR(20),
	FechaCambio DATETIME NOT NULL,
	Usuario VARCHAR(20),
	CONSTRAINT PK_ClienteHistorico PRIMARY KEY (NroCli, FechaCambio)
)

SELECT * 
FROM ClienteHistorico

-- 6. CREAR UN TRIGGER SOBRE CLIENTES, PARA LAS ACCIONES DE BORRADO Y MODIFICACION. ESTE TRIGGER DEBE
--    GUARDAR EN LA TABLA DE HISTORIAL DE CLIENTES EL VALOR PREVIO AL CAMBIO 

-- Se ejecutara el trigger cuando SE HAGA UN DELETE O UN UPDATE en la tabla cliente
DELETE FROM Cliente 
WHERE NroCli = 100

UPDATE Cliente 
SET NomCli = '' 
WHERE NroCli = 100

-- CREACION DEL TRIGGER

GO

CREATE OR ALTER TRIGGER trHistoricosClientes ON Cliente FOR UPDATE, DELETE
AS
	-- IMPORTANTE, LAS ESTRUCTURAS DEL DELETED E INSERTED 
	-- CUANDO SE INSERTA, TENGO LAS TUPLAS NUEVAS, EN INSERTED
	-- CUANDO SE BORRA, TENGO LAS TUPLAS BORRADAS EN DELETED
	-- CUANDO SE ACTUALIZA TENGO LA INFO NUEVA EN INSERTED Y LA VIEJA EN DELETED
	-- EN OTROS MOTORES, SE LLAMAN NEW|OLD.

	INSERT INTO ClienteHistorico  (NroCli, [NomCli], [CiudadCli], FechaCambio)
	SELECT *, GETDATE()
	FROM Deleted

GO

-- PRUEBA DEL TRIGGER

UPDATE Cliente
SET NomCli = 'Cliente nuevo'
WHERE NroCli = 10000

SELECT * 
FROM Cliente 
WHERE NroCli = 1

SELECT * 
FROM ClienteHistorico 
WHERE NroCli = 1

DELETE FROM Cliente
WHERE NroCli IN (SELECT NroCli FROM Pedido WHERE NroCli = 1)

/*======================================================================================================================================*/

/* Nota. revisar la funcion de raiserror 

Link: https://docs.microsoft.com/en-us/sql/t-sql/language-elements/raiserror-transact-sql?view=sql-server-ver15

TRIGGERS STATMENT: https://docs.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver15

TRIGGER ESTRUCTURA BASICA:

CREATE TRIGGER NombreTrigger ON NombreTabla
{ FOR | AFTER | INSTEAD OF }   -- DEFINEN CUANDO SE EJECUTARA EL TRIGGER (ANTES, DESPUES O EN LUGAR DE)
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   -- DEFINE CUAL OPERACION SERA ASOCIADA AL TRIGGER
AS 
-- ..................... CODIGO SQL A EJECUTAR

-- EJEMPLO
GO

CREATE TRIGGER Ejemplo1										-- Creo el trigger
ON Proveedor												-- Indico la tabla a la que esta asociado
AFTER INSERT, UPDATE										-- Indico a que operaciones me refiero 
AS RAISERROR ('Ejemplo de raiseeror y trigger', 16, 10);	-- Retorno un error

GO

Que hace el trigger anterior ? Que no me permite hacer? */