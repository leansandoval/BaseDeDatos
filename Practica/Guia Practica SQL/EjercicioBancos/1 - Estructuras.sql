CREATE DATABASE EjercicioBancos;
GO
USE EjercicioBancos;
GO

CREATE TABLE Pais
(
	Pais CHAR(50) PRIMARY KEY
);

CREATE TABLE Banco
(
	Id INT PRIMARY KEY,
	Nombre VARCHAR(50),
	Pais CHAR(50)
);

CREATE TABLE Moneda
(
	Id CHAR(2) PRIMARY KEY,
	Descripcion VARCHAR(50),
	ValorOro DECIMAL(18,3),
	ValorPetroleo DECIMAL(18,3)
);

CREATE TABLE Persona
(
	Pasaporte CHAR(15) PRIMARY KEY,
	CodigoFiscal INT,
	Nombre VARCHAR(50)
);

CREATE TABLE Cuenta
(
	Monto DECIMAL(18,3),
	IdBanco INT NOT NULL,
	IdMoneda CHAR(2) NOT NULL,
	IdPersona CHAR(15) NOT NULL,
	CONSTRAINT PK_Persona PRIMARY KEY(IdBanco, IdMoneda, IdPersona)
);

CREATE TABLE Opera
(
	IdBanco INT NOT NULL,
	IdMoneda CHAR(2) NOT NULL,
	CambioCompra DECIMAL(18,3),
	CambioVenta DECIMAL(18,3),
	CONSTRAINT PK_Opera PRIMARY KEY(IdBanco, IdMoneda)
);