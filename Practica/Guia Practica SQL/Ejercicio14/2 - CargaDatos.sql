USE Ejercicio_14
GO

INSERT INTO Servicio
    (NroServicio, Descripcion, Precio)
VALUES
    (1, 'Limpieza', 780.50),
    (2, 'Mantenimiento', 460.50),
    (3, 'Cocina', 885),
    (4, 'Traslado', 1234.56),
    (5, 'Remodelacion', 725.25);

INSERT INTO Cliente
    (NroCliente, RazonSocial)
VALUES
    (1, '223qw'),
    (2, '223qw'),
    (3, '243qw'),
    (4, '263qw'),
    (5, '283qw'),
    (6, '2893qw'),
    (7, '2673qw'),
    (8, '2793qw'),
    (9, '2676w'),
    (10, '28378');

INSERT INTO Festejo
    (NroFestejo, Descripcion, Fecha, NroCliente)
VALUES
    (1, '15 años', GETDATE(), 1),
    (2, 'Cumpleaños', '22-10-2021', 4),
    (3, 'Casamiento', '12-12-2021', 10),
    (4, '15 años', '08-10-2021', 5),
    (5, 'Bautismo', '15-05-2021', 2),
    (6, 'Casamiento', '30-01-2021', 5);

INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Limpieza de oficinas', 1, '07:50:00', '8:45:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Revision diaria de app', 2, '09:20:00', '10:20:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Torta', 3, '16:00:00', '21:00:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Picada', 3, '19:00:00', '23:30:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Mesas', 4, '08:20:15', '10:20:30');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (1, 'Centro de mesa', 5, '09:00:00', '11:00:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (2, 'Camion', 4, '10:30:00', '13:45:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (3, 'Sillas', 4, '13:00:00', '14:30:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (4, 'Proyector', 4, '16:00:00', '23:30:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (5, 'Regalos', 4, '13:50:00', '14:00:00');
INSERT INTO Contrata
    (NroFestejo, Item, NroServicio, HDesde, HHasta)
VALUES
    (6, 'Mesa DJ', 4, '00:30:00', '06:30:00');
