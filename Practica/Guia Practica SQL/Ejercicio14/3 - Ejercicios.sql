/*Ejercicio 14: Dado el siguiente esquema de relación

	Festejo (NroFestejo, descripción, fecha, nrocliente)
	Contrata (NroFestejo, Item, NroServicio, HDesde, HHasta)
	Servicio (NroServicio, Descripción, Precio)
	Cliente (NroCliente, RazonSocial)*/

USE Ejercicio_14
GO

/*1. p_Servicios(FDesde, FHasta): Crear un procedimiento almacenado que permita listar aquellos servicios que 
fueron contratados en todos los festejos del período enviado por parámetro. De dichos servicios mostrar el 
nombre y la cantidad de horas que fueron contratadas en el período enviado por parámetro.
Ejemplificar la invocación del procedimiento.*/

CREATE OR ALTER PROCEDURE pServicios (@FDesde DATE, @FHasta DATE) AS
BEGIN
	SELECT s.Descripcion [Nombre], SUM(DATEDIFF(HH,c.HDesde,c.HHasta)) [Cantidad de horas contratadas]
	FROM (SELECT s.NroServicio
		  FROM Servicio AS s
		  WHERE NOT EXISTS (SELECT 1 FROM Festejo AS f WHERE NOT EXISTS 
					       (SELECT 1 FROM Contrata AS c WHERE c.NroFestejo = f.NroFestejo 
						    AND s.NroServicio = c.NroServicio
							AND f.Fecha >= @FDesde AND f.Fecha <= @FHasta))) AS setlf
	JOIN Contrata AS c ON setlf.NroServicio = c.NroServicio 
	JOIN Servicio AS s ON setlf.NroServicio = s.NroServicio
	GROUP BY s.Descripcion
END

EXECUTE pServicios '01-03-2020','20-11-2022'

/*2. Agregar el campo “Tiempo” en la tabla “Contrata” de tipo smallint, que no acepte nulos y que posea como 
valor predeterminado 0 (cero). Este campo servirá para que ya se encuentre precalculado la cantidad de minutos 
que fue contratado el servicio, sin necesidad de realizar el cálculo con los campos de la tabla.*/

ALTER TABLE Contrata ADD Tiempo SMALLINT NOT NULL DEFAULT 0

/*3. tg_Tiempo: Crear un trigger que cada vez que se cambia la hora desde/hasta o bien se agregue un nuevo 
servicio contratado, recalculo el campo “Tiempo” con el tiempo en minutos del servicio. Validar que la hora 
desde no puede ser posterior a la hora hasta, si esto sucede se deberá avisar y volver atrás la operación. 
Además, tener en cuenta las actualizaciones masivas. Ejemplificar la invocación del trigger.*/

CREATE OR ALTER TRIGGER tgTiempo ON Contrata INSTEAD OF INSERT, UPDATE AS
BEGIN
	DECLARE @HDesdeNuevo TIME = (SELECT HDesde FROM Inserted)
	DECLARE @HHastaNuevo TIME = (SELECT HHasta FROM Inserted)
	IF(@HDesdeNuevo > @HHastaNuevo)
		RAISERROR('La hora desde es superior a la hora hasta',1,10);
	ELSE IF NOT EXISTS (SELECT * FROM Deleted)			-- Se trata de un INSERT
	BEGIN 
		INSERT INTO Contrata SELECT * FROM Inserted;
		UPDATE Contrata SET Tiempo = DATEDIFF(HH, @HDesdeNuevo, @HHastaNuevo)
		WHERE NroFestejo IN (SELECT NroFestejo FROM Inserted) AND Item IN (SELECT Item FROM Inserted)
	END
	ELSE IF(UPDATE(HDesde) OR UPDATE(HHasta))		-- Se trata de un UPDATE en alguna de estas columnas
	BEGIN
		UPDATE Contrata 
		SET HDesde = @HDesdeNuevo, HHasta = @HHastaNuevo, Tiempo = DATEDIFF(HH, @HDesdeNuevo, @HHastaNuevo)
		WHERE NroFestejo IN (SELECT NroFestejo FROM Inserted) AND Item IN (SELECT Item FROM Inserted)
	END
	ELSE											-- Se trata de alguna actualizacion en otro campo
	BEGIN
		DELETE FROM Contrata WHERE NroFestejo IN (SELECT NroFestejo FROM Deleted) AND Item IN (SELECT Item FROM Deleted)
		INSERT INTO Contrata SELECT * FROM Inserted
	END
END

INSERT INTO Contrata (NroFestejo, Item, NroServicio, HDesde, HHasta) VALUES (5,'Limpieza de oficinas',1,'07:50:00','8:45:00');
INSERT INTO Contrata (NroFestejo, Item, NroServicio, HDesde, HHasta) VALUES (4,'Picada',3,'19:00:00','23:30:00')
UPDATE Contrata SET HDesde = '09:00:00' WHERE NroFestejo = 1 AND Item = 'Centro de mesa'
UPDATE Contrata SET NroServicio = 1 WHERE NroFestejo = 6 AND Item = 'Mesa DJ'