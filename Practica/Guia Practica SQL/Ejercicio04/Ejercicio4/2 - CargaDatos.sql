USE Ejercicio_4;
GO

INSERT INTO Persona (DNI, Nombre, Telefono) VALUES
(145654354, 'Camila Alvarez', '23156456'),
(165434562, 'Cinthia Molina', '23156456'),
(165453456, 'Pedro Gomez', '23156456'),
(165455654, 'Sofia Ansaldi', '23156456'),
(165456566, 'Romina Sanchez', '23156456'),
(165765643, 'Gaston Rodriguez', '23156456'),
(165876434, 'Nicolas Perez', '23156456'),
(484453456, 'Ezequiel Gonzalez', '468731321'),
(658456566, 'Emanuel Salina', '23156456'),
(951456566, 'Juan Perez', '222222111');

INSERT INTO Empresa (Nombre, Telefono) VALUES
('Banelco', '222222111'),
('Clarín', '23156456'),
('Coppel', '23156456'),
('Huawei', '468731321'),
('La Serenisima', '23156456'),
('Musimundo', '23156456'),
('Paulinas', '23156456'),
('Telecom', '23156456'),
('Samsung', '23156456'),
('Sony', '23156456');

INSERT INTO Vive (DNI, Calle, Ciudad) VALUES
(145654354, 'Encina', 'Gonzalez Catan'),
(165434562, 'Florencio Varela', 'San Justo'),
(165453456, 'Florencio Varela', 'San Justo'),
(165455654, 'Luis Viale', 'Moron'),
(165456566, 'Peru', 'San Justo'),
(165765643, 'Av Rivadavia', 'Ramos Mejia'),
(165876434, 'Av de Mayo', 'Ramos Mejia'),
(484453456, 'Simon Perez', 'Gonzalez Catan'),
(658456566, 'Av Luro', 'Laferrere'),
(951456566, 'Simon Perez', 'Gonzalez Catan');

INSERT INTO Trabaja (DNI, NombreEmpresa, Salario, FechaIngreso, FechaEgreso) VALUES
(145654354, 'Clarín', 35750, '2000-01-01', '2004-05-31'),
(165434562, 'Banelco', 150000, '2009-11-25', '2011-05-07'),
(165434562, 'Paulinas', 70000, '2011-11-13', '2011-12-06'),
(165453456, 'Sony', 65200, '2011-11-14', '2016-11-08'),
(165455654, 'Sony', 95000, '2011-11-15', '2014-11-20'),
(165456566, 'Clarín', 85250.25, '2011-11-17', '2011-11-29'),
(165765643, 'Telecom', 42333.33, '2000-01-01', '2004-03-31'),
(165876434, 'Clarín', 60000, '2011-11-14', '2013-11-15'),
(484453456,'Banelco', 55555.99, '2011-11-28', '2013-11-13'),
(658456566, 'Sony', 55375, '2011-11-06', '2011-11-24'),
(951456566, 'Banelco', 45000.50, '2000-01-01', '2004-03-25'),
(951456566, 'Clarín', 35000, '2002-10-12', '2004-03-25'),
(951456566, 'Paulinas', 55000, '2003-12-04', '2004-03-25'),
(951456566, 'Sony', 60000.50, '2001-05-15', '2004-03-25'),
(951456566, 'Telecom', 500, '2004-03-25', '2004-03-25');

INSERT INTO SituadaEn (NombreEmpresa, Ciudad) VALUES
('Banelco', 'San Justo'),
('Clarín', 'La Boca'),
('Coppel', 'Moron'),
('Huawei', 'CABA'),
('Musimundo', 'Gonzalez Catan'),
('La Serenisima', 'Cañuelas'),
('Paulinas', 'Junin'),
('Samsung', 'CABA'),
('Sony', 'CABA'),
('Telecom', 'Caballito');

INSERT INTO Supervisa (DNIPer, DNISup) VALUES
(145654354, 165876434),
(165434562, 145654354),
(165453456, 951456566),
(165455654, 165453456),
(165456566, 658456566),
(165765643, 484453456),
(165876434, 484453456),
(484453456, 658456566),
(658456566, 165453456),
(951456566, 145654354),
(951456566, 165434562),
(951456566, 165453456),
(951456566, 165456566),
(951456566, 658456566),
(951456566, 484453456);