CREATE DATABASE Ejercicio_3;
GO
USE Ejercicio_3;
GO

CREATE TABLE Proveedor
(
	IdProveedor INT,
	Nombre VARCHAR(50),
	ResponsabilidadCivil VARCHAR(50),
	CUIT BIGINT,
	PRIMARY KEY(IdProveedor)
);

CREATE TABLE Producto
(
	IdProducto INT,
	Nombre VARCHAR(50),
	Descripcion VARCHAR(50),
	Estado VARCHAR(50),
	IdProveedor INT,
	PRIMARY KEY (IdProducto),
	FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor) 
);

CREATE TABLE Cliente
(
	IdCliente INT,
	Nombre VARCHAR(50),
	RespIVA VARCHAR(50),
	CUIT BIGINT,
	PRIMARY KEY (IdCliente)
);

CREATE TABLE Direccion
(
	IdDir INT,
	IdPers INT,
	Calle VARCHAR(100),
	Nro INT,
	Piso INT,
	Dpto CHAR,
	PRIMARY KEY(IdDir),
	FOREIGN KEY(IdPers) REFERENCES Cliente(IdCliente)
);

CREATE TABLE Vendedor
(
	IdVendedor INT,
	Nombre VARCHAR(50),
	Apellido VARCHAR(50),
	DNI BIGINT,
	PRIMARY KEY (IdVendedor)
);

CREATE TABLE Venta
(
	NroFactura BIGINT,
	IdCliente INT,
	IdVendedor INT,
	Fecha DATE,
	PRIMARY KEY (NroFactura),
	FOREIGN KEY (IdCliente) REFERENCES Cliente (IdCliente),
	FOREIGN KEY (IdVendedor) REFERENCES Vendedor (IdVendedor)
);

CREATE TABLE DetalleVenta
(
	NroFactura BIGINT,
	NroDetalle BIGINT,
	IdProducto INT,
	Cantidad INT,
	PrecioUnitario INT,
	PRIMARY KEY (NroFactura, NroDetalle),
	FOREIGN KEY (NroFactura) REFERENCES Venta (NroFactura) ON DELETE CASCADE,
	FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto)
);

/*ALTER TABLE Producto ADD CONSTRAINT FK_Producto_IdProveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor (IdProveedor) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Direccion ADD CONSTRAINT FK_Direccion_IdPersona FOREIGN KEY (IdPersona) REFERENCES Cliente (IdCliente) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT FK_Venta_IdCliente FOREIGN KEY (IdCliente) REFERENCES Cliente (IdCliente) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Venta ADD CONSTRAINT FK_Venta_IdVendedor FOREIGN KEY (IdVendedor) REFERENCES Vendedor (IdVendedor) ON DELETE CASCADE ON UPDATE CASCADE;
--ALTER TABLE DetalleVenta ADD CONSTRAINT FK_DetalleVenta_NroFactura FOREIGN KEY (NroFactura) REFERENCES Venta (NroFactura) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE DetalleVenta ADD CONSTRAINT FK_DetalleVenta_IdProducto FOREIGN KEY (IdProducto) REFERENCES Producto (IdProducto) ON DELETE CASCADE ON UPDATE CASCADE;*/
