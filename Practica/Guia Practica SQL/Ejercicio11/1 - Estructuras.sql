CREATE DATABASE Ejercicio_11
GO
USE Ejercicio_11;

CREATE TABLE Genero 
(
	ID INT NOT NULL PRIMARY KEY ,
	Nombre VARCHAR(20)
);

CREATE TABLE Director
(
	ID INT NOT NULL PRIMARY KEY ,
	NyA VARCHAR(50)
);

CREATE TABLE Cliente 
(
	CodCli INT NOT NULL PRIMARY KEY ,
	NyA VARCHAR(50),
	Direccion VARCHAR(30),
	Telefono VARCHAR(15),
	Email VARCHAR(30),
	Borrado TINYINT DEFAULT 2
);

drop table Pelicula
drop table Alquiler
drop table Ejemplar
drop table Cliente

CREATE TABLE Pelicula 
(
	CodPel INT NOT NULL PRIMARY KEY ,
	Titulo VARCHAR(50),
	Duracion VARCHAR(10),
	CodGenero INT,
	IDDirector INT,
	--CONSTRAINT FK_Pelicula_CodGenero FOREIGN KEY (CodGenero) REFERENCES Genero(ID),
	--CONSTRAINT FK_Pelicula_IDDirector FOREIGN KEY (IDDirector) REFERENCES Director(ID)
);

CREATE TABLE Ejemplar 
(
	Numero INT,
	CodPel INT,
	Estado BIT,
	CONSTRAINT PK_Ejemplar PRIMARY KEY (Numero, CodPel),
	--CONSTRAINT FK_Ejemplar_CodPel FOREIGN KEY (CodPel) REFERENCES Pelicula(CodPel)
);

CREATE TABLE Alquiler
(
	Id INT NOT NULL PRIMARY KEY,
	NroEjemplar INT ,
	CodPel INT,
	CodCli INT,
	FechaAlquiler DATE,
	FechaDevolucion DATE,
	--CONSTRAINT FK_Alquiler_NroEjemplar_CodPel FOREIGN KEY (NroEjemplar, CodPel) REFERENCES Ejemplar(Numero, CodPel),
	--CONSTRAINT FK_Alquiler_CodCli FOREIGN KEY (CodCli) REFERENCES Cliente(CodCli)
);
