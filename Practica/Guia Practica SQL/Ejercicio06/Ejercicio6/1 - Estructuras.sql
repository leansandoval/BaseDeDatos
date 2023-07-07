CREATE DATABASE Ejercicio_6
GO

USE Ejercicio_6
GO

CREATE TABLE Vuelo
(
	NroVuelo INT,
	Desde VARCHAR (30),
	Hasta VARCHAR (30),
	Fecha DATE,
	CONSTRAINT PK_Vuelo PRIMARY KEY (NroVuelo, Desde)
)

CREATE TABLE AvionUtilizado
(
	NroAvion INT PRIMARY KEY,
	TipoAvion VARCHAR (20),
	NroVuelo INT,
)

CREATE TABLE InfoPasajeros
(
	NroVuelo INT,
	Documento INT,
	Nombre VARCHAR (30),
	Origen CHAR (1),
	Destino CHAR (1),
	CONSTRAINT PK_InfoPasajeros PRIMARY KEY (NroVuelo, Documento)
)

--ALTER TABLE AvionUtilizado ADD CONSTRAINT FK_AvionUtilizado_NroVuelo FOREIGN KEY (NroVuelo) REFERENCES Vuelo (NroVuelo) ON DELETE CASCADE ON UPDATE CASCADE;
--ALTER TABLE InfoPasajeros ADD CONSTRAINT FK_InfoPasajeros_NroVuelo FOREIGN KEY (NroVuelo) REFERENCES Vuelo (NroVuelo) ON DELETE CASCADE ON UPDATE CASCADE;
