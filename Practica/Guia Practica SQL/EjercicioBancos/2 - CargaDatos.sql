USE EjercicioBancos;
GO

INSERT INTO Pais (Pais) VALUES ('Argentina');
INSERT INTO Pais (Pais) VALUES ('USA');
INSERT INTO Pais (Pais) VALUES ('Uruguay');
INSERT INTO Pais (Pais) VALUES ('Espania');
INSERT INTO Pais (Pais) VALUES ('Alemania');
INSERT INTO Pais (Pais) VALUES ('Suiza');

INSERT INTO Banco (Id, Nombre, Pais) VALUES ('1', 'Banco Nacion', 'Argentina');
INSERT INTO Banco (Id, Nombre, Pais) VALUES ('2', 'Banco Montevideo', 'Uruguay');
INSERT INTO Banco (Id, Nombre, Pais) VALUES ('3', 'Banco Ciudad', 'Argentina');
INSERT INTO Banco (Id, Nombre, Pais) VALUES ('4', 'City Bank', 'USA');
INSERT INTO Banco (Id, Nombre, Pais) VALUES ('5', 'Switzerland Bank', 'Suiza');
INSERT INTO Banco (Id, Nombre, Pais) VALUES ('6', 'BBVA', 'Espania');

INSERT INTO Moneda (Id, Descripcion, ValorOro, ValorPetroleo) VALUES ('AR', 'Peso Argentino','2', '1');
INSERT INTO Moneda (Id, Descripcion, ValorOro, ValorPetroleo) VALUES ('UY', 'Peso Uruguayo','5', '2.5');
INSERT INTO Moneda (Id, Descripcion, ValorOro, ValorPetroleo) VALUES ('US', 'Dolar', '1','1.5');
INSERT INTO Moneda (Id, Descripcion, ValorOro, ValorPetroleo) VALUES ('EU', 'Euro', '2', '1');

INSERT INTO Persona (Pasaporte, CodigoFiscal, Nombre) VALUES ('1', '1234', 'Bill Gates');
INSERT INTO Persona (Pasaporte, CodigoFiscal, Nombre) VALUES ('2', '12112', 'Carlos Slim');
INSERT INTO Persona (Pasaporte, CodigoFiscal, Nombre) VALUES ('3', '2325', 'Lionel Messi');
INSERT INTO Persona (Pasaporte, CodigoFiscal, Nombre) VALUES ('4', '01243', 'Diego Maradona');

INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('100000', '4', 'US', '1');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('20000', '5', 'EU', '1');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('15000', '2', 'US', '1');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('50000', '4', 'US', '2');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('35000', '5', 'US', '2');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('2000', '1', 'AR', '3');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('10000', '4', 'US', '3');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('15000', '5', 'US', '3');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('15000', '5', 'US', '4');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('2000', '2', 'AR', '3');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('10000', '3', 'US', '3');
INSERT INTO Cuenta (Monto, IdBanco, IdMoneda, IdPersona) VALUES ('15000', '6', 'US', '3');

INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('1', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('2', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('3', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('4', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('5', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('6', 'US', '1', '1');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('1', 'EU', '2', '2');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('2', 'EU', '2', '2');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('3', 'EU', '3', '3');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('4', 'EU', '2', '2');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('5', 'EU', '2.2','2.2');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('6', 'EU', '2.2','2.5');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('1', 'AR', '5', '5');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('3', 'AR', '5.5', '5.5');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('2', 'AR', '7', '7');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('1', 'UY', '3', '3');
INSERT INTO Opera (IdBanco, IdMoneda, CambioCompra, CambioVenta) VALUES ('2', 'UY', '2', '2');