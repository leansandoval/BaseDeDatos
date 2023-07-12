USE Ejercicio_10
GO

INSERT INTO Ambiente
    (Descripcion)
VALUES
    ('Desarrollo'),
    ('Inmuebles'),
    ('Tecnologia'),
    ('Automoviles'),
    ('Decoracion'),
    ('Moda'),
    ('Viajes'),
    ('Gastronomia'),
    ('Universitario'),
    ('Cultural');

INSERT INTO Metodo
    (Clase, Metodo)
VALUES
    ('Clase 1', 'Metodo 1'),
    ('Clase 2', 'Metodo 2'),
    ('Clase 3', 'Metodo 3'),
    ('Clase 4', 'Metodo 4'),
    ('Clase 5', 'Metodo 5'),
    ('Clase 6', 'Metodo 6'),
    ('Clase 7', 'Metodo 7'),
    ('Clase 8', 'Metodo 8'),
    ('Clase 9', 'Metodo 9'),
    ('Clase 10', 'Metodo 10');

INSERT INTO Page
    (Ip, WebPage, IdAmbiente)
VALUES
    ('10.0.0.1', 'www.ingenieriaUNLaM.com.ar', 1),
    ('10.0.0.2', 'www.sodimac.com', 2),
    ('10.0.0.3', 'FTP Serv-U', 3),
    ('10.0.0.4', 'www.peugeot.com.ar', 4),
    ('10.0.0.5', 'www.easy.com', 5),
    ('10.0.0.6', 'la.louisvuitton.com', 6),
    ('10.0.0.7', 'www.despegar.com.ar', 7),
    ('10.0.0.8', 'www.cocinaFacil.es', 8),
    ('10.0.0.9', 'www.utn.com.ar', 9),
    ('10.0.0.10', 'www.louvre.fr', 10);

INSERT INTO Request
    (Ip, Fecha, Hora, IdMetodo)
VALUES
    ('10.0.0.1', GETDATE(), '12:45:00', 1),
    ('10.0.0.2', '2021-03-03', '13:17:21', 2),
    ('10.0.0.3', '2021-05-30', '09:26:15', 3),
    ('10.0.0.4', '2021-04-08', '11:06:54', 4),
    ('10.0.0.5', GETDATE()-14, '05:14:23', 5),
    ('10.0.0.6', GETDATE()-7, '23:02:11', 6),
    ('10.0.0.7', GETDATE(), '22:50:11', 7),
    ('10.0.0.8', '2021-01-29', '18:45:52', 8),
    ('10.0.0.9', '2021-07-22', '15:36:12', 9),
    ('10.0.0.10', GETDATE()-2, '20:02:31', 10);