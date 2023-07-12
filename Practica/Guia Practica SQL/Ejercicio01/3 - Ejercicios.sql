-- 1. Listar los nombres de los proveedores de la ciudad de La Plata. 

SELECT p.Nombre
FROM Proveedor AS p
WHERE p.Ciudad = 'La Plata'

-- 1.b Listar los proveedores cuya localidad contenga la cadena de texto: [Plata] 

SELECT p.Nombre
FROM Proveedor AS p
-- WHERE Ciudad LIKE '___Plata%'	-- 3 caracteres unicamente, Plata y cualquier caracter que siga
WHERE p.Ciudad LIKE '%Plata%'		-- Ya no es un operador de igualdad como el punto anterior si no que sea como...

-- 1.c Listar los proveedores cuya localidad contenga la cadena [Fernando]

SELECT Nombre
FROM Proveedor
WHERE Ciudad LIKE '%Fernando%'

-- 2. Listar los numeros de articulos cuyo precio sea inferior a $100. 

SELECT a.CodArt
FROM Articulo AS a
-- WHERE a.Precio < '100'			-- SQL hace una conversion, no hay problema si pone los enteros como cadena
WHERE a.Precio < 100

-- 3. Listar los responsables de los almacenes. 

SELECT a.Responsable
FROM Almacen AS a

-- 4. Listar los codigos de los materiales que provea el proveedor 3 y no los provea el proveedor 5. 

-- Usando EXCEPT: Selecciona los codigos de material cuando el proveedor sea igual a 3 menos los codigos de materiales provistos por el proveedor 5 

SELECT pp.CodMat
FROM ProvistoPor AS pp
WHERE pp.CodProv = 3
EXCEPT
SELECT pp.CodMat
FROM ProvistoPor AS pp
WHERE pp.CodProv = 5

-- Usando NOT IN
SELECT pp.CodMat
FROM ProvistoPor AS pp
WHERE pp.CodProv = 3 AND pp.CodMat NOT IN (SELECT pp.CodMat
										   FROM ProvistoPor AS pp
										   WHERE pp.CodProv = 5)

-- Usando NOT EXISTS: Selecciona los codigos de materiales provistos por el proveedor 3 tal que no exista ese codigo 
-- de material siendo provisto por el proveedor 5

SELECT pp.CodMat						
FROM ProvistoPor AS pp
WHERE pp.CodProv = 3 AND NOT EXISTS (SELECT 1					-- Constante porque evaluo que sea verdadero
									 FROM ProvistoPor AS ppp
									 WHERE ppp.CodProv = 5 AND pp.CodMat = ppp.CodMat)

-- Usando ALL
SELECT pp.CodMat
FROM ProvistoPor AS pp
WHERE pp.CodProv = 3 AND pp.CodMat <> ALL (SELECT ppp.CodMat
										   FROM ProvistoPor AS ppp
										   WHERE ppp.CodProv = 5)

-- Usando ANY
SELECT pp.CodMat 
FROM ProvistoPor AS pp
WHERE pp.CodProv = 3 AND NOT pp.CodMat = ANY (SELECT ppp.CodMat 
											  FROM ProvistoPor AS ppp
											  WHERE ppp.CodProv = 5)

-- 5. Listar los numeros de almacenes que almacenan el articulo 1. 

SELECT t.NroAlmacen
FROM Tiene AS t
WHERE t.CodArt = 1

-- 5.b Listar los responsables de los numeros de almacenes que almacenan el articulo 1

-- Usando Producto Cartesiano
SELECT a.Nro, a.Responsable
FROM Tiene AS t CROSS JOIN Almacen AS a			
WHERE t.CodArt = 1 AND t.NroAlmacen = a.Nro

-- Usando INNER JOIN
SELECT a.Nro,a.Responsable
FROM Tiene AS t INNER JOIN Almacen AS a ON a.Nro=t.NroAlmacen
WHERE t.CodArt = 1

-- 6. Listar los proveedores de Pergamino que se llamen Perez.

SELECT p.CodProv
FROM Proveedor AS p
WHERE p.Ciudad = 'Pergamino' AND p.Nombre LIKE '%P_rez%'

-- 7. Listar los almacenes que contienen los articulos 1 y los articulos 2 (ambos). 

-- Usando INTERSECT

SELECT t.NroAlmacen
FROM Tiene AS t
WHERE t.CodArt = 1
INTERSECT
SELECT t.NroAlmacen
FROM Tiene AS t
WHERE t.CodArt = 2

-- Usando IN

SELECT t.NroAlmacen
FROM Tiene t
WHERE t.CodArt = 1 AND t.NroAlmacen IN (SELECT t.NroAlmacen
										FROM Tiene t
										WHERE t.CodArt = 2)

-- Usando EXISTS

SELECT t.NroAlmacen
FROM Tiene t
WHERE t.CodArt = 1 AND EXISTS (SELECT 1
							   FROM Tiene tt
							   WHERE tt.CodArt = 2 AND t.NroAlmacen = tt.NroAlmacen)

-- Usando Producto Cartesiano

SELECT t.NroAlmacen
FROM Tiene t CROSS JOIN Tiene tt	-- Equivalente a FROM Tiene t, Tiene tt
WHERE t.CodArt = 1 AND tt.CodArt = 2 AND t.NroAlmacen = tt.NroAlmacen 

-- 8. Listar los articulos que cuesten mas de $100 o que estan compuestos por el material 1. 

-- Usando Union

SELECT a.CodArt
FROM Articulo AS a
WHERE a.Precio > 100
UNION
SELECT cp.CodArt
FROM CompuestoPor AS cp
WHERE cp.CodMat = 1

-- Usando LEFT JOIN

SELECT DISTINCT a.CodArt
FROM Articulo AS a LEFT JOIN CompuestoPor AS cp ON a.CodArt = cp.CodArt
WHERE a.Precio > 100 OR cp.CodMat = 1

-- 9. Listar los materiales, codigo y descripcion, provistos por proveedores de la ciudad de La Plata. 

SELECT DISTINCT m.*
FROM ProvistoPor AS pp JOIN Proveedor AS p ON pp.CodProv = p.CodProv JOIN Material AS m ON m.CodMat = pp.CodMat
WHERE p.Ciudad = 'La Plata'

-- 10. Listar el codigo, descripcion y precio de los articulos que se almacenan en el almacen 1. 

SELECT a.*
FROM Tiene AS t JOIN Articulo AS a ON t.CodArt = a.CodArt
WHERE t.NroAlmacen = 1

-- 11. Listar la descripcion de los materiales que componen el articulo 2. 

SELECT m.Descripcion
FROM CompuestoPor AS cp JOIN Material AS m ON cp.CodMat = m.CodMat
WHERE cp.CodArt = 2

-- 12. Listar los nombres de los proveedores que proveen los materiales al almacen que Rogelio Funes Mori tiene a su cargo. 

SELECT DISTINCT p.Nombre
FROM Almacen AS a JOIN Tiene AS t ON a.Nro = t.NroAlmacen JOIN CompuestoPor AS cp ON cp.CodArt = t.CodArt 
				JOIN ProvistoPor AS pp ON pp.CodMat = cp.CodMat JOIN Proveedor AS p ON p.CodProv = pp.CodProv
WHERE a.Responsable = 'Rogelio Funes Mori'

-- 13. Listar codigos y descripciones de los articulos compuestos por al menos un material provisto por el proveedor Porco. 

SELECT DISTINCT a.CodArt, a.Descripcion
FROM ProvistoPor AS pp JOIN CompuestoPor AS cp ON pp.CodMat = cp.CodMat 
					JOIN Articulo AS a ON cp.CodArt = a.CodArt 
					JOIN Proveedor AS p ON pp.CodProv = p.CodProv
WHERE p.Nombre LIKE '%Porco%'

-- 14. Hallar los codigos y nombres de los proveedores que proveen al menos un material que se usa en algun articulo cuyo precio es mayor a $100. 

SELECT DISTINCT p.CodProv, p.Nombre
FROM Articulo AS a JOIN CompuestoPor AS cp ON a.CodArt = cp.CodArt 
				JOIN ProvistoPor AS pp ON cp.CodMat = pp.CodMat 
				JOIN Proveedor AS p ON p.CodProv = pp.CodProv
WHERE a.Precio > 100

-- 15. Listar los numeros de almacenes que tienen todos los articulos que incluyen el material con codigo 1. 

SELECT *
FROM Almacen AS al
WHERE NOT EXISTS (
				SELECT 1
				FROM Articulo AS ar JOIN CompuestoPor AS cp ON ar.CodArt = cp.CodArt
				WHERE cp.CodMat = 1 AND NOT EXISTS (
								SELECT 1
								FROM Tiene AS t
								WHERE t.CodArt = ar.CodArt AND t.NroAlmacen = al.Nro
								)
				)

-- 16. Listar los proveedores de Capital Federal que sean unicos proveedores de algun material.

-- Forma 1:
SELECT pp.CodProv
FROM ProvistoPor AS pp
WHERE pp.CodMat NOT IN (SELECT DISTINCT pp.CodMat
						FROM ProvistoPor AS pp INNER JOIN Proveedor AS p ON pp.CodProv = p.CodProv
						WHERE p.Ciudad NOT LIKE 'CABA')

-- Forma 2:

GO

CREATE OR ALTER VIEW vMaterialesUnicamenteDeProveedoresCABA AS (
	SELECT pp.CodMat
	FROM ProvistoPor AS pp
	EXCEPT
	SELECT DISTINCT pp.CodMat
	FROM Proveedor AS p JOIN ProvistoPor AS pp ON p.CodProv = pp.CodProv
	WHERE p.Ciudad != 'CABA'
)

GO

SELECT pp.CodProv
FROM vMaterialesUnicamenteDeProveedoresCABA AS v JOIN ProvistoPor AS pp ON v.CodMat = pp.CodMat

-- Prueba:

INSERT INTO Material VALUES (15, 'Pepino');
INSERT INTO ProvistoPor VALUES (15,1);

DELETE FROM Material WHERE CodMat = 15;
DELETE FROM ProvistoPor WHERE CodMat = 15;

-- 17. Listar el/los articulo/s de mayor precio.
SELECT *
FROM Articulo AS a
WHERE a.Precio = (SELECT MAX(a.Precio) AS [Mayor precio]
				  FROM Articulo AS a)

-- Otra forma

SELECT a.CodArt
FROM Articulo AS a
WHERE a.Precio >= ALL (SELECT a.Precio
					   FROM Articulo AS a) 

-- 18. Listar el/los articulo/s de menor precio.
SELECT *
FROM Articulo AS a
WHERE a.Precio = (SELECT MIN(a.Precio) AS [Menor precio]
				  FROM Articulo AS a)

-- Como en AR (Algebra Relacional)
-- Con lo que esta dentro del NOT IN, tengo los codigo de articulos que no son menores.
SELECT a.*
FROM Articulo AS a
WHERE a.CodArt NOT IN (SELECT DISTINCT a1.CodArt
					   FROM Articulo AS a1, Articulo AS a2
					   WHERE a1.Precio > a2.Precio)

-- Usando ALL (Puedo ser reemplazado por ANY)
SELECT a.*
FROM Articulo AS a
WHERE a.Precio <= ALL (SELECT a.Precio		
						FROM Articulo AS a) 

-- 19. Listar el promedio de precios de los articulos en cada almacen.

SELECT t.NroAlmacen, AVG(a.Precio) AS [Promedio de precios de los articulos que almacena]
FROM Articulo AS a JOIN Tiene AS t ON t.CodArt = a.CodArt
GROUP BY t.NroAlmacen

-- Si quiero listar tambien los almacenes que no poseen articulos

SELECT al.Nro, ISNULL(AVG(ar.Precio),0) AS Promedio
FROM Almacen AS al LEFT JOIN Tiene AS t ON al.Nro = t.NroAlmacen 
				   LEFT JOIN Articulo AS ar ON ar.CodArt = t.CodArt
GROUP BY al.Nro

-- 20. Listar los almacenes que almacenan la mayor cantidad de articulos. 

GO

CREATE OR ALTER VIEW vAlmacenesConSuCantidadDeArticulos AS (
	SELECT t.NroAlmacen, COUNT(t.CodArt) [Cantidad de articulos]
	FROM Articulo AS a JOIN Tiene AS t ON t.CodArt = a.CodArt
	GROUP BY t.NroAlmacen
)

GO

SELECT v.NroAlmacen
FROM vAlmacenesConSuCantidadDeArticulos AS v
WHERE v.[Cantidad de articulos] = (SELECT MAX(v.[Cantidad de articulos]) AS [Mayor cantidad de articulos almacenados]
									FROM vAlmacenesConSuCantidadDeArticulos AS v)

-- Otra forma

SELECT t.NroAlmacen
FROM Tiene AS t
GROUP BY t.NroAlmacen
HAVING COUNT(T.NroAlmacen) >= ALL (SELECT COUNT (t.CodArt)
								   FROM Tiene AS t
								   GROUP BY t.NroAlmacen)

-- 21. Listar los articulos compuestos por al menos 2 materiales. 

-- Forma 1:
SELECT cp.CodArt, COUNT(cp.CodMat) [Cantidad de materiales compuestos]
FROM CompuestoPor AS cp
GROUP BY cp.CodArt
HAVING COUNT(cp.CodMat) >= 2

-- Forma 2:
SELECT DISTINCT cp.CodArt
FROM CompuestoPor cp, CompuestoPor cpp
WHERE cp.CodArt = cpp.CodArt AND cp.CodMat <> cpp.CodMat
	-- Producto cartesiano			-- Distintos

-- Forma 3: El WHERE lo reemplazo con un INNER JOIN
SELECT DISTINCT cp.CodArt
FROM CompuestoPor cp INNER JOIN CompuestoPor cpp ON (cp.CodArt = cpp.CodArt AND cp.CodMat <> cpp.CodMat)

-- 22. Listar los articulos compuestos por exactamente 2 materiales. 

SELECT cp.CodArt --, COUNT(cp.CodMat) [Cantidad de materiales compuestos]
FROM CompuestoPor AS cp
GROUP BY cp.CodArt
HAVING COUNT(cp.CodMat) = 2

-- 23. Listar los articulos que estan compuestos con hasta 2 materiales. 

SELECT cp.CodArt--, COUNT(cp.CodMat) [Cantidad de materiales compuestos]
FROM CompuestoPor AS cp
GROUP BY cp.CodArt
HAVING COUNT(cp.CodMat) < 2

-- 24. Listar los articulos compuestos por todos los materiales. 

SELECT *
FROM Articulo AS a
WHERE NOT EXISTS (SELECT 1
				  FROM Material AS m
				  WHERE NOT EXISTS (SELECT 1
									FROM CompuestoPor AS cp
									WHERE cp.CodArt = a.CodArt AND cp.CodMat = m.CodMat)
				 )

-- Prueba:

INSERT INTO CompuestoPor VALUES 
(4, 2), (4, 3), (4, 4), (4, 5), (4, 9), (4, 10), (4, 11), (4, 12), (4, 13), (4, 14)

DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 2
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 3
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 4
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 5
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 9
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 10
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 11
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 12
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 13
DELETE FROM CompuestoPor WHERE CodArt= 4 AND CodMat = 14

-- 25. Listar las ciudades donde existan proveedores que provean todos los materiales. 

SELECT p.Ciudad
FROM Proveedor AS p
WHERE NOT EXISTS (SELECT 1
				  FROM Material AS m
				  WHERE NOT EXISTS (SELECT 1
									FROM ProvistoPor AS pp
									WHERE pp.CodMat = m.CodMat AND pp.CodProv = p.CodProv)
				 )

-- Usando COCIENTE como en AR (Algebra Relacional)
SELECT p.Ciudad
FROM Proveedor AS p													-- Segunda resta
WHERE p.CodProv NOT IN (SELECT DISTINCT a.CodProv					-- Proyeccion de los proveedores que no cumplen la condicion			
						FROM (SELECT DISTINCT p.CodProv,m.CodMat	-- Aquellos proveedores que no cumplen con ser los que proveen todos los materiales
							  FROM Proveedor AS p, Material AS m	-- Producto cartesiano = todos los proveedores proveyendo todos los materiales (No existe)
							  EXCEPT								-- Le resta la realidad
							  SELECT pp.CodProv,pp.CodMat			-- Proveedores que proveen materiales (Realidad)
							  FROM ProvistoPor AS pp) AS a
					   )

--------------------------------------------------------- ADICIONALES ---------------------------------------------------------

-- 1. Listar los proveedores que fueron dados de alta en la decada de 90

-- Usando LIKE

SELECT p.*
FROM Proveedor AS p
WHERE p.FechaAlta LIKE '199_-%'

-- Usando BETWEEN

SELECT *
FROM Proveedor AS p
WHERE p.FechaAlta BETWEEN '01-01-1990' AND '31-12-1999'
-- WHERE p.FechaAlta BETWEEN '1990-01-01' AND '1999-12-31'
-- WHERE p.FechaAlta BETWEEN CONVERT(DATE,'01-01-1990',105) AND CONVERT(DATE,'31-12-1999',105)

/*La funcion CONVERT es una funcion que castea el dato a un tipo de dato valido para SQL
Date es el tipo de dato al que quiero castear.
El segundo parametro es como viene la cadena.
105 es el formato que usa Microsoft, el formato 105 es el formato aaaa-mm-dd*/

SELECT FORMAT(GETDATE(),'dd-mm-yyyy') AS Hoy	-- La funcion FORMAT modifica el formato al cual se va a modificar esa funcion

-- 2. Listar el/los proveedores dados de alta en la fecha mas reciente.

SELECT *
FROM Proveedor AS p
WHERE p.FechaAlta = (SELECT MAX(p.FechaAlta) AS [Fecha mas reciente]
					FROM Proveedor AS p)

-- 3. Listar los articulos cuyo precio supera la media (promedio). 

SELECT *
FROM Articulo AS a
WHERE a.Precio > (SELECT AVG(a.Precio) AS Media
					FROM Articulo AS a)

-- 4. Listar todos los codigos de articulos, descripcion y los codigos de materiales por los que estan compuestos, informando [9999] en el codigo [material] para el caso de los articulos que no estan compuestos por ningun material 

SELECT a.CodArt, a.Descripcion, ISNULL(cp.CodMat, 9999) AS CodMat
FROM Articulo AS a LEFT JOIN CompuestoPor AS cp ON a.CodArt = cp.CodArt

-- 5. Listar todos los articulos y materiales por los cuales estan compuestos. Mostrar articulos sin materiales y Materiales que no componen ningun articulo

SELECT *
FROM Articulo AS a LEFT JOIN CompuestoPor AS cp ON a.CodArt = cp.CodArt 
				   FULL JOIN Material AS m ON cp.CodMat = m.CodMat

-- Usando dos FULL OUTER
SELECT a.CodArt, a.Descripcion, m.CodMat AS MaterialCompuesto, m.Descripcion
FROM Articulo AS a FULL OUTER JOIN CompuestoPor AS cp ON a.CodArt = cp.CodArt
				   FULL OUTER JOIN Material AS m ON m.CodMat = cp.CodMat

/*FULL OUTER JOIN aparecen aquellos casos donde Articulo vinculado con Compuesto_Por son nulos y porque son articulos que no aparecen
Y por otro lado los materiales que no aparecen en Compuesto_Por
En ese vinculo que se da entre las tablas de Articulo y Material a traves de la tabla Compuesto_Por usando FULL OUTER consigo mostrar todos
los arituclos con los materiales por los que estan compuestos, listo tambien articulos que no estan compuestos por ningun material, y a su vez
listo aquellos materiales que no forman parte de ningun articulo
*/