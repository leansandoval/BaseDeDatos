CREATE DATABASE GuiaResueltaEjercicio2
GO
USE GuiaResueltaEjercicio2
GO

CREATE TABLE GaleriaDeArte
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (50),
    Disponible VARCHAR (50),
    Calle VARCHAR (50),
    Numero VARCHAR (50),
    Localidad VARCHAR (50)
);

CREATE TABLE Autor
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NyA VARCHAR (50),
    FechaNacimiento DATE
);

CREATE TABLE TipoDeObra
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR (50)
);

CREATE TABLE Tematica
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR (50)
);

CREATE TABLE Obra
(
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR (50),
    Material VARCHAR (50),
    IdTipo INT,
    IdAutor INT,
    FOREIGN KEY	(IdTipo) REFERENCES TipoDeObra(Id),
    FOREIGN KEY	(IdAutor) REFERENCES Autor(Id)
);

CREATE TABLE Exposicion
(
    IdGaleria INT,
    IdObra INT,
    IdTematica INT,
    Fecha DATE,
    Sala INT,
    PRIMARY KEY	(IdGaleria, IdObra, IdTematica, Fecha),
    FOREIGN KEY	(IdGaleria) REFERENCES GaleriaDeArte (Id),
    FOREIGN KEY	(IdObra) REFERENCES TipoDeObra(Id),
    FOREIGN KEY	(IdTematica) REFERENCES Tematica(Id)
);