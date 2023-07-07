/*Ejercicio 1: Dado el siguiente esquema de relación

	Alumno (DNI, Apellido, Nombre, Escuela)
	HermanoDe (DNIAlumno, DNIHermano)
	Escuela (Codigo, Nombre, Direccion)
	Alimento (Id, Descripcion, Marca)
	AlmuerzaEn (DNIAlumno, IdAlimento, CodigoEscuela)*/

CREATE DATABASE GuiaResueltaEjercicio1
GO
USE GuiaResueltaEjercicio1
GO

CREATE TABLE Escuela
(
	Codigo INT NOT NULL PRIMARY KEY, 
	Nombre VARCHAR (50), 
	Direccion VARCHAR (255)
);

CREATE TABLE Alimento
(
	Id INT NOT NULL PRIMARY KEY, 
	Descripcion	VARCHAR (50),
	Marca VARCHAR (50)
);

CREATE TABLE Alumno
(
	DNI	INT NOT NULL PRIMARY KEY, 
	Apellido VARCHAR (50), 
	Nombre VARCHAR (50), 
	CodigoEscuela INT,
);

ALTER TABLE Alumno ADD CONSTRAINT FK_Alumno_CodigoEscuela FOREIGN KEY (CodigoEscuela) REFERENCES Escuela (Codigo) ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE HermanoDe
(
	DNIAlumno INT NOT NULL, 
	DNIHermano INT NOT NULL, 
	CONSTRAINT PK_HermanoDe PRIMARY KEY (DNIAlumno, DNIHermano)
);

ALTER TABLE HermanoDe ADD CONSTRAINT FK_HermanoDe_DNIAlumno FOREIGN KEY (DNIAlumno) REFERENCES Alumno (DNI) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE HermanoDe ADD CONSTRAINT FK_HermanoDe_DNIHermano FOREIGN KEY (DNIHermano) REFERENCES Alumno (DNI) ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE TABLE AlmuerzaEn
(
	DNIAlumno INT NOT NULL, 
	IdAlimento INT NOT NULL, 
	CodigoEscuela INT, 
	CONSTRAINT PK_AlmuerzaEn PRIMARY KEY (DNIAlumno, IdAlimento)
);

ALTER TABLE AlmuerzaEn ADD CONSTRAINT FK_AlmuerzaEn_DNIAlumno FOREIGN KEY (DNIAlumno) REFERENCES Alumno (DNI) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE AlmuerzaEn ADD CONSTRAINT FK_AlmuerzaEn_IdAlimento FOREIGN KEY (IdAlimento) REFERENCES Alimento (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE AlmuerzaEn ADD CONSTRAINT FK_AlmuerzaEn_CodigoEscuela FOREIGN KEY (CodigoEscuela) REFERENCES Escuela (Codigo) ON DELETE NO ACTION ON UPDATE NO ACTION;

INSERT INTO Escuela (Codigo, Nombre, Direccion) VALUES 
(1, 'Escuela 1', 'Famosos'),
(2, 'Escuela 2', 'Oficialistas'),
(3, 'Escuela 3', 'Opositores'),
(4, 'Escuela 4', 'Hermanos');

INSERT INTO Alumno (DNI, Apellido, Nombre, CodigoEscuela) VALUES 
(1, 'Fort', 'Ricardo', 1),
(2, 'Marcelo', 'Tinelli', 1),
(3, 'Moria', 'Casan', 1),
(4, 'Cristina', 'Fernandez', 2),
(5, 'Anibal', 'Fernandez', 2),
(6, 'Amado', 'Boudou', 2),
(7, 'Ricardo', 'Alfonsin', 3),
(8, 'Elisa', 'Carrio', 3),
(9, 'Hermes', 'Binner', 3),
(10, 'Guido', 'Tinelli', 4),
(11, 'Hugo', 'Tinelli', 4),
(12, 'Alberto', 'Fernandez', 4),
(13, 'Silvia', 'Fernandez', 4),
(14, 'Ricardo', 'Tinelli', 4);

INSERT INTO HermanoDe (DniAlumno, DniHermano) VALUES 
(2, 10), (2, 11), (2, 14), (5, 12), (4, 13), (10, 2), 
(10, 11), (10, 14), (11, 2), (11, 10), (11, 14), (14, 2),
(14, 10), (14, 11);

INSERT INTO Alimento (Id, Descripcion, Marca) VALUES 
(1, 'Hamburguesa', 'Patty'),
(2, 'Milanesa', 'Granja del Sol'),
(3, 'Salchicha', 'Vienisima');

INSERT INTO AlmuerzaEn (DNIAlumno, IdAlimento, CodigoEscuela) VALUES 
(4, 1, 1), (5, 1, 3), (4, 2, 4), (1, 3, 1), (1, 1, 4), (2, 1, 1),
(3, 1, 1), (12, 2, 4), (13, 2, 4), (10, 1, 3), (7, 1, 3), (8, 2, 3),
(9, 3, 3), (1, 2, 3), (3, 3, 3), (6, 3, 3), (12, 1, 3), (13, 1, 3),
(4, 3, 3);

/* a) Listar a todos los alumnos que asisten a escuelas donde no sirven alimentos y almuerzan en otro 
establecimiento.*/

SELECT DISTINCT a.*		-- Alumnos que almuerzan en otro establecimiento
FROM Alumno AS a JOIN AlmuerzaEn ae ON a.DNI = ae.DNIAlumno
WHERE a.CodigoEscuela <> ae.CodigoEscuela AND a.CodigoEscuela NOT IN (SELECT ae.CodigoEscuela		
																	  FROM AlmuerzaEn AS ae)
											-- Alumnos que asisten a las escuelas que no sirven alimentos

/* b) Mostrar todas las escuelas que sirven alimentos a todos sus alumnos que no tienen más de dos hermanos.*/

-- Alumnos que NO tienen mas de dos hermanos
CREATE OR ALTER VIEW v_Alumnos_Menos_De_2_Hermanos AS
(
	SELECT a.DNI
	FROM Alumno AS a
	WHERE a.DNI NOT IN (SELECT hd.DNIAlumno
						FROM HermanoDe AS hd
						GROUP BY hd.DNIAlumno
						HAVING COUNT (*) > 2)
)

SELECT *
FROM Escuela AS e
WHERE NOT EXISTS (SELECT 1
				  FROM v_Alumnos_Menos_De_2_Hermanos AS a
				  WHERE NOT EXISTS (SELECT 1
									FROM AlmuerzaEn AS ae
									WHERE ae.CodigoEscuela = e.Codigo AND ae.DNIAlumno = a.DNI))
