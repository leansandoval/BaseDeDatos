CREATE DATABASE Ejercicio_13
GO
USE Ejercicio_13
GO

/*1. p_CrearEntidades(): Realizar un procedimiento que permita crear las tablas de nuestro modelo relacional.*/

CREATE OR ALTER PROCEDURE p_CrearEntidades
AS
BEGIN
    CREATE TABLE Nivel
    (
        Codigo INT IDENTITY(1, 1) PRIMARY KEY,
        Descripcion VARCHAR(15)
    )

    CREATE TABLE Medicion
    (
        Fecha DATE,
        Hora TIME,
        Metrica CHAR(2),
        Temperatura INT,
        Presion INT,
        Humedad INT,
        Nivel INT,
        CONSTRAINT FK_Medicion PRIMARY KEY (Fecha, Hora, Metrica)
    )
    ALTER TABLE Medicion ADD CONSTRAINT FK_Medicion_Nivel FOREIGN KEY (Nivel) REFERENCES Nivel (Codigo) ON DELETE CASCADE ON UPDATE CASCADE
END

EXECUTE p_CrearEntidades