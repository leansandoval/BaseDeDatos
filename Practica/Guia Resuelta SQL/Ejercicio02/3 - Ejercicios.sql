/*Ejercicio 2:

	GaleriaDeArte (Id, Nombre, Disponible, Calle, Nro, Localidad)
	Obra (Id, Nombre, Material, IdTipo, IdAutor)
	TipoDeObra (Id, Descripcion)
	Tematica (Id, Descripcion)
	Exposicion (IdGaleria, IdObra, IdTematica, Fecha, Sala)
	Autor (Id, NyA, FechaNacimiento)*/

USE GuiaResueltaEjercicio2
GO

/*a - Obtener el nombre de la galeria de arte, la descripcion de la tematica presentada y la fecha de 
realizacion, cuando la exposicion tuvo la mayor cantidad de obras en expuestas. Solo se mostraran los resultados
siempre y cuando la galeria de arte haya presentado todas las tematicas disponibles o haya expuesto distintas 
obras a tal punto de haber presentado todos los tipos de obra disponibles.*/

GO
CREATE OR ALTER VIEW v_Exposicion_Cantidad_Obras AS
(
	SELECT DISTINCT e.IdGaleria, e.IdTematica, e.Fecha, COUNT(e.IdObra) 'Cantidad Obras'
	FROM Exposicion AS e
	GROUP BY e.IdGaleria, e.IdTematica, e.Fecha
)
GO

-- Exposicion que tuvo la mayor cantidad de obras expuestas (Por galeria, tematica y fecha)

GO
CREATE OR ALTER VIEW v_Exposicion_ObrasMax AS
(
	SELECT eco.IdGaleria, eco.IdTematica, eco.Fecha
	FROM v_Exposicion_Cantidad_Obras AS eco
	WHERE eco.[Cantidad Obras] = (SELECT MAX(eco.[Cantidad Obras]) 
								  FROM v_Exposicion_Cantidad_Obras AS eco)
)
GO

-- Galerias de arte que presentaron todas las tematicas disponibles.

GO
CREATE OR ALTER VIEW v_Galeria_TodasTematicas AS
(
	SELECT e.IdGaleria, COUNT(DISTINCT e.IdTematica) AS 'Tematicas Presentadas'
	FROM Exposicion AS e
	GROUP BY e.IdGaleria
	HAVING COUNT(DISTINCT e.IdTematica) = (SELECT COUNT(*) 'Cantidad de tematicas'
										   FROM Tematica)
)
GO

-- Galerias de arte que expusieron obras, que tengan todos los tipos de obra disponibles.

GO
CREATE OR ALTER VIEW  v_Galeria_TodosTiposObra AS
(
	SELECT e.IdGaleria, COUNT(DISTINCT o.IdTipo) AS 'Cantidad Tipos Obra'
	FROM Exposicion AS e INNER JOIN Obra AS o ON e.IdObra = o.Id
	GROUP BY e.IdGaleria
	HAVING COUNT(DISTINCT o.IdTipo) = (SELECT COUNT(*) 'Cantidad Tipos de Obra'
									   FROM TipoDeObra)
)
GO

SELECT g.Nombre, t.Descripcion, eom.Fecha
FROM GaleriaDeArte AS g  INNER JOIN v_Exposicion_ObrasMax AS eom ON eom.IdGaleria = g.Id
						 INNER JOIN Tematica AS t ON eom.IdTematica = t.Id
WHERE eom.IdGaleria IN (SELECT gtt.IdGaleria 
						FROM v_Galeria_TodasTematicas AS gtt) 
   OR eom.IdGaleria IN (SELECT gtto.IdGaleria 
						FROM v_Galeria_TodosTiposObra AS gtto)

/*b - Se requiere crear un procedimiento almacenados o funcion para generar una nueva exposicion, por lo tanto 
se desea recibir por parametro, el id de la galeria de arte, id de la tematica, id de la obra a participar y 
la fecha. Si la exposicion no existe se debera asignar el numero de sala �1�, pero si la exposici�n ya existiera 
debera utilizarse el numero de sala previamente cargado para la misma.
Aclaracion: Debera validar que los id recibidos por parametros existan en las tablas correspondientes.*/

GO

CREATE OR ALTER PROCEDURE p_Nueva_Exposicion (@IdGaleria INT, @IdObra INT, @IdTematica INT, @Fecha DATE)
AS
BEGIN
	DECLARE @Sala AS INT;
	DECLARE @FlagGaleria AS INT = (SELECT 1 FROM GaleriaDeArte WHERE Id = @IdGaleria)
	DECLARE @FlagTematica AS INT = (SELECT 1 FROM Tematica WHERE Id = @IdTematica)
	DECLARE @FlagObra AS INT = (SELECT 1 FROM Obra WHERE Id = @IdObra)
	IF (@FlagGaleria = 1 AND @FlagTematica = 1 AND @FlagObra = 1) -- Ids validos
	BEGIN
		DECLARE @FlagExposicion AS INT = (SELECT 1 FROM Exposicion WHERE IdObra = @IdObra AND IdTematica = @IdTematica AND IdGaleria = @IdGaleria)
		IF (@FlagExposicion = 1)
			SET @Sala = (SELECT TOP 1 e.Sala FROM Exposicion AS e WHERE IdObra = @IdObra AND IdTematica = @IdTematica AND IdGaleria = @IdGaleria)
		ELSE
			SET @Sala = 1
		INSERT INTO Exposicion (IdGaleria, IdTematica, IdObra, Fecha, Sala) VALUES (@IdGaleria, @IdTematica, @IdObra, @Fecha, @Sala)
	END
	ELSE
		RAISERROR ('Los parametros ingresados no son validos',11,1)
END

EXECUTE p_Nueva_Exposicion 1,1,2,'25-04-2021'

