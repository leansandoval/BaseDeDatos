/*Ejercicio 10: Dado el siguiente esquema
	Request (NoRequest, IP, Fecha, Hora, IDMetodo)
	Page (IP, WebPage, IDAmbiente)
	Metodo (ID, Clase, Metodo)
	Ambiente (ID, Descripcion)
	
Nota: El ambiente podra ser Desarrollo, Testing o Produccion. La funcion date() devuelve la fecha actual.
Si se resta un valor entero a la funcion, restara dias. El ejercicio consiste en indicar que enunciado dio
origen a cada una de las consultas	*/

-- 1)
SELECT p.Ip, COUNT(DISTINCT r.Fecha) AS 'Cantidad de fechas', COUNT(DISTINCT r.IDMetodo) AS 'Cantidad de metodos', MAX(r.Fecha) AS UltimaFecha
FROM Page AS p INNER JOIN Request AS r ON p.Ip = r.Ip
GROUP BY p.Ip

/* Posible enunciado: 
Listar por Ip de pagina, la cantidad de fechas y la cantidad de metodos que se uso en esa ip, en su fecha mas reciente*/

-- 2)
SELECT *
FROM Ambiente AS a
WHERE a.Id NOT IN (SELECT p.IdAmbiente
				   FROM Page AS p
				   WHERE NOT EXISTS (SELECT 1
								     FROM Request AS r
								     WHERE r.Ip = r.Ip AND r.Fecha >= GETDATE() - 7)
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
Listar la cantidad de request que sean mayores o iguales a 10 por fecha en la que se ejecuto entre las 12 de la maniana y las 4 de la 
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
FROM Page AS p LEFT JOIN (SELECT Ip, MAX(r.Fecha) AS UltimaFecha FROM Request AS r GROUP BY r.IP) AS r2 ON r2.IP = p.IP 
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
SELECT Ip, 'Web' + r.IDMetodo, '?'
FROM Request AS r
WHERE NOT EXISTS (SELECT 1 
				  FROM Page AS p
				  WHERE r.Ip = p.Ip)
	  AND r.IdMetodo IN (SELECT m.ID 
					   FROM Metodo AS m)
	  AND r.Fecha >= GETDATE() - 30

/* Posible enunciado: ???*/