USE GuiaResueltaEjercicio2
GO

INSERT INTO GaleriaDeArte (Nombre, Disponible, Calle, Numero, Localidad) VALUES
('Galeria Barcelona', 'S', 'C/ de Bailen', '19','El Poblenou'),
('Galeria Buenos Aires', 'N', 'Av. del Libertador', '1473','CABA'),
('Galeria Florencia', 'N', 'Av. Corrientes', '565','CABA'),
('Galeria Recoleta', 'S', 'Junin', '1930','CABA'),
('Galeria Orfeo', 'S', 'Juncal', '848','CABA');

INSERT INTO Autor (NyA, FechaNacimiento) VALUES
('Dali', '1904-05-11'),
('Picasso', '1881-10-25'),
('Joan Miro', '1893-04-20'),
('Max Ernst', '1891-04-02'),
('Man Ray', '1890-08-27');

INSERT INTO TipoDeObra (Descripcion) VALUES
('Dadaismo'),
('Surrealismo'),
('Pop art'),
('Art Deco'),
('Minimalismo');

INSERT INTO Tematica (Descripcion) VALUES 
('Oregon'),
('Paisaje'),
('Emociones'),
('Figura humana'),
('Retrato');

INSERT INTO Obra (Nombre, Material, IdTipo, IdAutor) VALUES 
('Guernica','Oleo sobre lienzo',2,2),
('La persistencia de la memoria','Oleo sobre lienzo',5,1),
('La mujer que llora','Pintura al aceite',3,2),
('Gift','Painted flatiron',1,5),
('La masia','Oleo sobre lienzo',4,3);

INSERT INTO Exposicion (IdGaleria, IdObra, IdTematica, Fecha, Sala) VALUES 
(1,1,2,'15-04-2021',4),
(1,2,2,'22-07-2021',1),
(2,3,3,'30-10-2021',1),
(2,1,2,'30-10-2021',2),
(2,2,4,'30-10-2021',3),
(2,3,5,'30-10-2021',4),
(2,5,1,GETDATE(),9),
(2,4,1,GETDATE(),1),
(2,2,1,GETDATE(),1),
(5,4,1,'01-02-2021',2);