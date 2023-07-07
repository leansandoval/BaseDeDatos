CREATE DATABASE Ejercicio_14
GO
USE Ejercicio_14
GO

CREATE TABLE Servicio
(
	NroServicio INT PRIMARY KEY,
	Descripcion VARCHAR (30),
	Precio DECIMAL(18,3)
);

CREATE TABLE Cliente
(
	NroCliente INT PRIMARY KEY,
	RazonSocial VARCHAR(15)
)

CREATE TABLE Festejo
(
	NroFestejo INT PRIMARY KEY,
	Descripcion VARCHAR (30),
	Fecha DATE,
	NroCliente INT
)

ALTER TABLE Festejo ADD CONSTRAINT FK_Festejo_NroCliente FOREIGN KEY (NroCliente) REFERENCES Cliente (NroCliente) ON DELETE CASCADE ON UPDATE CASCADE

CREATE TABLE Contrata
(
	NroFestejo INT,
	Item VARCHAR (30),
	NroServicio INT,
	HDesde TIME,
	HHasta TIME,
	CONSTRAINT PK_Contrata PRIMARY KEY (NroFestejo, Item),
	CONSTRAINT FK_Contrata_NroServicio FOREIGN KEY (NroServicio) REFERENCES Servicio (NroServicio),
	CONSTRAINT FK_Contrata_NroFestejo FOREIGN KEY (NroFestejo) REFERENCES Festejo (NroFestejo)
)