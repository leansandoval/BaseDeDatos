--Para adaptar a los ejercicios
USE [Ejercicio_2]
GO

--1
UPDATE [dbo].[Articulo] SET [Descripcion] = 'Art146' WHERE [NroArt] = 1

--2
UPDATE [dbo].[Proveedor] SET [NomProv] = 'Prov015' WHERE [NroProv] = 1

--3
UPDATE [dbo].[Proveedor] SET [Categoria] = NULL

ALTER TABLE [dbo].[Proveedor]
	ALTER COLUMN [Categoria] INT

DECLARE @counter SMALLINT;  
 
SET @counter = 1;  
WHILE @counter < 7 
   BEGIN  
		UPDATE [dbo].[Proveedor] SET [Categoria] = @counter WHERE [NroProv] = @counter
		SET @counter = @counter + 1
   END;  
GO  

--4
UPDATE [dbo].[Articulo] SET [CiudadArt]='Mendoza' WHERE [NroArt] = 1
UPDATE [dbo].[Cliente] SET [CiudadCli]='Rosario' WHERE [NroCli] = 1

--5
UPDATE [dbo].[Cliente] SET [NomCli] = 'Cli23' WHERE [NroCli] = 1
UPDATE [dbo].[Cliente] SET [NomCli] = 'Cli30' WHERE [NroCli] = 2

--6
UPDATE [dbo].[Articulo] SET [CiudadArt] = 'La Plata' WHERE  [NroArt] IN(5,6)

--7
UPDATE [dbo].[Cliente] SET [CiudadCli] = 'Junín' WHERE [NroCli] = 3
UPDATE [dbo].[Cliente] SET [CiudadCli] = 'Junín' WHERE [NroCli] = 4

-- 8.1
UPDATE [dbo].[Articulo] SET [Descripcion] = 'Cuaderno' WHERE [NroArt] = 2

-- 8.2 Actualizo una categroria
UPDATE Proveedor
SET Categoria = 5
WHERE NroProv = 5

--9
UPDATE [dbo].[Articulo] SET [Descripcion] = 'Art1' WHERE [NroArt] = 5
UPDATE [dbo].[Articulo] SET [Descripcion] = 'Art4' WHERE [NroArt] = 6
UPDATE [dbo].[Articulo] SET [Descripcion] = 'Art100' WHERE [NroArt] = 7

INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (7,1,4,GETDATE(),900,9000)

--SELECT *
--FROM [dbo].[Articulo]
--WHERE [Descripcion] BETWEEN 'A001' AND 'A100'

--10
UPDATE [dbo].[Pedido] SET [FechaPedido] = '2004-01-01' WHERE [NroPed] = 5
UPDATE [dbo].[Pedido] SET [FechaPedido] = '2004-02-01' WHERE [NroPed] = 6
UPDATE [dbo].[Pedido] SET [FechaPedido] = '20040331' WHERE [NroPed] = 7		-- CAMBIADO

--11 
INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (1,3,1,'2004-02-06',500,8700)

--14
INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (1,1,1,'2019-04-04',5,209000)
INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (1,1,1,'2019-05-04',5,209000)
INSERT INTO [dbo].[Pedido] ( [NroArt], [NroCli], [NroProv], [FechaPedido], [Cantidad], [PrecioTotal]) VALUES (1,1,1,'20190514',5,209000)	-- CAMBIADO

--15
UPDATE [dbo].[Proveedor] SET [CiudadProv] = 'Capital Federal' WHERE [NroProv] IN(4,5,6)