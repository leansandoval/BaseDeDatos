CREATE DATABASE Ejercicio_8;
GO
USE Ejercicio_8;

CREATE TABLE [dbo].[Frecuenta]
(
    [NombrePersona] [varchar](50) NOT NULL,
    [NombreBar] [varchar](50) NOT NULL,
);

CREATE TABLE [dbo].[Sirve]
(
    [NombreBar] [varchar](50) NOT NULL,
    [NombreCerveza] [varchar](50) NOT NULL,
    CONSTRAINT [PK_Sirve] PRIMARY KEY CLUSTERED ([NombreBar] ASC, [NombreCerveza] ASC)
);

CREATE TABLE [dbo].[Gusta]
(
    [NombreCerveza] [varchar](50) NOT NULL,
    [NombrePersona] [varchar](50) NOT NULL,
    CONSTRAINT [PK_Gusta] PRIMARY KEY CLUSTERED ([NombreCerveza] ASC,[NombrePersona] ASC)
);

