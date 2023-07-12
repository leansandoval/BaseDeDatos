USE Ejercicio_12
GO

INSERT INTO Proveedor
    (RazonSocial, FechaInicio)
VALUES
    ('Unlam', '1990-03-05'),
    ('Coto', '2005-07-01'),
    ('Carrefour', '2010-04-11');

INSERT INTO Producto
    (Descripcion, CodProv, StockActual)
VALUES
    ('Cafe de autor', 2, 100),
    ('Yogur griego', 2, 50),
    ('Cereales', 2, 400),
    ('Libro de Probabilidad y estadistica', 1, 130),
    ('Fundamentos de los Sistemas Circuitales', 1, 25),
    ('C/C++ de Deltei y Deltei', 1, 12),
    ('Arroz', 3, 200),
    ('Harina', 3, 800),
    ('Aceite', 3, 250),
    ('Teclado Gamer', 3, 0);

INSERT INTO Stock
    (Fecha, CodProd, Cantidad)
VALUES
    ('2020-12-30', 1, 37),
    ('2020-11-12', 2, 31),
    ('2021-01-15', 2, 15),
    ('2021-07-31', 10, 8),
    (GETDATE(), 3, 42),
    (GETDATE(), 2, 5),
    ('2021-07-31', 9, 1500),
    (GETDATE(), 1, 1340);