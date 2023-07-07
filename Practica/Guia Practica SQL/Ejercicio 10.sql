/* Ejercicio 10: Dado el siguiente esquema
	Request (NoRequest, IP, Fecha, Hora, IDMetodo)
	Page (IP, WebPage, IDAmbiente)
	Método (ID, Clase, Metodo)
	Ambiente (ID, Descripción)*/

CREATE DATABASE Ejercicio10
GO
USE Ejercicio10;

CREATE TABLE Ambiente
(
	ID INT PRIMARY KEY,
	Descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE Metodo 
(
	ID INT PRIMARY KEY,
	Clase VARCHAR(45) NOT NULL,
	Metodo VARCHAR(45) NOT NULL
);

CREATE TABLE Page 
(
	IP VARCHAR(45) PRIMARY KEY,
	WebPage VARCHAR(45) NOT NULL,
	IDAmbiente INT, 
	FOREIGN KEY (IDAmbiente) REFERENCES Ambiente(ID)
); 

CREATE TABLE Request 
(
	NoRequest INT PRIMARY KEY,
	IP VARCHAR(45) NOT NULL,
	Fecha DATE NOT NULL,
	Hora TIME NOT NULL,
	IDMetodo INT,
	FOREIGN KEY(IP) REFERENCES Page(IP),
	FOREIGN KEY(IDMetodo) REFERENCES Metodo(ID)
); 

INSERT INTO Ambiente (ID, Descripcion) VALUES 
(1,'Desarrollo'),
(2,'Inmuebles'),
(3,'Tecnologia'),
(4,'Automoviles'),
(5,'Decoracion'),
(6,'Moda'),
(7,'Viajes'),
(8,'Gastronomia'),
(9,'Universitario'),
(10,'Cultural');

INSERT INTO Metodo (ID, Clase, Metodo) VALUES 
(1,'Clase 1','Metodo 1'),
(2,'Clase 2','Metodo 2'),
(3,'Clase 3','Metodo 3'),
(4,'Clase 4','Metodo 4'),
(5,'Clase 5','Metodo 5'),
(6,'Clase 6','Metodo 6'),
(7,'Clase 7','Metodo 7'),
(8,'Clase 8','Metodo 8'),
(9,'Clase 9','Metodo 9'),
(10,'Clase 10','Metodo 10');

INSERT INTO Page (IP, WebPage, IDAmbiente) VALUES 
('10.0.0.1','www.ingenieriaUNLaM.com.ar',1),
('10.0.0.2','www.sodimac.com',2),
('10.0.0.3','FTP Serv-U',3),
('10.0.0.4','www.peugeot.com.ar',4),
('10.0.0.5','www.easy.com',5),
('10.0.0.6','la.louisvuitton.com',6),
('10.0.0.7','www.despegar.com.ar',7),
('10.0.0.8','www.cocinaFacil.es',8),
('10.0.0.9','www.utn.com.ar',9),
('10.0.0.10','www.louvre.fr',10);

INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (1,'10.0.0.1',GETDATE(),'12:45:00',1)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (2,'10.0.0.2','2021-03-03','13:17:21',2)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (3,'10.0.0.3','2021-05-30','09:26:15',3)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (4,'10.0.0.4','2021-04-08','11:06:54',4)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (5,'10.0.0.5',GETDATE()-14,'05:14:23',5)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (6,'10.0.0.6',GETDATE()-7,'23:02:11',6)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (7,'10.0.0.7',GETDATE(),'22:50:11',7)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (8,'10.0.0.8','2021-01-29','18:45:52',8)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (9,'10.0.0.9','2021-07-22','15:36:12',9)
INSERT INTO Request (NoRequest, IP, Fecha, Hora, IDMetodo) VALUES (10,'10.0.0.10',GETDATE()-2,'20:02:31',10)

/*Nota: El ambiente podrá ser Desarrollo, Testing o Producción. La función date() devuelve la fecha actual.
Si se resta un valor entero a la función, restará días. El ejercicio consiste en indicar qué enunciado dio
origen a cada una de las consultas*/

-- 1)
SELECT p.IP, COUNT(DISTINCT r.Fecha) AS 'Cantidad de fechas', COUNT(DISTINCT r.IDMetodo) AS 'Cantidad de metodos', MAX(r.Fecha) AS UltimaFecha
FROM Page AS p INNER JOIN Request AS r ON p.IP = r.IP
GROUP BY p.IP

/* Posible enunciado: 
Listar por IP de pagina, la cantidad de fechas y la cantidad de metodos que se uso en esa ip, en su fecha mas reciente*/

-- 2)
SELECT *
FROM Ambiente AS a
WHERE a.ID NOT IN (SELECT p.IDAmbiente
				   FROM Page AS p
				   WHERE NOT EXISTS (SELECT 1
								     FROM Request AS r
								     WHERE r.IP = r.IP AND r.Fecha >= GETDATE() - 7)
				 )

/* Posible enunciado:
Listar todos los ambientes que NO tengan todas las paginas en el que su request tenga como fecha esta ultima semana*/

-- 3)
SELECT Fecha, COUNT(*) AS CantidadDeRequest
FROM Request AS r
WHERE r.Hora BETWEEN '00:00' AND '04:00' AND NOT EXISTS (SELECT 1 
														 FROM Page AS p INNER JOIN Ambiente AS a ON p.IDAmbiente = a.ID
														 WHERE r.IP = p.IP AND a.Descripcion = 'Desarrollo')
GROUP BY r.Fecha
HAVING COUNT(*) >= 10

/*Posible enunciado:
Listar la cantidad de request que sean mayores o iguales a 10 por fecha en la que se ejecuto entre las 12 de la mañana y las 4 de la 
madrugada en las que no se encuentre en el ambiente de desarrollo*/

-- 4)
SELECT p.WebPage, a.Descripcion, MAX(R.fecha) AS UltimaFecha,'S' AS Confirmacion
FROM Request AS r INNER JOIN Page AS p ON r.IP = p.IP INNER JOIN Ambiente AS a ON a.ID = p.IDAmbiente
WHERE r.Fecha >= GETDATE() - 7 AND p.WebPage LIKE 'www%'
GROUP BY p.WebPage, a.Descripcion
HAVING COUNT(DISTINCT r.Fecha) >= 7

/*Posible enuncuado:
Listar por nombre de la pagina web y en que ambiente se encuentre destinado, la ultima fecha en la que se realizo un
request entre esta ultima semana y que la pagina web empieze con 'www' Listar unicamente en la que en esta ultima fecha
se han realizado mas de 7 request inclusive de IP's distintos*/

-- 5)
SELECT p.WebPage, a.Descripcion, MAX(CASE WHEN r2.UltimaFecha IS NULL THEN '01/01/1900' ELSE r2.UltimaFecha END), 'N' AS 'Confirmacion'
FROM Page AS p LEFT JOIN (SELECT IP, MAX(r.Fecha) AS UltimaFecha FROM Request AS r GROUP BY r.IP) AS r2 ON r2.IP = p.IP 
			   INNER JOIN Ambiente AS a ON a.ID = p.IDAmbiente
WHERE p.WebPage LIKE 'ftp%' AND NOT EXISTS (SELECT 1
											FROM Request AS r
											WHERE r.IP = p.IP AND r.Fecha >= GETDATE() - 7
											GROUP BY r.IP
											HAVING COUNT(*) >= 7)
GROUP BY p.WebPage, a.Descripcion

/* Posible enunciado: Listar por nombre de la pagina web y en que ambiente se encuentre destinado, la ultima fecha en la que se 
realizo un request de las paginas que sean de tipo FTP y que NO exista algun request de esta ultima semana en la que se hayan
realizado mas de 7 request inclusive. En el caso de listar la ultima fecha y que tenga el valor NULL, mostrarla con la fecha 
'01/01/1900'*/

-- Fuente: https://www.sqlshack.com/es/consulta-de-datos-utilizando-la-sentencia-sql-case/

-- 6)
INSERT INTO Page
SELECT IP, 'Web' + r.IDMetodo, '?'
FROM Request AS r
WHERE NOT EXISTS (SELECT 1 
				  FROM Page AS p
				  WHERE r.IP = p.IP)
	  AND r.IDMetodo IN (SELECT m.ID 
					   FROM Metodo AS m)
	  AND r.Fecha >= GETDATE() - 30

/* Posible enunciado: ???*/