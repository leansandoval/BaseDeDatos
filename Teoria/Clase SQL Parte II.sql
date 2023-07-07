/*CREATE DATABASE UNLAM
GO
USE UNLAM

ALTER DATABASE UNLAM
MODIFY NAME = ClaseTeoricaSQLParteII*/
CREATE DATABASE ClaseTeoricaSQLParteII
GO
USE ClaseTeoricaSQLParteII
GO

/*Diferencia entre CHAR y VARCHAR
COMPLETAR !!!
*/

CREATE DATABASE UNLAM
GO
USE UNLAM
GO

CREATE TABLE Departamento
(
	CodDepto INTEGER PRIMARY KEY,
	Descripcion	VARCHAR(30),
)

CREATE TABLE Empleado
(
	Legajo INTEGER PRIMARY KEY,
	Nombre VARCHAR(30),
	Apellido VARCHAR(30),
	Salario NUMERIC(8,2),
	Categoria CHAR(1),
	Telefono CHAR(15),
	CodDepto INTEGER CONSTRAINT FK_Empleado_Depto FOREIGN KEY REFERENCES Departamento (CodDepto),
)

CREATE TABLE Alumno
(
	Legajo INTEGER PRIMARY KEY,
	Nombre VARCHAR(30),
	Apellido VARCHAR(30),
	Email VARCHAR(40),
	Telefono CHAR(15),
)

CREATE TABLE Materia
(
	CodMateria INTEGER PRIMARY KEY,
	Nombre VARCHAR(45),
	AnioCarrera INTEGER
)

CREATE TABLE Cursa
(
	Legajo INTEGER FOREIGN KEY REFERENCES Alumno(Legajo),
	CodMateria INTEGER FOREIGN KEY REFERENCES Materia(CodMateria),
	PRIMARY KEY (Legajo, CodMateria)
)

INSERT INTO Departamento VALUES 
(1,'Ventas'), 
(2,'Compras'), 
(3,'Contabilidad'), 
(4,'Marketing'), 
(5,'Sistemas');

INSERT INTO Empleado VALUES 
(100,'Marcelo','Mendez',120000,'B',NULL,1),
(101,'Diego','Mancieri',60000,'A','555-1234',2),
(102,'Andrea','Alberti',90000,'C','555-5678',3),
(103,'Janice','Orzechoski',100000,'C',NULL,4),
(104,'Fabio','Vitale',180000,'A',NULL,5),
(105,'Rodrigo','Berti',180000,'A',NULL,5);

INSERT INTO Materia VALUES 
(100,'Analisis Matematico I',1),
(101,'Algebra I',1),
(201,'Fisica I',2),
(202,'Algebra II',2),
(301,'Base de Datos',3),
(302,'Probabilidad y Estadistica',3);

INSERT INTO Alumno VALUES 
(10,'Maria','Suarez',NULL,NULL),
(11,'Pablo','Perez',NULL,NULL),
(12,'Laura','Almagro',NULL,NULL),
(13,'Jorge','Gonzalez',NULL,NULL);

INSERT INTO Cursa VALUES 
(11,100),
(11,101),
(12,101),
(12,201),
(12,301),
(13,202),
(13,301),
(13,302);

/*********************************************** SUM() *************************************************/

-- Suma todos los elementos la columna dentro de la funcion 
SELECT SUM(e.Salario) AS TotalSalarios
FROM Empleado AS e

SELECT SUM(Salario)	AS TotalSalariosSistemas
FROM Empleado AS e, Departamento AS d
WHERE e.CodDepto = d.CodDepto AND d.Descripcion = 'Sistemas'

/*********************************************** MAX() - MIN () *************************************************/

SELECT MIN(e.Salario) AS SueldoMinimoCategoriaA, MAX(e.Salario) AS SueldoMaximoCategoriaA
FROM Empleado AS e
WHERE e.Categoria='A'

/*********************************************** COUNT() *************************************************/

SELECT COUNT(*) AS CantidadDepartamentos
FROM Departamento

SELECT COUNT(*) AS CantidadTotalEmpleados
FROM Empleado AS e

SELECT COUNT(*) AS CantidadTotalEmpleados, COUNT(e.Telefono) AS CantidadEmpleadosConTelefono
FROM Empleado AS e

-- Lo de arriba es equivalente a:
SELECT COUNT(*) CantidadEmpleadosConTelefono
FROM Empleado AS e
WHERE e.Telefono IS NOT NULL

-- La contraparte:
SELECT COUNT(*) CantidadEmpleadosConTelefono
FROM Empleado AS e
WHERE e.Telefono IS NULL

/*********************************************** GROUP BY *************************************************/
SELECT e.Categoria, COUNT(*) AS CantidadEmpleadosPorCategoria 
FROM Empleado AS e
GROUP BY e.Categoria				-- Las columnas normales (no agrupadas) siempre DEBEN estar en el GROUP BY

SELECT COUNT(*) AS CantidadEmpleadosPorCategoria
FROM Empleado AS e
GROUP BY e.Categoria				-- Pero en el GROUP BY es posible colocar columnas que no est�n en el SELECT

/*********************************************** HAVING *************************************************/
-- Listar la cantidad de Empleados por cada Departamento que tengan mas de 1 empleado
SELECT d.Descripcion, COUNT(*) AS CantidadEmpleados
FROM Departamento AS d INNER JOIN Empleado AS e ON d.CodDepto = e.CodDepto		--Condicion de junta para unir ambas tablas
GROUP BY d.Descripcion
HAVING COUNT(*) > 1			

-- Listar la cantidad de Empleados por Catergoria, con salario mayor a $80000 y tenga mas de 1 empleado
SELECT e.Categoria, COUNT(*) CantidadEmpleados
FROM Empleado AS e
WHERE e.Salario > 80000
GROUP BY e.Categoria
HAVING COUNT(*) > 1			-- No es posible utilizar el alias, ya que el motor lee SELECT despues del HAVING

-- Otro ejemplo con SUM
SELECT e.Categoria, SUM(e.Salario) TotalSueldos
FROM Empleado AS e
WHERE Salario > 80000
GROUP BY e.Categoria
HAVING SUM(e.Salario) > 200000

-- Listar la cantidad de empleados unicamente que su departamento empiecen con C

/*SELECT d.Descripcion, COUNT(*) AS CantidadEmpleados
FROM Departamento AS d INNER JOIN Empleado AS e ON d.CodDepto = e.CodDepto
GROUP BY d.Descripcion
HAVING d.Descripcion LIKE 'C%'*/

--Si se puede realizar la operacion en el WHERE es mejor ponerlo ahi
SELECT d.Descripcion, COUNT(*) AS Cantidad_Empleados
FROM Departamento AS d INNER JOIN Empleado AS e ON d.CodDepto = e.CodDepto
WHERE d.Descripcion LIKE 'C%'
GROUP BY d.Descripcion

-- Usar 3 tablas con y sin INNER JOIN

SELECT Descripcion, COUNT(*) AS CantidadEmpleados
FROM Departamento, Empleado, Tabla3
WHERE Departamento.CodDepto = Empleado.CodDepto
GROUP BY Descripcion
HAVING COUNT(*) > 1

SELECT d.Descripcion, COUNT(*) AS CantidadEmpleados
FROM Departamento AS d INNER JOIN Empleado AS e ON d.CodDepto = e.CodDepto INNER JOIN Tabla3 AS t3 ON t3.CodDepto = e.CodDepto
GROUP BY d.Descripcion
HAVING COUNT(*) > 1

-- No se puede usar alias en HAVING, pero si se puede anidar una consulta para luego usar su alias en las proximas

SELECT * 
FROM (SELECT d.Descripcion, COUNT(*) AS Cantidad
	  FROM Departamento AS d INNER JOIN Empleado AS e ON d.CodDepto = e.CodDepto
	  GROUP BY d.Descripcion) AS a
WHERE a.Cantidad>1

/*********************************************** ORDER BY *************************************************/

-- El orden es importante

SELECT *
FROM Empleado AS e
ORDER BY e.CodDepto, e.Categoria, e.Salario DESC	

-- Fijarse los valores NULL

SELECT *
FROM Empleado AS e
ORDER BY e.Telefono DESC							

-- Ordena usando el alias

SELECT e.Nombre, e.Salario AS Sueldo
FROM Empleado AS e
ORDER BY Sueldo										

-- Ordena por numero de columnas: esto se puede hacer con columnas que se encuentren en el SELECT (no en la tabla)

SELECT e.Nombre, e.Apellido, e.Salario
FROM Empleado AS e
ORDER BY 3,2										-- Ordena por Salario (Columna 3) y luego por Apellido (Columna 2)

-- Ordena por alias de columnas derivadas

SELECT e.Nombre, e.Apellido, e.Salario AS SueldoEnPesos, ROUND(salario/185,2) AS SueldoEnUSD	
FROM Empleado AS e		--La funcion ROUND redondea en decimales
ORDER BY SueldoEnUSD								

-- Tambien se puede por columnas derivadas que no aparezcan

SELECT e.Nombre, e.Apellido, e.Salario AS SueldoEnPesos	
FROM Empleado AS e
ORDER BY ROUND(salario/185,2) 						

-- Despues de un GROUP BY no podemos hacer ORDER BY por columnas que no esten dentro del SELECT

SELECT e.Categoria, SUM(e.Salario) AS TotalSueldos
FROM Empleado AS e
WHERE e.Salario > 80000
GROUP BY e.Categoria
HAVING SUM(e.Salario) > 150000
ORDER BY TotalSueldos

-----------------------------------------------------------------------------------------------------------

-- Ejemplo de NOT EXISTS: listar los Departamentos en los cuales NO trabaja ningun empleado

INSERT INTO Departamento VALUES (6,'Sanidad')

SELECT *
FROM Departamento AS d
WHERE NOT EXISTS (SELECT *
				  FROM Empleado AS e
				  WHERE e.CodDepto = d.CodDepto)

-- Listar todos los alumnos que no cursan ninguna materia
-- OJO !! No es un cociente

-- Forma 1:

SELECT *
FROM Alumno AS a
WHERE NOT EXISTS (SELECT *
				  FROM Cursa AS c
				  WHERE c.Legajo = a.Legajo)

-- Forma 2:

SELECT a.*
FROM Alumno AS a
WHERE a.Legajo NOT IN (SELECT Legajo
					   FROM Cursa AS c)

-- Forma 3:

SELECT a.Legajo
FROM Alumno AS a
EXCEPT
SELECT c.Legajo
FROM Cursa AS c

/*********************************************** COCIENTE *************************************************/

-- Listar los legajos y apellidos de los alumnos que cursan todas las materias de tercer anio
-- Otra forma de decir: Listar los Alumnos tales que NO EXISTE una Materia de tercer anio que NO cursen

SELECT a.*
FROM Alumno AS a
WHERE NOT EXISTS (SELECT 1
					FROM Materia AS m
					WHERE m.AnioCarrera = 3 AND NOT EXISTS (SELECT 1
															FROM Cursa AS c
															WHERE c.Legajo = a.Legajo AND c.CodMateria = m.CodMateria)
					)

-- Otra forma de resolverlo:
-- Esta condicion va en el HAVING de abajo

SELECT COUNT(*)
FROM Materia AS m
WHERE m.AnioCarrera=3

SELECT c.Legajo, COUNT(*) Materias3erQueCursa
FROM Cursa AS c INNER JOIN Materia AS m ON c.CodMateria = m.CodMateria
WHERE m.AnioCarrera = 3
GROUP BY c.Legajo
HAVING COUNT(*) = (SELECT COUNT(*)
					FROM Materia AS m
					WHERE m.AnioCarrera = 3)

-- Listar los Legajos y Apellidos de los Alumnos que aprobaron (Nota >= 4) todas las Materias de 3er anio de la Carrera Ing. Informatica
-- Otra forma de leerlo: listar los Alumnos tales que NO EXISTE una Materia de 3er anio de Ing. en Informatica que no hayan Aprobado

SELECT a.Legajo, a.Apellido
FROM Alumno AS a
WHERE NOT EXISTS (SELECT *						-- "Tales que NO EXISTE una materia de 3er anio"
				  FROM Materia AS m
				  WHERE m.Carrera = '0 - Ingenieria en Informatica' AND m.Descripcion LIKE 'Materia3%'
				  AND NOT EXISTS (SELECT *		-- "Que no hayan aprobado"
								  FROM Nota AS n
								  WHERE n.Legajo=a.Legajo AND n.cod_materia=m.cod_materia AND n.nota>=4	)
				)						-- Mismo alumno				-- Misma materia		-- Que hayan aprobado

--Otra forma de resolver el cociente (no recomendada)
-- Contamos cuantas materias hay en 3er anio (condicion del HAVING de abajo)
SELECT COUNT(*) AS Cantidad_Materias_3er_Anio
FROM Materia as m
WHERE m.Carrera = '0 - Ingenieria en Informatica' AND m.Descripcion LIKE 'Materia3%'

--Contamos cuantas materias de 3er anio aprobo cada alumno
SELECT n.Legajo, COUNT(*) CantidadMateriasAprobadas
FROM Nota AS n							
WHERE n.Nota> = 4 AND n.CodMateria IN (SELECT m.CodMateria						--Aprobados. IN es equivalente a un pertenece						
									   FROM Materia AS m						--Unicamente materias de tercer anio
									   WHERE m.Carrera = '0 - Ingenieria en Informatica' AND m.Descripcion LIKE 'Materia3%')
GROUP BY n.LEGAJO																--Quienes son los alumnos que aprobaron todas
HAVING COUNT(*) = (SELECT COUNT(*) AS CantidadMaterias3erAnio					--Cuantas materias hay en tercer anio
				   FROM Materia as m
				   WHERE m.Carrera = '0 - Ingenieria en Informatica' AND m.Descripcion LIKE 'Materia3%')

-- Listar los Clientes que Comparon en todas las Sucursales de Avellaneda
-- Otra forma de decir: Listar los Clientes tales que NO EXISTE una Sucursal de Avellaneda en la que NO HAYAN Comprado

SELECT c.*
FROM Cliente AS c
WHERE NOT EXISTS (SELECT 1
					FROM Sucursal AS s
					WHERE s.Localidad = 'Avellaneda' 
					AND NOT EXISTS (SELECT 1
									FROM Compra AS com
									WHERE c.CodCliente = com.CodCliente 
									AND s.CodSucursal = com.CodSucursal)
					)

-- Listar los Empleados que estan Asignados a todos los Proyectos de categoria A
-- Otra forma de decir: Listar los Empleados tales que NO EXISTE un Proyecto de categoria A en el que NO este Asignado

SELECT e.*
FROM Empleado AS e
WHERE NOT EXISTS (SELECT 1
					FROM Proyecto AS p
					WHERE p.Categoria = 'A'
					AND NOT EXISTS (SELECT 1
									FROM Asignado AS a
									WHERE a.Legajo = e.Legajo AND p.IdProyecto = a.IdProyecto)
				 )

/****************** Ejercicio de Parcial ********************/

/*
Comercio (Id, Nombre, IdCategoria, IdPartido)
Pedido (Id, IdUsuario, NroDireccionUsuario, Fecha, Monto, IdDelivery, IdComercio, IdMedioPago)
DetellePedido (IdPedido, IdItem, Cantidad)
Item (IdComercio, Id, Precio)
Usuario (Id, Nombre)
Direccion (IdUsuario, Numero, IdLocalidad, Calle, Departamento, Piso)
Delivery (Id, Nombre, Calificacion)
MedioPago (Id, Descripcion)
Categoria (Id, Descripcion)
Partido (Id, IdProvincia, Nombre)
Provincia (Id, Nombre)
*/

-- Listar los usuarios que han realizado en TODOS lo Comercios de categoria 'Sushi'
-- del partido de Moron entre el 01/01/2020 y 01/07/2021

GO

CREATE VIEW SushiMoron AS (
	SELECT co.Id
	FROM Comercio AS co INNER JOIN Categoria AS ca ON co.IdCategoria = ca.Id 
						INNER JOIN Partido AS p ON p.Id = co.IdPartido
	WHERE ca.Descripcion = 'Sushi' AND p.Nombre = 'Moron'
)

GO

-- Listar los Usuarios tales que NO EXISTE un Comercio de Sushi de Moron en el que NO haya hecho 
-- un PEDIDO entre el 01/01/2020 y 01/07/2021

SELECT u.*
FROM Usuario AS u
WHERE NOT EXISTS (SELECT *
				  FROM SushiMoron AS s
				  WHERE NOT EXISTS (SELECT *
									FROM Pedido AS p
									WHERE p.IdUsuario = u.Id AND p.idComecio = s.Id
									AND p.Fecha BETWEEN '01-01-2020' AND '01-07-2021')
				  )

/*********************************************** VIEW *************************************************/

/* Las vistas ocupan espacio en la Base de Datos? No, las vistas no ocupan espacio porque no contienen 
datos (solo ocupan un espacio MINIMO correspondiente al texto de la consulta)*/

CREATE VIEW Vista1 AS
(
	SELECT e.Legajo, e.Apellido, d.Descripcion AS Departamento
	FROM Departamento AS d INNER JOIN Empleado AS e ON e.CodDepto = d.CodDepto
)

SELECT *
FROM Vista1 AS v1
WHERE v1.Departamento = 'Sistemas'

DROP VIEW Vista1

-- Renombrar el nombre de los campos (parecido al AS)
CREATE VIEW Vista2 (Departamento, CantidadDeEmpleados) AS 
(
	SELECT d.Descripcion, COUNT(*)
	FROM Departamento AS d INNER JOIN Empleado AS e ON e.CodDepto = d.CodDepto
	GROUP BY d.Descripcion
)

SELECT *
FROM Vista2 AS v2
WHERE v2.CantidadDeEmpleados > 1

--Renombrar el nombre de los campos (parecido al AS)
CREATE VIEW Vista3 (Departamento, CantidadDeEmpleados) AS		
(
	SELECT d.Descripcion, COUNT(*)
	FROM Departamento AS d INNER JOIN Empleado AS e ON e.CodDepto = d.CodDepto
	GROUP BY d.Descripcion
	--ORDER BY 2	-- No se puede poner un ORDER BY dentro de la vista
)

SELECT *
FROM Vista3
ORDER BY 2

--No se pueden nombrar vistas con el nombre de una tabla/vista
CREATE VIEW Departamento AS
(
	SELECT *
	FROM Empleado
)

--Borrar
DROP VIEW Vista3

-- Crear vista de vista
CREATE VIEW Vista4 AS
(
	SELECT *
	FROM Vista2
	WHERE CantidadDeEmpleados = 2
)

-- Borrar la vista que estaba dentro de la vista, no se puede ejecutar. La vista queda 'rota'
DROP VIEW Vista2

--Actualizacion (Vistas actualizables)
--Caso 1: Vista NO actualizable. No es posible ya que la vista es muy compleja

-- Renombrar el nombre de los campos (parecido al AS)
CREATE VIEW Vista2 (Departamento, CantidadDeEmpleados) AS
			
(
	SELECT d.Descripcion, COUNT(*)
	FROM Departamento AS d INNER JOIN Empleado AS e ON e.CodDepto = d.CodDepto
	GROUP BY d.Descripcion
)

--Ejemplo: actualizar Ventas a Comercial
UPDATE	Vista2
SET Departamento = 'Comercial'
WHERE Departamento = 'Ventas'

--Caso 2: Vista actualizable (cambia los datos en la tabla)
CREATE VIEW EmpA AS
(
	SELECT *
	FROM Empleado AS e
	WHERE e.Categoria = 'A'
)

UPDATE EmpA
SET Telefono = '111-2222'
WHERE Legajo = 105

UPDATE EmpA
SET Legajo = 115
WHERE Legajo = 105

/*********************************************** INSERT *************************************************/

--INSERT INTO Empleado VALUES (120,'Laura','Garcia',800000,'C','333-456',5)
--INSERT INTO Empleado VALUES (120,'Laura','Garcia',800000,'C',NULL,5)						--Con valores NULL
INSERT INTO Empleado (Legajo,Nombre,Apellido,CodDepto) VALUES (120,'Laura','Garcia',5)		--Indicando columnas, las que no estan indicadas quedan con NULL

--Insertar mas de una fila: se agrega ,
INSERT INTO Empleado (legajo,nombre,apellido,cod_depto) VALUES 
(121,'Maria','Gonzalez',2), 
(122,'Jorge','Peralta',3);

--Otra forma de insertar filas
CREATE TABLE Empleado2
(
	legajo		integer PRIMARY KEY,
	nombre		varchar(30),
	apellido	varchar(30),
	salario		numeric(8,2),
	categoria	char(1),
	tel			char (15),
	cod_depto	integer CONSTRAINT fk_emp_depto2 FOREIGN KEY REFERENCES Departamento (cod_depto),
)

INSERT INTO Empleado2	--Insertar 3 filas en Empleado2
SELECT *
FROM Empleado AS e
WHERE e.cod_depto=5		--Unicamente las que tengan el codigo 5

/*********************************************** DELETE *************************************************/
DELETE Empleado			--Borra todas las filas de la tabla

DELETE Empleado			--Borra las filas que tenga en categoria NULL
WHERE categoria IS NULL	

--No se pueden borrar FK's
DELETE Departamento
WHERE cod_depto = 5

/*********************************************** UPDATE *************************************************/
UPDATE Empleado
SET Salario=Salario*1.1

UPDATE Empleado
SET Tel='889-0123'
WHERE Legajo=100

/*********************************************** TRUNCATE *************************************************/
TRUNCATE TABLE Empleado2	--Sigue existiendo la tabla, solamente VACIA la tabla