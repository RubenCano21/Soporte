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



