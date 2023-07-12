USE Ejercicio_9
GO

INSERT INTO Persona
    (TipoDoc, NroDoc, Nombre, Direccion, FechaNac, Sexo)
VALUES
    ('DNI', 12345671, 'Maria Perez', 'Cobo', '1980-03-02', 'Femenino'),
    ('DNI', 12345673, 'Gustavo Basualdo', 'Da Vinci', '1989-03-10', 'Masculino'),
    ('DNI', 12345675, 'Juan Perez', 'Rocamora', '1988-10-13', 'Masculino'),
    ('DNI', 12345677, 'Monica Diaz', 'Condor', '1979-07-04', 'Femenino'),
    ('DNI', 12345678, 'Manuel Diaz', 'Av. Rivadavia', '1983-10-05', 'Masculino'),
    ('DNI', 12345679, 'Gaston Perez', 'Av. Corrientes', '1980-03-12', 'Masculino'),
    ('LC', 12345670, 'Jose Perez' , 'Reales', '1970-03-02', 'Masculino'),
    ('LC', 12345672, 'Leandro Gonzalez', 'Espiro', '1979-06-02', 'Masculino'),
    ('LC', 12345674, 'Maria Gonzalez', 'Luis Viale', '1970-03-02', 'Femenino'),
    ('LC', 12345676, 'Martina Diaz', 'Juan Manuel de Rosas', '1975-12-23', 'Femenino');

INSERT INTO Progenitor
    (TipoDoc, NroDoc, TipoDocHijo, NroDocHijo)
VALUES
    ('LC', 12345670, 'DNI', 12345671),
    ('LC', 12345672, 'DNI', 12345679),
    ('LC', 12345670, 'DNI', 12345679),
    ('LC', 12345676, 'DNI', 12345678),
    ('LC', 12345676, 'DNI', 12345677),
    ('LC', 12345674, 'DNI', 12345675),
    ('LC', 12345674, 'DNI', 12345677),
    ('LC', 12345674, 'DNI', 12345678),
    ('LC', 12345670, 'DNI', 12345675),
    ('LC', 12345672, 'DNI', 12345678),
    ('DNI', 12345679, 'LC', 12345674);