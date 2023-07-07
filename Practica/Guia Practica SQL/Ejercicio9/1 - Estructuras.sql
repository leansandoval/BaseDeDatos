CREATE DATABASE Ejercicio_9
GO
USE Ejercicio_9;

CREATE TABLE Persona
(
	TipoDoc VARCHAR(3),
	NroDoc INT,
	Nombre VARCHAR(30),
	Direccion VARCHAR(30),
	FechaNac DATE,
	Sexo VARCHAR(9),
	PRIMARY KEY (TipoDoc, NroDoc)
);

CREATE TABLE Progenitor
(
	TipoDoc VARCHAR(3),
	NroDoc INT,
	TipoDocHijo VARCHAR(3),
	NroDocHijo INT,
	PRIMARY KEY (TipoDoc, NroDoc, TipoDocHijo, NroDocHijo),
	FOREIGN KEY (TipoDoc, NroDoc) REFERENCES Persona (TipoDoc, NroDoc),
	FOREIGN KEY (TipoDocHijo, NroDocHijo) REFERENCES Persona (TipoDoc, NroDoc)
);