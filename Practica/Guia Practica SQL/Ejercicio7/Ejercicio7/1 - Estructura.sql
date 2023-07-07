USE MASTER

CREATE DATABASE Ejercicio_7
GO

USE Ejercicio_7
GO

/*
	Auto    (matrícula, modelo, año)
	Chofer  (nroLicencia, nombre, apellido, fecha_ingreso, teléfono)
	Viaje   (FechaHoraInicio, FechaHoraFin, chofer, cliente, auto, kmTotales, esperaTotal, costoEspera, costoKms)
	Cliente (nroCliente, calle, nro, localidad)
*/

CREATE TABLE Auto
(
	Matricula VARCHAR(10) CONSTRAINT PK_AutoMatricula PRIMARY KEY,
	Modelo VARCHAR(20) NOT NULL,
	Anio SMALLINT NOT NULL
);

CREATE TABLE Chofer
(
	NroLicencia INT IDENTITY(1,1) CONSTRAINT PK_Chofer PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	FechaIngreso DATETIME NOT NULL,
	Telefono VARCHAR(50) NULL
);

CREATE TABLE Cliente
(
	NroCliente INT IDENTITY(1,1) CONSTRAINT PK_Cliente PRIMARY KEY,
	Calle VARCHAR(50) NULL,
	Nro SMALLINT NULL,
	Localidad VARCHAR(50) NULL
);

CREATE TABLE Viaje
(
	FechaHoraInicio DATETIME NOT NULL,
	FechaHoraFin DATETIME  NOT NULL,
	Chofer INT NULL,
	Cliente INT NULL,
	Auto VARCHAR(10),
	KmTotales DECIMAL(18,2),
	EsperaTotal DECIMAL(18,2), 
	CostoEspera DECIMAL(18,2),
	CostoKms DECIMAL(18,2)
);
