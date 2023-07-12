CREATE DATABASE Ejercicio12
GO
USE Ejercicio12;
GO

CREATE TABLE Proveedor
(
    CodProv INT IDENTITY(1,1) PRIMARY KEY,
    RazonSocial VARCHAR(50),
    FechaInicio DATE,
)

CREATE TABLE Producto
(
    CodProd INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(100),
    CodProv INT NOT NULL,
    StockActual INT,
    -- CONSTRAINT FK_Producto_Prov FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv)
)

CREATE TABLE Stock
(
    Numero INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE,
    CodProd INT,
    Cantidad INT NOT NULL,
    CONSTRAINT PK_Stock PRIMARY KEY (Numero, Fecha, CodProd)
    -- CONSTRAINT FK_Stock_CodProd FOREIGN KEY (CodProd) REFERENCES Producto (CodProd),
)

ALTER TABLE Stock ADD CONSTRAINT FK_Stock_CodProd FOREIGN KEY (CodProd) REFERENCES Producto (CodProd) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Producto ADD CONSTRAINT FK_Producto_CodProv FOREIGN KEY (CodProv) REFERENCES Proveedor(CodProv) ON DELETE CASCADE ON UPDATE CASCADE;
