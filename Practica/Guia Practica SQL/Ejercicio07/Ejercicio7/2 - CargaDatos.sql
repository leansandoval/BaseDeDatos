USE  [Ejercicio_7]
GO

INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA001','M1',2000)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA002','M2',2001)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA003','M3',2002)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA004','M4',2003)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA005','M5',2004)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA006','M6',2005)
INSERT INTO [dbo].[Auto] (Matricula, Modelo, Anio) VALUES ('AAA007','M7',2006)

GO

INSERT INTO [dbo].[Chofer] (Nombre, Apellido, FechaIngreso, Telefono) VALUES ('Chofer1','Apellido 1','10-10-2022','1500000001')
INSERT INTO [dbo].[Chofer] (Nombre, Apellido, FechaIngreso, Telefono) VALUES ('Chofer2','Apellido 2','11-10-2022','1500000001')
INSERT INTO [dbo].[Chofer] (Nombre, Apellido, FechaIngreso, Telefono) VALUES ('Chofer3','Apellido 3','12-10-2022','1500000001')
INSERT INTO [dbo].[Chofer] (Nombre, Apellido, FechaIngreso, Telefono) VALUES ('Chofer4','Apellido 4','13-10-2022','1500000001')
INSERT INTO [dbo].[Chofer] (Nombre, Apellido, FechaIngreso, Telefono) VALUES ('Chofer5','Apellido 5','14-10-2022','1500000001')

GO

INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C1',1,'Laferrere')
INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C2',2,'Laferrere')
INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C3',3,'El Palomar')
INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C4',4,'San Justo')
INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C5',5,'Ramos Mejia')
INSERT INTO [dbo].[Cliente] (Calle, Nro, Localidad) VALUES ('C6',6,'Isidro Casanova')

GO

INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('14-10-2022','15-10-2022',1,1,'AAA001',10,1,500,10)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('19-10-2022','20-10-2022',2,2,'AAA002',1000,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('19-10-2022','20-10-2022',1,1,'AAA002',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('19-10-2020','20-10-2020',5,1,'AAA001',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('20-10-2020','20-10-2020',5,1,'AAA002',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('21-10-2020','20-10-2020',5,1,'AAA003',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('22-10-2020','20-10-2020',5,1,'AAA004',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('23-10-2020','20-10-2020',5,1,'AAA005',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('24-10-2020','20-10-2020',5,1,'AAA006',100,10,500,100)
INSERT INTO [dbo].[Viaje] (FechaHoraInicio,FechaHoraFin,Chofer,Cliente,Auto,KmTotales,EsperaTotal,CostoEspera,CostoKms) VALUES ('25-10-2020','20-10-2020',5,1,'AAA007',100,10,500,100)