USE GuiaResueltaEjercicio1
GO

INSERT INTO Escuela
    (Nombre, Direccion)
VALUES
    ('Escuela 1', 'Famosos'),
    ('Escuela 2', 'Oficialistas'),
    ('Escuela 3', 'Opositores'),
    ('Escuela 4', 'Hermanos');

INSERT INTO Alumno
    (DNI, Apellido, Nombre, CodigoEscuela)
VALUES
    (1, 'Fort', 'Ricardo', 1),
    (2, 'Marcelo', 'Tinelli', 1),
    (3, 'Moria', 'Casan', 1),
    (4, 'Cristina', 'Fernandez', 2),
    (5, 'Anibal', 'Fernandez', 2),
    (6, 'Amado', 'Boudou', 2),
    (7, 'Ricardo', 'Alfonsin', 3),
    (8, 'Elisa', 'Carrio', 3),
    (9, 'Hermes', 'Binner', 3),
    (10, 'Guido', 'Tinelli', 4),
    (11, 'Hugo', 'Tinelli', 4),
    (12, 'Alberto', 'Fernandez', 4),
    (13, 'Silvia', 'Fernandez', 4),
    (14, 'Ricardo', 'Tinelli', 4);

INSERT INTO HermanoDe
    (DniAlumno, DniHermano)
VALUES
    (2, 10),
    (2, 11),
    (2, 14),
    (5, 12),
    (4, 13),
    (10, 2),
    (10, 11),
    (10, 14),
    (11, 2),
    (11, 10),
    (11, 14),
    (14, 2),
    (14, 10),
    (14, 11);

INSERT INTO Alimento
    (Id, Descripcion, Marca)
VALUES
    ('Hamburguesa', 'Patty'),
    ('Milanesa', 'Granja del Sol'),
    ('Salchicha', 'Vienisima');

INSERT INTO AlmuerzaEn
    (DNIAlumno, IdAlimento, CodigoEscuela)
VALUES
    (4, 1, 1),
    (5, 1, 3),
    (4, 2, 4),
    (1, 3, 1),
    (1, 1, 4),
    (2, 1, 1),
    (3, 1, 1),
    (12, 2, 4),
    (13, 2, 4),
    (10, 1, 3),
    (7, 1, 3),
    (8, 2, 3),
    (9, 3, 3),
    (1, 2, 3),
    (3, 3, 3),
    (6, 3, 3),
    (12, 1, 3),
    (13, 1, 3),
    (4, 3, 3);