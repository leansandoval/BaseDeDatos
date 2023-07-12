USE Ejercicio_8
GO

INSERT INTO Frecuenta
    (nombrePersona,nombreBar)
VALUES
    ('Juan', 'Valinor'),
    ('Andrea', 'Valinor'),
    ('Mariano', 'Valinor'),
    ('Barbara', 'Duarte'),
    ('Barbara', 'Vita'),
    ('Barbara', 'Santa Birra'),
    ('Nicolas', 'Byra'),
    ('Nicolas', 'La Quintana'),
    ('Marcos', 'Jobs'),
    ('Marcos', 'La Birreria'),
    ('Francisco', 'La Birreria'),
    ('Francisco', 'Jobs'),
    ('Francisco', 'Vita'),
    ('Chloe', 'Vita'),
    ('Zoe', 'La Ferneteria');

INSERT INTO Gusta
    (nombrePersona,nombreCerveza)
VALUES
    ('Juan', 'Quilmes'),
    ('Juan', 'Brahma'),
    ('Andrea', 'Stella'),
    ('Andrea', 'Andes'),
    ('Andrea', 'Quilmes'),
    ('Mariano', 'Stella'),
    ('Mariano', 'Andes'),
    ('Barbara', 'Brahma'),
    ('Barbara', 'Stella'),
    ('Bianca', 'Corona'),
    ('Chloe', 'Brahma'),
    ('Chloe', 'Stella') ,
    ('Dominic', 'Corona'),
    ('Francisco', 'Sapporo'),
    ('Nicolas', 'Quilmes'),
    ('Nicolas', 'Stella'),
    ('Nicolas', 'Brahma'),
    ('Nicolas', 'Budweiser'),
    ('Marcos', 'Flensburger'),
    ('Marcos', 'Stella'),
    ('Zoe', 'Corona');

INSERT INTO Sirve
    (nombreBar,nombreCerveza)
VALUES
    ('Valinor', 'Stella'),
    ('Valinor', 'Quilmes'),
    ('Duarte', 'Brahma'),
    ('Duarte', 'Stella'),
    ('Santa Birra', 'Quilmes'),
    ('Byra', 'Quilmes'),
    ('Byra', 'Stella'),
    ('Byra', 'Brahma'),
    ('Byra', 'Andes'),
    ('La Quintana', 'Andes'),
    ('La Quintana', 'Budweiser'),
    ('Jobs', 'Budweiser'),
    ('Jobs', 'Flensburger'),
    ('Jobs', 'Stella'),
    ('La Birreria', 'Flensburger'),
    ('Vita', 'Stella'),
    ('Vita', 'Brahma'),
    ('Florida 165', 'Sapporo');

