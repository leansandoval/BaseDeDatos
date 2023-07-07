USE Ejercicio_11
GO

INSERT INTO Genero (Id, Nombre) VALUES 
(1,'Terror'),
(2,'Comedia'),
(3,'Drama'),
(4,'Accion'),
(5,'Infantil'),
(6,'Ciencia Ficción');

INSERT INTO Director (ID, NyA) VALUES 
(1,'David Lynch'),
(2,'Martin Scorsese'),
(3,'Pedro Almodovar'),
(4,'Quentin Tarantino'),
(5,'Larry and Andy Wachowski'),
(6,'Clint Eastwood'),
(7,'James Cameron'),
(8,'Steven Spielberg'),
(9,'Joe Ruso'),
(10,'Michael Chaves');

INSERT INTO Cliente (CodCli, NyA, Direccion, Telefono, Email) VALUES 
(1,'Cosme, Fulanito', 'CalleFalsa 123', '3344-5325', 'cosme@email.com'),
(2,'Perez, Jorge', 'Cerrito 223', '9834-3385', 'perez@email.com'),
(3,'Suarez, Pepe', 'Uruguay 2322', '4594-9482', 'suarez@email.com'),
(4,'Fernandez, Juancito', 'Pueyrredon 2343', '7833-5893', 'fernandez@email.com'),
(5,'Torres, Pepe', 'Rivadavia 7897', '7484-3298', 'torres@email.com');


INSERT INTO Pelicula (CodPel, Titulo, Duracion, CodGenero, IDDirector) VALUES 
(1,'Terminator', '1:30:00', 4, 1),
(2,'Avatar', '2:30:00', 4, 7),
(3,'Kill Bill', '1:45:00', 4, 4),
(4,'Matrix', '1:30:00', 4, 5),
(5,'Volver al Futuro', '1:20:00', 5, 8),
(6,'300', '1:40:00', 4, 3),
(7,'Avengers: Endgame', '3:02:00', 6, 9),
(8,'El Conjuro 3', '1:52:00', 1, 9),
(9,'Tiempos Violentos', '2:58:00', 2, 4),
(10,'Francotirador', '2:14:00', 4, 6);

INSERT INTO Ejemplar (Numero, CodPel, Estado) VALUES 
(1,1,1),
(2,1,0),
(1,2,1),
(2,2,0),
(1,3,1),
(2,3,0),
(1,4,1),
(2,4,0),
(1,5,1),
(2,5,0),
(1,6,1),
(2,6,0),
(3,2,0),
(4,2,0),
(5,2,0),
(6,2,0),
(1,7,1),
(6,10,0);

INSERT INTO Alquiler (Id, NroEjemplar, CodPel, CodCli, FechaAlquiler, FechaDevolucion) VALUES 
(1,1,1,4,'2011-06-11',NULL),
(2,1,2,2,'2011-06-15',NULL),
(3,1,3,3,'2011-06-22',NULL),
(4,1,4,5,'2011-06-30',NULL),
(5,1,5,4,'2011-07-01',NULL),
(6,1,6,1,'2011-07-06',NULL),
(7,1,2,4,'2011-05-11','2011-05-13'),
(8,2,2,2,'2011-05-15','2011-05-17'),
(9,3,2,3,'2011-06-12','2011-06-14'),
(10,4,2,5,'2011-06-23','2011-06-25'),
(11,5,2,4,'2011-06-06','2011-06-08'),
(12,6,2,1,'2011-06-22','2011-06-24'),
(13,2,3,1,'2011-07-22','2011-07-24'),
(14,6,2,3,'2011-07-10',NULL),
(15,2,4,5,'2011-05-04','2011-05-06'),
(16,6,10,5,'2011-03-12','2011-03-14');
