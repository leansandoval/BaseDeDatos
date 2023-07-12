/*Ejercicio 13: Dado el siguiente esquema de relaci�n
	Medicion	(Fecha, Hora, Metrica, Temperatura, Presion, Humedad, Nivel)
	Nivel		(Codigo, Descripcion)*/

USE Ejercicio_13
GO

/*2. f_ultimamedicion(Metrica): Realizar una funcion que devuelva la fecha y hora de la ultima medicion realizada 
en una metrica especifica, la cual sera enviada por parametro. 
La sintaxis de la funcion debera respetar lo siguiente:
	Fecha/hora = f_ultimamedicion(vMetrica char(5))
Ejemplificar el uso de la funcion.*/

GO

CREATE OR ALTER FUNCTION f_ultimamedicion (@vMetrica char(5)) RETURNS TABLE AS
	RETURN (SELECT MAX(m.Fecha) 'Ultima Fecha', MAX(m.Hora) 'Ultima hora' 
			FROM Medicion AS m WHERE m.Metrica = @vMetrica)

GO

SELECT *
FROM f_ultimamedicion('M1')

/*3. v_Listado: Realizar una vista que permita listar las metricas en las cuales se hayan realizado, en la ultima 
semana, mediciones para todos los niveles existentes. El resultado del listado debera mostrar, el nombre de la
metrica que respete la condicion enunciada, el maximo nivel de temperatura de la ultima semana y la cantidad de 
mediciones realizadas tambien en la ultima semana.*/

GO

CREATE VIEW v_Listado AS (
	SELECT m.Metrica, MAX(m.Temperatura) 'Tempeatura maxima', COUNT(*) 'Cantidad de mediciones'
	FROM Medicion AS m
	WHERE m.Fecha >= GETDATE() - 7
	GROUP BY m.Metrica
	HAVING COUNT(DISTINCT m.Nivel) = (SELECT COUNT(*) 'Cantidad total de niveles' FROM Nivel AS n)
)

GO

SELECT *
FROM v_Listado 

/*4. p_ListaAcumulados(finicio,ffin): Realizar un procedimiento que permita generar una tabla de acumulados 
diarios de temperatura por cada metrica y por cada dia. El procedimiento debera admitir como parametro el rango 
de fechas que mostrara el reporte. Ademas, estas fechas deben ser validadas. El informe se debera visualizar de 
la siguiente forma:
								Fecha		Metrica		Ac.DiarioTemp	Ac.Temp
								01/03/2009	M1			25				25
								02/03/2009	M1			20				45
								03/03/2009	M1			15				60
								01/03/2009	M2			15				15
								02/03/2009	M2			10				25
*/

GO

CREATE OR ALTER PROCEDURE p_ListaAcumulados (@FInicio DATE, @FFin DATE) AS
BEGIN
	SELECT m.Fecha, m.Metrica, COUNT(m.Temperatura) 'Ac. Diario Temp', SUM(m.Temperatura) 'Ac. Temp'
	FROM Medicion AS m
	WHERE m.Fecha >= @FInicio AND m.Fecha <= @FFin
	GROUP BY m.Fecha, m.Metrica
END

GO

EXECUTE p_ListaAcumulados '18-12-2020', '18-12-2021'

/*5. p_InsertMedicion (Fecha, Hora, Metrica, Temp, Presion, Hum, Niv): Realizar un procedimiento que permita agregar 
una nueva medicion en su respectiva entidad. Los parametros deberan ser validados segun:
	a. Para una nueva fecha hora, no puede haber mas de una medida por metrica
	b. El valor de humedad solo podra efectuarse entre 0 y 100.
	c. El campo nivel debera ser valido, segun su correspondiente entidad.*/

GO

CREATE OR ALTER PROCEDURE p_InsertMedicion (@Fecha DATE, @Hora TIME, @Metrica CHAR(2), @Temp INT, @Presion INT, @Hum INT, @Niv INT) AS
BEGIN
	DECLARE @FlagNivel INT = (SELECT 1 FROM Nivel AS n WHERE @Niv = n.Codigo)
	DECLARE @FlagFecha INT = (SELECT 1 FROM Medicion AS m WHERE @Fecha = m.Fecha AND @Metrica <> m.Metrica)
	IF (@FlagNivel = 1 AND @FlagFecha = 1 AND (@Hum >= 0 AND @Hum <= 100))
		INSERT INTO Medicion (Fecha, Hora, Metrica, Temperatura, Presion, Humedad, Nivel) VALUES (@Fecha, @Hora, @Metrica, @Temp, @Presion, @Hum, @Niv)
	ELSE
		RAISERROR ('No se pudo insertar la medicion ingresada',11,1);
END

GO

/*6. p_depuraMedicion(dias): Realizar un procedimiento que depure la tabla de mediciones, dejando solo las ultimas
mediciones. El resto de las mediciones, no deben ser borradas sino trasladadas a otra entidad que llamaremos 
Medicion_Hist. El proceso debera tener como parametro la cantidad de dias de retencion de las mediciones.*/

CREATE TABLE MedicionHistorica
(
	Fecha DATE,
	Hora TIME,
	Metrica CHAR(2),
	Temperatura INT,
	Presion INT,
	Humedad INT,
	Nivel INT,
	CONSTRAINT FK_MedicionHistorica PRIMARY KEY (Fecha,Hora,Metrica)
)

GO

CREATE OR ALTER PROCEDURE p_DepuraMedicion (@Dias INT) AS
BEGIN
	INSERT INTO MedicionHistorica SELECT * FROM Medicion AS m WHERE m.Fecha <= GETDATE() - @Dias
	DELETE FROM Medicion WHERE Fecha <= GETDATE() - @Dias
END

GO

EXECUTE p_DepuraMedicion 7

/*7. tg_descNivel: Realizar un trigger que coloque la descripcion en mayuscula cada vez que se inserte un nuevo 
nivel.*/

GO

CREATE OR ALTER TRIGGER tg_DescNivel ON Nivel INSTEAD OF INSERT AS
BEGIN
	DECLARE @Descripcion VARCHAR(15) = (SELECT UPPER(i.Descripcion) FROM Inserted AS i)
	DECLARE @Codigo INT = (SELECT i.Codigo FROM Inserted AS i)
	INSERT INTO Nivel (Codigo, Descripcion) VALUES (@Codigo, @Descripcion)
END

GO

INSERT INTO Nivel (Codigo, Descripcion) VALUES (6,'Eolico')