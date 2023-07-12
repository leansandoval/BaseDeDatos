/* Ejercicio 11: Dado el siguiente esquema de relacion del Video Club �Orion�:
	Pelicula (CodPel, Titulo, Duracion, CodGenero, IdDirector)
	Genero (Id, NombGenero)
	Director (Id, NyA)
	Ejemplar (NroEj, CodPel, Estado)						{Estado: 1 Disponible, 0 No disponible}
	Cliente (CodCli, NyA, Direccion, Tel, Email, Borrado)	{Borrado: 1 Si, 2 No(Default) }
	Alquiler (Id, NroEj, CodPel, CodCli, FechaAlq, FechaDev)*/

-- 1. Realice las sentencias DDL necesarias para crear en SQL una base de datos correspondiente 
-- al modelo relacional del enunciado.

-- 2. Realice los INSERTs necesarios para cargar en las tablas creadas en el punto anterior los datos de 
-- 5 clientes, 10 peliculas (y tablas relacionadas a estas) y al menos 15 alquileres.

-- 3. Agregue el atributo [Anio] en la tabla PelIcula.

ALTER TABLE Pelicula ADD Anio VARCHAR(4)

ALTER TABLE Pelicula DROP COLUMN Anio

-- 4. Actualice la tabla pelicula para que incluya el anio de lanzamiento de las pelIculas en stock.

UPDATE Pelicula SET Anio = '1984' WHERE CodPel = 1;
UPDATE Pelicula SET Anio = '2009' WHERE CodPel = 2;
UPDATE Pelicula SET Anio = '2003' WHERE CodPel = 3;
UPDATE Pelicula SET Anio = '1999' WHERE CodPel = 4;
UPDATE Pelicula SET Anio = '1985' WHERE CodPel = 5;
UPDATE Pelicula SET Anio = '2006' WHERE CodPel = 6;
UPDATE Pelicula SET Anio = '2019' WHERE CodPel = 7;
UPDATE Pelicula SET Anio = '2021' WHERE CodPel = 8;
UPDATE Pelicula SET Anio = '1994' WHERE CodPel = 9;
UPDATE Pelicula SET Anio = '2014' WHERE CodPel = 10;

-- 5. Queremos que al momento de eliminar una pelicula se eliminen todos los ejemplares de la misma. 
-- Realice una CONSTRAINT para esta tarea.

ALTER TABLE Ejemplar ADD CONSTRAINT FK_Ejemplar_CodPel FOREIGN KEY (CodPel) REFERENCES Pelicula (CodPel) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Alquiler ADD CONSTRAINT FK_Alquiler_NroEjemplar_CodPel FOREIGN KEY (NroEjemplar, CodPel) REFERENCES Ejemplar (Numero, CodPel) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Alquiler ADD CONSTRAINT FK_Alquiler_CodCli FOREIGN KEY (CodCli) REFERENCES Cliente (CodCli) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Pelicula ADD CONSTRAINT FK_Pelicula_CodGenero FOREIGN KEY (CodGenero) REFERENCES Genero(ID) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Pelicula ADD CONSTRAINT FK_Director_IDDirector FOREIGN KEY (IDDirector) REFERENCES Director(ID) ON DELETE CASCADE ON UPDATE CASCADE;

-- Para borrarlas: 
ALTER TABLE Ejemplar DROP CONSTRAINT FK_Ejemplar_CodPel;
ALTER TABLE Alquiler DROP CONSTRAINT FK_Alquiler_NroEjemplar;
ALTER TABLE Alquiler DROP CONSTRAINT FK_Alquiler_CodCli;
ALTER TABLE Pelicula DROP CONSTRAINT FK_Pelicula_CodGenero;
ALTER TABLE Pelicula DROP CONSTRAINT FK_Director_IDDirector;

-- 6. Queremos que exista un borrado de logico y no fisico de clientes, realice un TRIGGER que usando 
-- el atributo [Borrado] haga esta tarea.

GO

CREATE OR ALTER TRIGGER tgEliminarCliente ON Cliente INSTEAD OF DELETE AS
BEGIN
	UPDATE Cliente SET Borrado = 1 WHERE CodCli IN (SELECT CodCli FROM Deleted)
END

-- ENABLE TRIGGER tgEliminarCliente ON Cliente
-- DISABLE TRIGGER tgEliminarCliente ON Cliente
-- DROP TRIGGER IF EXISTS tgEliminarCliente

UPDATE Cliente SET Borrado = 2 WHERE Borrado = 1

-- 7. Elimine las peliculas de las que no se hayan alquilado ninguna copia.

DELETE FROM Pelicula
WHERE CodPel IN (SELECT p.CodPel
				 FROM Pelicula AS p
				 EXCEPT
				 SELECT a.CodPel
				 FROM Alquiler AS a)

-- 8. Elimine los clientes sin alquileres.

DELETE FROM Cliente
WHERE CodCli IN (SELECT c.CodCli
				 FROM Cliente AS c
				 EXCEPT
				 SELECT a.CodCli
				 FROM Alquiler AS a)