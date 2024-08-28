CREATE DATABASE Aeropuerto;
GO

USE Aeropuerto;
GO
-- Tabla para country 
CREATE TABLE Country
(
    id_country INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Tabla para city

CREATE TABLE City
(
    id_city INT IDENTITY(1,1) PRIMARY KEY,
    id_country INT NOT NULL,
    name VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_country) REFERENCES Country(id_country)
);

-- Tabla para Airport
CREATE TABLE Airport (
    AirportID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100)			-- nombre del aeropuerto
);
-- Tabla para City_Airport 

CREATE TABLE City_Airport
(
    id_city INT,
    id_airport INT,
    PRIMARY KEY (id_city, id_airport),
    FOREIGN KEY (id_city) REFERENCES City(id_city),
    FOREIGN KEY (id_airport) REFERENCES Airport(AirportID)
);
-- Tabla para Document 

CREATE TABLE Document
(
    id_document INT IDENTITY PRIMARY KEY,
    description VARCHAR(50) NOT NULL
);
-- Tabla para Frequent Flyer Card
CREATE TABLE FrequentFlyerCard (
    FFCNumber INT PRIMARY KEY, --Numero de tarjeta del viajero 
    Miles INT,                 -- Millas acumuladas 
    MealCode VARCHAR(50)       --Codigo del tipo de comida preferida por el cliente.
);

-- Tabla para Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),			--nombre del cliente 
    DateOfBirth DATE,           --fecha de nacimiento
    FFCNumber INT NULL FOREIGN KEY REFERENCES FrequentFlyerCard(FFCNumber), -- numero de tarjeta de viajero frecuente 
    id_document INT FOREIGN KEY (id_document) REFERENCES Document(id_document)
);


-- Tabla para Flight Number

CREATE TABLE FlightNumber (
    FlightNumberID INT PRIMARY KEY IDENTITY(1,1),
    DepartureTime TIME,					-- hora de salida del vuelo
    Description VARCHAR(255),			-- descripcion 
    Type VARCHAR(50),					-- tipo de vuelo (nacional, internacional)
    Airline VARCHAR(50),				-- nombre de la aerolinia que opera ejemplo (boa)
    StartAirportID INT FOREIGN KEY REFERENCES Airport(AirportID),	--identificador del origen 
    GoalAirportID INT FOREIGN KEY REFERENCES Airport(AirportID)		--identificador del destino 
);

-- Tabla para Airplane
CREATE TABLE Airplane (
    RegistrationNumber VARCHAR(50) PRIMARY KEY,
    BeginOfOperation DATE,		-- Fecha en la que el avión comenzó a operar
    Status VARCHAR(50)			--Estado operativo del avión (activo, en mantenimiento, retirado, etc)
);

-- Tabla para Plane Model
CREATE TABLE PlaneModel (
    PlaneModelID INT PRIMARY KEY IDENTITY(1,1),
    Description VARCHAR(100),		-- Descripción del modelo del avión
    Graphic VARBINARY(MAX) NULL,	--
    RegistrationNumber VARCHAR(50) FOREIGN KEY REFERENCES Airplane(RegistrationNumber)--Número de registro del avión asociado
);

-- Tabla para Seat
CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY(1,1),
    Size VARCHAR(50),		--Tamaño del asiento.
    Number INT,				--Numero del asiento.
    Location VARCHAR(50),	--Ubicacion del asiento
    PlaneModelID INT FOREIGN KEY REFERENCES PlaneModel(PlaneModelID) --Identificador del modelo del avión 
);

-- Tabla para Flight
CREATE TABLE Flight (
    FlightID INT PRIMARY KEY IDENTITY(1,1),
    BoardingTime TIME,	--Hora de abordaje del vuelo
    FlightDate DATE,	--Fecha del vuelo.
    Gate VARCHAR(50),	--Puerta de embarque asignada para el vuelo.
    CheckInCounter VARCHAR(50), -- facturación asignado para el vuelo.
    FlightNumberID INT FOREIGN KEY REFERENCES FlightNumber(FlightNumberID)--Identificador del número de vuelo
);

-- Tabla para Available Seat
CREATE TABLE AvailableSeat (
    AvailableSeatID INT PRIMARY KEY IDENTITY(1,1),
    FlightID INT FOREIGN KEY REFERENCES Flight(FlightID), --Identificador del vuelo al que pertenece este asiento disponible
    SeatID INT FOREIGN KEY REFERENCES Seat(SeatID)		  --Identificador del asiento disponible
);

-- Tabla para Ticket
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    TicketingCode VARCHAR(50),	--Código de ticket usado para identificar el boleto
    Number INT,					--Número del ticket.
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID) --identificador del cliente
);

-- Tabla para Coupon
CREATE TABLE Coupon (
    CouponID INT PRIMARY KEY IDENTITY(1,1),
    DateOfRedemption DATE,  -- Fecha de redención del cupón.
    Class VARCHAR(50),		-- Clase de servicio a la que aplica el cupón (económica, business, primera clase).	
    Standby BIT,			-- Indica si el cupón es para un asiento en standby
    MealCode VARCHAR(50),   -- Codigo de comida 
    TicketID INT FOREIGN KEY REFERENCES Ticket(TicketID), --Identificador del ticket
	FlightID INT FOREIGN KEY REFERENCES Flight(FlightID),
	AvailableSeatID INT FOREIGN KEY REFERENCES AvailableSeat(AvailableSeatID)
);

-- Tabla para Pieces of Luggage
CREATE TABLE PiecesOfLuggage (
    LuggageID INT PRIMARY KEY IDENTITY(1,1),
    Number INT,           --Número de piezas de equipaje.
    Weight DECIMAL(5, 2), --Peso total del equipaje en kilogramos.
    CouponID INT NUll FOREIGN KEY REFERENCES Coupon(CouponID)
);

INSERT INTO Country (name) 
VALUES 
('Argentina'),
('Bolivia'),
('Brazil'),
('Chile'),
('Colombia'),
('Ecuador'),
('Paraguay'),
('Peru'),
('Uruguay'),
('Venezuela');

INSERT INTO City (id_country, name) 
VALUES 
(1, 'Buenos Aires'),
(2, 'La Paz'),
(3, 'São Paulo'),
(4, 'Santiago'),
(5, 'Bogotá'),
(6, 'Quito'),
(7, 'Asunción'),
(8, 'Lima'),
(9, 'Montevideo'),
(10, 'Caracas');

INSERT INTO Airport (Name) 
VALUES 
('Jorge Chávez International Airport'),
('São Paulo/Guarulhos–Governador André Franco Montoro International Airport'),
('El Alto International Airport'),
('Santiago International Airport'),
('Bogotá El Dorado International Airport'),
('Mariscal Sucre International Airport'),
('Asunción Silvio Pettirossi International Airport'),
('Carrasco International Airport'),
('Simón Bolívar International Airport'),
('Carmen de Bolívar Airport');


INSERT INTO City_Airport (id_city, id_airport) 
VALUES 
(1, 1),  -- Buenos Aires, Jorge Chávez International Airport
(2, 3),  -- La Paz, El Alto International Airport
(3, 2),  -- São Paulo, São Paulo/Guarulhos–Governador André Franco Montoro International Airport
(4, 4),  -- Santiago, Santiago International Airport
(5, 5),  -- Bogotá, Bogotá El Dorado International Airport
(6, 6),  -- Quito, Mariscal Sucre International Airport
(7, 7),  -- Asunción, Asunción Silvio Pettirossi International Airport
(8, 8),  -- Lima, Carrasco International Airport
(9, 9),  -- Montevideo, Simón Bolívar International Airport
(10, 10);-- Caracas, Carmen de Bolívar Airport


INSERT INTO Document (description) 
VALUES 
('CI'), -- cedula de indentidad
('Passport'), -- pasaporte
('Birth Certificate'), -- certificado de nacimiento
('Social Security Card');-- seguro social


INSERT INTO FrequentFlyerCard (FFCNumber, Miles, MealCode) 
VALUES 
(1001, 5000, 'Vegetarian'),
(1002, 12000, 'Vegan'),
(1003, 7500, 'Gluten-Free'),
(1004, 20000, 'Kosher'),
(1005, 3000, 'Halal'),
(1006, 15000, 'Paleo'),
(1007, 5000, 'Low-Carb'),
(1008, 18000, 'Mediterranean'),
(1009, 22000, 'Seafood'),
(1010, 7000, 'Standard');

-- Inserción de datos en la tabla Customer
INSERT INTO Customer (Name, DateOfBirth, FFCNumber, id_document) 
VALUES 
('John Doe', '1985-06-15', 1001, 1),
('Jane Smith', '1990-09-23', 1002, 2),
('Emily Johnson', '1978-12-05', NULL, 3),  -- Sin número de tarjeta de viajero frecuente
('Michael Brown', '1982-07-30', 1004, 4),
('Sarah Davis', '1995-03-18', NULL, 1),
('James Wilson', '1989-11-22', 1006, 2),
('Linda Miller', '1967-10-10', 1007, 1),
('Robert Moore', '1975-01-12', 1008, 2),
('Jessica Taylor', '1988-04-28', 1009, 3),
('Daniel Anderson', '2000-05-06', 1010, 4);

-- Inserción de datos en la tabla FlightNumber
INSERT INTO FlightNumber (DepartureTime, Description, Type, Airline, StartAirportID, GoalAirportID) 
VALUES 
('14:30:00', 'Flight from Buenos Aires to São Paulo', 'International', 'LATAM', 1, 3),
('09:00:00', 'Flight from Santiago to Buenos Aires', 'International', 'Avianca', 4, 1),
('18:45:00', 'Flight from Bogotá to Quito', 'International', 'Copa Airlines', 5, 6),
('12:00:00', 'Flight from Lima to Santiago', 'International', 'Sky Airline', 8, 4),
('07:15:00', 'Flight from Caracas to Montevideo', 'International', 'American Airlines', 10, 9),
('21:00:00', 'Flight from São Paulo to Lima', 'International', 'Gol', 3, 8),
('16:30:00', 'Flight from Montevideo to La Paz', 'International', 'Aerolineas Argentinas', 9, 2),
('11:00:00', 'Flight from Quito to Asunción', 'International', 'Azul', 6, 7),
('15:20:00', 'Flight from Asunción to Bogotá', 'International', 'TAM Airlines', 7, 5),
('22:10:00', 'Flight from Buenos Aires to Caracas', 'International', 'JetSmart', 1, 10);


-- Inserción de datos en la tabla Airplane
INSERT INTO Airplane (RegistrationNumber, BeginOfOperation, Status) 
VALUES 
('N12345', '2015-03-25', 'Active'),
('N67890', '2010-06-14', 'In Maintenance'),
('N11223', '2018-09-07', 'Active'),
('N44556', '2012-11-21', 'Retired'),
('N78901', '2020-01-30', 'Active'),
('N23456', '2016-07-19', 'Active'),
('N34567', '2019-04-10', 'In Maintenance'),
('N45678', '2014-12-05', 'Retired'),
('N56789', '2017-10-22', 'Active'),
('N67891', '2011-05-13', 'In Maintenance');


-- Inserción de datos en la tabla PlaneModel
-- Nota: Para el campo Graphic, si no se desea agregar un archivo binario, se puede usar NULL.

INSERT INTO PlaneModel (Description, Graphic, RegistrationNumber) 
VALUES 
('Boeing 737-800', NULL, 'N12345'),
('Airbus A320', NULL, 'N67890'),
('Boeing 787 Dreamliner', NULL, 'N11223'),
('Airbus A380', NULL, 'N44556'),
('Boeing 747-400', NULL, 'N78901'),
('Embraer E195', NULL, 'N23456'),
('Bombardier CRJ900', NULL, 'N34567'),
('Cessna 172', NULL, 'N45678'),
('Pilatus PC-12', NULL, 'N56789'),
('Dassault Falcon 7X', NULL, 'N67891');


-- Inserción de datos en la tabla Seat
INSERT INTO Seat (Size, Number, Location, PlaneModelID) 
VALUES 
('Economy', 1, 'Aisle', 1),      -- Asiento 1, clase económica, ubicado en el pasillo del modelo con PlaneModelID 1
('Economy', 2, 'Window', 1),     -- Asiento 2, clase económica, ubicado junto a la ventana del modelo con PlaneModelID 1
('Business', 1, 'Aisle', 2),      -- Asiento 1, clase business, ubicado en el pasillo del modelo con PlaneModelID 2
('Business', 2, 'Window', 2),     -- Asiento 2, clase business, ubicado junto a la ventana del modelo con PlaneModelID 2
('Economy', 3, 'Middle', 3),      -- Asiento 3, clase económica, ubicado en el medio del modelo con PlaneModelID 3
('Economy', 4, 'Aisle', 3),       -- Asiento 4, clase económica, ubicado en el pasillo del modelo con PlaneModelID 3
('Business', 3, 'Window', 4),     -- Asiento 3, clase business, ubicado junto a la ventana del modelo con PlaneModelID 4
('Economy', 5, 'Window', 5),      -- Asiento 5, clase económica, ubicado junto a la ventana del modelo con PlaneModelID 5
('First Class', 1, 'Window', 6),  -- Asiento 1, primera clase, ubicado junto a la ventana del modelo con PlaneModelID 6
('First Class', 2, 'Aisle', 6);   -- Asiento 2, primera clase, ubicado en el pasillo del modelo con PlaneModelID 6


-- Inserción de datos en la tabla Flight
INSERT INTO Flight (BoardingTime, FlightDate, Gate, CheckInCounter, FlightNumberID) 
VALUES 
('15:00:00', '2024-09-10', 'A1', 'Counter 1', 1),
('12:30:00', '2024-09-10', 'B3', 'Counter 2', 2),
('09:45:00', '2024-09-11', 'C2', 'Counter 3', 3),
('18:00:00', '2024-09-11', 'D5', 'Counter 4', 4),
('21:30:00', '2024-09-12', 'E6', 'Counter 5', 5),
('08:15:00', '2024-09-12', 'F4', 'Counter 6', 6),
('13:00:00', '2024-09-13', 'G7', 'Counter 7', 7),
('16:45:00', '2024-09-13', 'H8', 'Counter 8', 8),
('20:00:00', '2024-09-14', 'J9', 'Counter 9', 9),
('11:00:00', '2024-09-14', 'K10', 'Counter 10', 10);


-- Inserción de datos en la tabla AvailableSeat
INSERT INTO AvailableSeat (FlightID, SeatID) 
VALUES 
(1, 1),  -- Asiento 1 disponible para el vuelo 1
(1, 2),  -- Asiento 2 disponible para el vuelo 1
(2, 3),  -- Asiento 3 disponible para el vuelo 2
(2, 4),  -- Asiento 4 disponible para el vuelo 2
(3, 5),  -- Asiento 5 disponible para el vuelo 3
(3, 6),  -- Asiento 6 disponible para el vuelo 3
(4, 7),  -- Asiento 7 disponible para el vuelo 4
(4, 8),  -- Asiento 8 disponible para el vuelo 4
(5, 9),  -- Asiento 9 disponible para el vuelo 5
(5, 10); -- Asiento 10 disponible para el vuelo 5


-- Inserción de datos en la tabla Ticket
INSERT INTO Ticket (TicketingCode, Number, CustomerID) 
VALUES 
('TK001', 1001, 11),  -- Ticket con código TK001, número 1001, para el cliente con CustomerID 1
('TK002', 1002, 12),  -- Ticket con código TK002, número 1002, para el cliente con CustomerID 2
('TK003', 1003, 13),  -- Ticket con código TK003, número 1003, para el cliente con CustomerID 3
('TK004', 1004, 14),  -- Ticket con código TK004, número 1004, para el cliente con CustomerID 4
('TK005', 1005, 15),  -- Ticket con código TK005, número 1005, para el cliente con CustomerID 5
('TK006', 1006, 6),  -- Ticket con código TK006, número 1006, para el cliente con CustomerID 6
('TK007', 1007, 7),  -- Ticket con código TK007, número 1007, para el cliente con CustomerID 7
('TK008', 1008, 8),  -- Ticket con código TK008, número 1008, para el cliente con CustomerID 8
('TK009', 1009, 9),  -- Ticket con código TK009, número 1009, para el cliente con CustomerID 9
('TK010', 1010, 10); -- Ticket con código TK010, número 1010, para el cliente con CustomerID 10

INSERT INTO Coupon (DateOfRedemption, Class, Standby, MealCode, TicketID, FlightID, AvailableSeatID) 
VALUES 
('2024-09-01', 'Economy', 0, 'Veg', 11, 1, 1),
('2024-09-02', 'Business', 1, 'Non-Veg', 12, 2, 2),
('2024-09-03', 'First Class', 0, 'Vegan', 13, 3, 3),
('2024-09-04', 'Economy', 0, 'Gluten-Free', 4, 4, 4),
('2024-09-05', 'Business', 1, 'Halal', 5, 5, 5),
('2024-09-06', 'First Class', 0, 'Kosher', 6, 6, 6),
('2024-09-07', 'Economy', 0, 'Low-FODMAP', 7, 7, 7),
('2024-09-08', 'Business', 1, 'Organic', 8, 8, 8),
('2024-09-09', 'First Class', 0, 'Diabetic', 9, 9, 9),
('2024-09-10', 'Economy', 0, 'Paleo', 10, 10, 10);

-- Inserción de datos en la tabla PiecesOfLuggage
INSERT INTO PiecesOfLuggage (Number, Weight, CouponID) 
VALUES 
(1, 23.50, 11),  -- 1 pieza de equipaje con peso de 23.50 kg, asociado al cupón con CouponID 1
(2, 15.75, 2),  -- 2 piezas de equipaje con peso total de 15.75 kg, asociado al cupón con CouponID 2
(1, 30.00, 3),  -- 1 pieza de equipaje con peso de 30.00 kg, asociado al cupón con CouponID 3
(3, 40.25, 4),  -- 3 piezas de equipaje con peso total de 40.25 kg, asociado al cupón con CouponID 4
(2, 22.50, 5),  -- 2 piezas de equipaje con peso total de 22.50 kg, asociado al cupón con CouponID 5
(1, 18.00, 6),  -- 1 pieza de equipaje con peso de 18.00 kg, asociado al cupón con CouponID 6
(4, 35.75, 7),  -- 4 piezas de equipaje con peso total de 35.75 kg, asociado al cupón con CouponID 7
(1, 25.00, 8),  -- 1 pieza de equipaje con peso de 25.00 kg, asociado al cupón con CouponID 8
(2, 28.50, 9),  -- 2 piezas de equipaje con peso total de 28.50 kg, asociado al cupón con CouponID 9
(3, 33.00, 10); -- 3 piezas de equipaje con peso total de 33.00 kg, asociado al cupón con CouponID 10
