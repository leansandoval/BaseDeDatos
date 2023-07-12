USE Ejercicio_13
GO

INSERT INTO Nivel
    (Descripcion)
VALUES
    ('Maritimo'),
    ('Terrestre'),
    ('Aereo'),
    ('Espacial'),
    ('Volcanico');

INSERT INTO Medicion
    (Fecha, Hora, Metrica, Temperatura, Presion, Humedad, Nivel)
VALUES
    ('15-04-2021', '12:04:00', 'M1', 30, 4, 12, 5),
    ('22-12-2021', '21:59:04', 'M2', 1, 42, 23, 1),
    (GETDATE(), '04:20:00', 'M3', 66, 7, 55, 4),
    ('27-07-2021', '07:30:15', 'M4', 33, 1, 15, 2),
    ('22-12-2021', '06:30:00', 'M3', 25, 3, 25, 1),
    ('20-12-2021', '09:50:00', 'M3', -23, 4, 50, 2),
    ('21-12-2021', '15:55:30', 'M3', 5, 1, 40, 3),
    ('19-12-2021', '16:00:00', 'M3', 0, 17, 35, 5),
    ('18-12-2021', '20:30:59', 'M3', 22, 5, 10, 5);