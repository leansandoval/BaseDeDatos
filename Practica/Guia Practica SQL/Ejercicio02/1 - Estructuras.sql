/*
USE MASTER
DROP DATABASE Ejercicio_2
*/

USE MASTER

CREATE DATABASE Ejercicio_2
GO

USE Ejercicio_2
GO

/*
	Proveedor (NroProv, NomProv, Categoria, CiudadProv)
	Articulo  (NroArt, Descripcion, CiudadArt, Precio)
	Cliente   (NroCli, NomCli, CiudadCli)
	Pedido    (NroPed, NroArt, NroCli, NroProv, FechaPedido, Cantidad, PrecioTotal)
	Stock     (NroArt, fecha, cantidad)
*/

CREATE TABLE Proveedor
(
	NroProv INT IDENTITY(1,1) PRIMARY KEY,
	NomProv VARCHAR(20) NOT NULL,
	Categoria VARCHAR(20),
	CiudadProv VARCHAR(20)
)

CREATE TABLE Articulo
(
	NroArt INT IDENTITY(1,1) NOT NULL,
	Descripcion VARCHAR(20),
	CiudadArt  VARCHAR(20),
	Precio DECIMAL(10,4),
	PRIMARY KEY  (NroArt)
)

CREATE TABLE Cliente
(
	NroCli INT IDENTITY(1,1) NOT NULL,
	NomCli  VARCHAR(20), 
	CiudadCli VARCHAR(20),
	CONSTRAINT PK_Cliente PRIMARY KEY (NroCli)
)

CREATE TABLE Pedido
(
	NroPed INT IDENTITY(1,1) NOT NULL, 
	NroArt INT NOT NULL, 
	NroCli INT NOT NULL, 
	NroProv INT NOT NULL, 
	FechaPedido DATETIME, 
	Cantidad INT, 
	PrecioTotal DECIMAL(10,4),
	PRIMARY KEY (NroPed)
)

ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_NroArt FOREIGN KEY (NroArt) REFERENCES Articulo(NroArt) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_NroCli FOREIGN KEY (NroCli) REFERENCES Cliente(NroCli) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Pedido ADD CONSTRAINT FK_Pedido_NroProv FOREIGN KEY (NroProv) REFERENCES Proveedor(NroProv) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE Stock     
(
	NroArt  INT NOT NULL,
	Fecha DATETIME NOT NULL, 
	Cantidad INT 
)

ALTER TABLE Stock ADD CONSTRAINT PK_Stock PRIMARY KEY (NroArt, Fecha);
ALTER TABLE Stock ADD CONSTRAINT FK_Stock_NroArt FOREIGN KEY (NroArt) REFERENCES Articulo(NroArt) ON DELETE CASCADE ON UPDATE CASCADE;

/* ALTER TABLE Stock DROP CONSTRAINT FK_Stock_NroArt;
ALTER TABLE Pedido DROP CONSTRAINT FK_Pedido_NroArt;
ALTER TABLE Pedido DROP CONSTRAINT FK_Pedido_NroCli;
ALTER TABLE Pedido DROP CONSTRAINT FK_Pedido_NroProv;*/