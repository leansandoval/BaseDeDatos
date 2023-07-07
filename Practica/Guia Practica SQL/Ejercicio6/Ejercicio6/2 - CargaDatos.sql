USE Ejercicio_6
GO

INSERT INTO Vuelo (NroVuelo, Desde, Hasta, Fecha) VALUES
(1,'Buenos Aires','Chubut','25-12-2021'),
(2,'Rio de Janeiro','Aereoparque','11-07-2021'),
(3,'Santiago del Estero','Tierra del Fuego','12-10-2021'),
(4,'La Pampa','Rio Negro','09-09-2021'),
(5,'Buenos Aires','Mendoza','01-02-2020'),
(6,'Santiago de Chile','Buenos Aires','04-05-2021'),
(7,'Los Angeles','Buenos Aires','20-12-2020'),
(7,'Santiago de Chile','Buenos Aires',GETDATE()),
(7,'Rio de Janeiro','Aereoparque',GETDATE()),
(7,'La Pampa','Rio Negro',GETDATE()),
(9,'Tucuman','Cordoba',GETDATE()),
(9,'Santiago del Estero','Tierra del Fuego',GETDATE());

INSERT INTO AvionUtilizado (NroAvion, TipoAvion, NroVuelo) VALUES
(1,'B-777',1),
(2,'A-666',3),
(3,'C-555',7),
(4,'D-123',6),
(5,'B-777',2),
(6,'B-777',1);

INSERT INTO InfoPasajeros (NroVuelo, Documento, Nombre, Origen, Destino) VALUES
(1,41548235,'Martina Gomez','A','F'),
(2,41000111,'Juan Perez','B','F'),
(3,42333444,'Gonzalo Quiroga','A','B'),
(4,42333444,'Gonzalo Quiroga','B','D'),
(5,40345678,'Pedro Perez','A','C'),
(6,39876543,'Martin Salazar','C','H'),
(7,41548235,'Martina Gomez','A','B'),
(7,41000111,'Juan Perez','B','H'),
(9,41548235,'Pedro Perez','C','F');