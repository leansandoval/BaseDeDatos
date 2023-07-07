/*1- Redactar las sentencias que permitan agregar las restricciones de integridad referencial permitiendo 
la actualizacion automatica para el caso de actualizar o eliminar un banco, moneda o persona.
Demostrar el correcto funcionamiento de las restricciones creadas
Redactar las sentencias que permitan eliminar las restricciones creadas en el paso anterior.*/

/** Cuenta posee IdBanco, hace referencia a la tabla Banco
* Cuenta posee IdMoneda, hace referencia a la tabla Moneda
* Cuenta posee IdPersona, hace referencia a la tabla Persona
* Opera posee IdBanco, hace referencia a la tabla Banco
* Opera posee IdMoneda, hace referencia a la tabla Moneda

El unico tipo de CONSTRAINT que esta creada en Cuenta y Opera es la PRIMARY KEY es PK_Persona.
No estan creadas la claves foraneas.
Las FK tiene como restricciones , por ejemplo, no insertar un nuevo idBanco que no exista en la tabla Banco.
Tiene que existir tanto en Banco, Moneda y Persona.

El ejercicio pide crear las FK que estan faltando en Cuenta y Opera*/

ALTER TABLE Cuenta ADD CONSTRAINT FK_Cuenta_IdBanco FOREIGN KEY (IdBanco) REFERENCES Banco (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Cuenta ADD CONSTRAINT FK_Cuenta_IdMoneda FOREIGN KEY (IdMoneda) REFERENCES Moneda (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Cuenta ADD CONSTRAINT FK_Cuenta_IdPersona FOREIGN KEY (IdPersona) REFERENCES Persona (Pasaporte) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Opera ADD CONSTRAINT FK_Opera_IdBanco FOREIGN KEY (IdBanco) REFERENCES Banco (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Opera ADD CONSTRAINT FK_Opera_IdMoneda FOREIGN KEY (IdMoneda) REFERENCES Moneda (Id) ON DELETE CASCADE ON UPDATE CASCADE;

-- Esto quiere decir que si ahora actualizo o borro algo de las tablas Cuenta y Opera tambien se borraran de sus respectivas tablas

-- Si las quiero borrar:

ALTER TABLE Cuenta DROP CONSTRAINT FK_Cuenta_IdBanco;
ALTER TABLE Cuenta DROP CONSTRAINT FK_Cuenta_IdMoneda;
ALTER TABLE Cuenta DROP CONSTRAINT FK_Cuenta_IdPersona;

ALTER TABLE Opera DROP CONSTRAINT FK_Opera_IdBanco;
ALTER TABLE Opera DROP CONSTRAINT FK_Opera_IdMoneda;

/*2 - Listar los bancos que solamente operan todas las monedas que no son el PESO URUGUAYO.
Utilizar una vista para todas las monedas.*/

CREATE VIEW vBancosQueOperanMonedasMenosElPesoUY AS
(
	SELECT b.Id
	FROM Banco AS b
	EXCEPT
	SELECT o.IdBanco
	FROM Opera AS o
	WHERE o.IdMoneda = 'UY'
)

SELECT *
FROM vBancosQueOperanMonedasMenosElPesoUY AS b
WHERE NOT EXISTS (
	SELECT 1
	FROM Moneda AS m
	WHERE m.Id NOT LIKE 'UY' 
	AND NOT EXISTS (
		SELECT 1
		FROM Opera AS o
		WHERE o.IdBanco = b.Id AND o.IdMoneda = m.Id
					)
				)

-- 3. Utilizando la vista anterior, actualizar el nombre del 'BANCO CIUDAD' por el nombre: 'BANCO DE LA CIUDAD DE BUENOS AIRES'

/*Vista NO actualizable: No es posible ya que la vista es muy compleja
UPDATE vBancosQueOperanConTodasMonedasMenosUY
SET Nombre = 'Banco de la Ciudad de Buenos Aires'
WHERE Nombre = 'Banco Ciudad'*/

CREATE OR ALTER VIEW vTodosLosBancos AS
(
	SELECT *
	FROM Banco AS b
)

UPDATE vTodosLosBancos
SET Nombre = 'Banco de la Ciudad de Buenos Aires'
WHERE Nombre = 'Banco Ciudad'

SELECT *
FROM vTodosLosBancos

/*4 - Crear una funcion que devuelva el valor oro de una moneda. La misma debe recibir como parametro el 
codigo de la moneda y devolver el valor -1 para el caso en que la moneda no exista.*/

CREATE OR ALTER FUNCTION fValorOroMoneda (@IdMoneda CHAR(2)) RETURNS DECIMAL(18,3) AS
BEGIN
	DECLARE @ValorOro DECIMAL(18,3) = -1;
	IF EXISTS (SELECT 1 FROM Moneda WHERE Id = @IdMoneda)
		SET @ValorOro = (SELECT m.ValorOro FROM Moneda AS m WHERE m.Id = @IdMoneda)
	RETURN @ValorOro
END

SELECT dbo.fValorOroMoneda('UR')
SELECT dbo.fValorOroMoneda('UY')

-- 5. Crear una funcion que retorne el pasaporte y el nombre de las personas que tienen cuenta en todos los bancos.

CREATE OR ALTER FUNCTION fPersonasConCuentaEnTodosLosBancos () RETURNS TABLE AS
RETURN (SELECT p.Pasaporte, p.Nombre
		FROM Persona AS p
		WHERE NOT EXISTS (
			SELECT 1
			FROM Banco AS b
			WHERE NOT EXISTS (
				SELECT 1
				FROM Cuenta AS c
				WHERE c.IdPersona = p.Pasaporte AND b.Id = c.IdBanco
							)
						)
		)

SELECT *
FROM fPersonasConCuentaEnTodosLosBancos()

-- 6. Crear un SP que muestre por pantalla a las personas que tienen mas de 3 cuentas en dolares en bancos extranjeros.

CREATE OR ALTER PROCEDURE pPersonasConMasDe3CuentasEnDolaresEnBancosExtranjeros AS
BEGIN
	SELECT c.IdPersona
	FROM Cuenta AS c JOIN Banco AS b ON c.IdBanco = b.Id
	WHERE c.IdMoneda LIKE 'US' AND b.Pais NOT LIKE 'Argentina'
	GROUP BY c.IdPersona
	HAVING COUNT(*) >= 3
END

/*7 - Crear un SP que reciba por parametro un pasaporte y muestre las cuentas asociadas a la misma. 
Si el pasaporte no existe, mostrar un mensaje de error.*/

CREATE OR ALTER PROCEDURE pCuentasDePersona (@Pasaporte CHAR(15)) AS
BEGIN
	IF EXISTS (SELECT 1 FROM Persona AS p WHERE p.Pasaporte = @Pasaporte)
		SELECT c.* FROM Cuenta AS c WHERE c.IdPersona = @Pasaporte;
	ELSE
		RAISERROR('Pasaporte inexistente', 1, 10);
END

/*8 - Crear un Trigger que realice el respaldo de los datos de un Banco cuando el mismo es eliminado. El trigger no debe 
permitir que se eliminen bancos que operan con la moneda "PESO ARGENTINO"
Se debe crear una tabla "BancoRespaldo".*/

-- Nota: cuando se copia la tabla, no se copian las CONSTRAINT ni las claves, hay que tener en cuenta eso (por si lo pidieran)

SELECT * INTO BancoRespaldo FROM Banco
TRUNCATE TABLE BancoRespaldo
SELECT * FROM BancoRespaldo

/*-- Integridad referencial (Leer la nota de arriba):
ALTER TABLE BancoRespaldo ADD CONSTRAINT PK_Banco_RespaldoId PRIMARY KEY (Id);
ALTER TABLE Cuenta ADD CONSTRAINT FK_Cuenta_IdBanco_BR FOREIGN KEY (IdBanco) REFERENCES BancoRespaldo(Id) ON DELETE CASCADE;
ALTER TABLE Opera ADD CONSTRAINT FK_Opera_IdBanco_BR FOREIGN KEY (IdBanco) REFERENCES BancoRespaldo(Id) ON DELETE CASCADE;

-- Si las quiero borrar:
ALTER TABLE Cuenta DROP CONSTRAINT FK_Cuenta_IdBanco_BR;
ALTER TABLE Opera DROP CONSTRAINT FK_Opera_IdBanco_BR;
ALTER TABLE BancoRespaldo DROP CONSTRAINT PK_Banco_RespaldoId;
*/

CREATE OR ALTER TRIGGER tEliminarBanco ON Banco INSTEAD OF DELETE AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Deleted AS d JOIN Opera AS o ON d.Id = o.IdBanco WHERE o.IdMoneda LIKE 'AR')
	BEGIN
		INSERT INTO BancoRespaldo SELECT * FROM Deleted
		DELETE FROM Banco WHERE Id IN (SELECT Id FROM Deleted)
	END
	ELSE
		PRINT('El banco que se quiere eliminar opera con pesos argentinos');
END

/*9 - Crear un Trigger que actualice el id de moneda en las tablas opera y cuenta para cuando un codigo de moneda 
sea actualizado en la tabla moneda.*/

CREATE OR ALTER TRIGGER tActualizarMoneda ON Moneda AFTER UPDATE AS
BEGIN
	DECLARE @IdViejo CHAR(2) = (SELECT d.Id FROM Deleted AS d)
	DECLARE @IdNuevo CHAR(2) = (SELECT i.Id FROM Inserted AS i)
	UPDATE Opera SET IdMoneda = @IdNuevo WHERE IdMoneda = @IdViejo
	UPDATE Cuenta SET IdMoneda = @IdNuevo WHERE IdMoneda = @IdViejo
END

-- 10. Listar a las personas que no tienen ninguna cuenta en "pesos argentinos" en Ningún banco. 
-- Que además tengan al menos dos cuentas en "dólares"

(SELECT c.IdPersona
FROM Cuenta AS c JOIN Moneda AS m ON c.IdMoneda = m.Id
WHERE m.Descripcion = 'Dolar'
GROUP BY c.IdPersona
HAVING COUNT(c.IdBanco) >= 2)

INTERSECT

(SELECT p.Pasaporte
FROM Persona AS p
EXCEPT
SELECT DISTINCT c.IdPersona
FROM Moneda AS m JOIN Cuenta AS c ON c.IdMoneda = m.Id
WHERE m.Descripcion = 'Peso Argentino')

-- 11. Listar de las monedas que son operadas en todos los bancos, aquellas con el valor oro más alto.

CREATE OR ALTER VIEW vMonedasQueOperanEnTodosLosBancos AS
(
	SELECT *
	FROM Moneda AS m
	WHERE NOT EXISTS (
		SELECT 1
		FROM Banco AS b
		WHERE NOT EXISTS (
			SELECT 1
			FROM Opera AS o
			WHERE b.Id = o.IdBanco AND m.Id = o.IdMoneda
						)
					)
)

SELECT v.Id
FROM vMonedasQueOperanEnTodosLosBancos AS v
WHERE v.ValorOro = (SELECT MAX(v.ValorOro)
					FROM vMonedasQueOperanEnTodosLosBancos AS v)

