-- CREATE SCHEMA travel;
DROP TABLE IF EXISTS travel.COUNTRY
DROP TABLE IF EXISTS travel.CITY
DROP TABLE IF EXISTS travel.ERA
DROP TABLE IF EXISTS travel.MONUMENT
DROP TABLE IF EXISTS travel.GUIDE
DROP TABLE IF EXISTS travel.TOURIST
DROP TABLE IF EXISTS travel.TARIFF
DROP TABLE IF EXISTS travel.TOUR_TYPE
DROP TABLE IF EXISTS travel.TOUR
DROP TABLE IF EXISTS travel.TOUR_INSTANCE
DROP TABLE IF EXISTS travel.VIRTUAL_TOUR
DROP TABLE IF EXISTS travel.PRESENTIAL_TOUR
DROP TABLE IF EXISTS travel.tour_includes_monument
DROP TABLE IF EXISTS travel.tourist_participates

CREATE TABLE travel.ERA (
	designation VARCHAR(64),
	start_year  INT,
	end_year	INT,
	PRIMARY KEY(designation),
)

CREATE TABLE travel.COUNTRY (
	code  VARCHAR(8), -- country code (ex: 351 for Portugal)
	name_ VARCHAR(64) UNIQUE NOT NULL, -- longest name: "The United Kingdom of Great Britain and Northern Ireland
	PRIMARY KEY(code),
)

CREATE TABLE travel.CITY (
	-- postal_code VARCHAR(16),
	id			 INT,
	latitude     DECIMAL(8, 6) UNIQUE,
	longitude    DECIMAL(8, 6) UNIQUE,
	name_		 VARCHAR(64)  NOT NULL, -- Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch?
	country_code VARCHAR(8) REFERENCES travel.COUNTRY(code),
	PRIMARY KEY(id),
)

CREATE TABLE travel.MONUMENT (
	id				INT,
	name_			VARCHAR(128),
	latitude		DECIMAL(8, 6),
	longitude		DECIMAL(8, 6),
	era_designation VARCHAR(64)	REFERENCES travel.ERA(designation),
	city_id			INT			REFERENCES travel.CITY(id),
	PRIMARY KEY(id),
)

CREATE TABLE travel.GUIDE (
	email		VARCHAR(128) UNIQUE,
	name_		VARCHAR(512),
	birth_date  DATE,
	id			INT,
	PRIMARY KEY(id),
)

CREATE TABLE travel.TOURIST (
	email	   VARCHAR(128),
	name_	   VARCHAR(512),
	birth_date DATE,
	PRIMARY KEY(email),
)

CREATE TABLE travel.TARIFF (
	id			 INT,
	price_spring MONEY,
	price_summer MONEY,
	price_autumn MONEY,
	price_winter MONEY,
	PRIMARY KEY(id),
)

CREATE TABLE travel.TOUR_TYPE (
	designation VARCHAR(16),
	PRIMARY KEY(designation)
)

CREATE TABLE travel.TOUR (
	id		  INT,
	name_	  VARCHAR(128),
	desc_	  VARCHAR(512),
	duration  INT, -- in minutes
	type_	  VARCHAR(16) REFERENCES travel.TOUR_TYPE(designation),
	tariff_id INT REFERENCES travel.TARIFF(id),
	PRIMARY KEY(id),
)

CREATE TABLE travel.VIRTUAL_TOUR (
	id			INT REFERENCES travel.TOUR(id),
	access_link VARCHAR(256),
	password_   VARCHAR(32),
	PRIMARY KEY(id)
)

CREATE TABLE travel.PRESENTIAL_TOUR (
	id			   INT REFERENCES travel.TOUR(id),
	start_location VARCHAR(512),
	end_location   VARCHAR(512),
	PRIMARY KEY(id),
)

CREATE TABLE travel.TOUR_INSTANCE (
	start_date_ DATETIME,
	id			INT REFERENCES travel.TOUR(id),
	guide_id	INT REFERENCES travel.GUIDE(id),
	PRIMARY KEY(id, start_date_),
)

CREATE TABLE travel.tour_includes_monument (
  monument_id     INT REFERENCES travel.MONUMENT(id),
  tour_id       INT REFERENCES travel.TOUR(id),
  PRIMARY KEY(monument_id, tour_id),
)

CREATE TABLE travel.tourist_participates (
  tourist_email VARCHAR(128) REFERENCES travel.TOURIST(email),
  tour_id      INT,
  start_date_    DATETIME,
  FOREIGN KEY (tour_id, start_date_) REFERENCES travel.TOUR_INSTANCE(id, start_date_),
  PRIMARY KEY(tour_id, start_date_, tourist_email),
)

INSERT INTO travel.COUNTRY VALUES ('+30', 'Greece')
INSERT INTO travel.COUNTRY VALUES ('+33', 'France')
INSERT INTO travel.COUNTRY VALUES ('+34', 'Spain')
INSERT INTO travel.COUNTRY VALUES ('+39', 'Italy')
INSERT INTO travel.COUNTRY VALUES ('+44', 'United Kingdom')
INSERT INTO travel.COUNTRY VALUES ('+351', 'Portugal')

INSERT INTO travel.CITY VALUES (0, 40.2033, -8.4103, 'Coimbra', '+351')
INSERT INTO travel.CITY VALUES (1, 38.7223, -9.1393, 'Lisbon', '+351')
INSERT INTO travel.CITY VALUES (2, 40.4168, -3.7038, 'Madrid', '+34')
INSERT INTO travel.CITY VALUES (3, 38.9394, -6.3652, 'Merida', '+34')
INSERT INTO travel.CITY VALUES (4, 41.9028, 12.4964, 'Rome', '+39')
INSERT INTO travel.CITY VALUES (5, 52.4068, -1.5197, 'Coventry', '+44')
INSERT INTO travel.CITY VALUES (6, 51.5074, -0.1278, 'London', '+44')
INSERT INTO travel.CITY VALUES (7, 37.9838, 23.7275, 'Athens', '+30')
INSERT INTO travel.CITY VALUES (8, 49.2432, -0.2783, 'Benouville', '+33')
INSERT INTO travel.CITY VALUES (9, 49.1829, -0.3707, 'Caen', '+33')
INSERT INTO travel.CITY VALUES (10, 49.3364, -0.6963, 'Longues-sur-Mer', '+33')
INSERT INTO travel.CITY VALUES (11, 43.7696, 11.2558, 'Florence', '+39')

INSERT INTO travel.ERA VALUES ('Roman Empire', -27, 476)
INSERT INTO travel.ERA VALUES ('Age of Discovery', 1419, 1612)
INSERT INTO travel.ERA VALUES ('Victorian Era', 1837, 1901)
INSERT INTO travel.ERA VALUES ('World War II', 1939, 1945)

INSERT INTO travel.MONUMENT VALUES(1,  'Roman Theatre',				38.9152,   -6.3385,  'Roman Empire',	 3)
INSERT INTO travel.MONUMENT VALUES(2,  'Casa Del Mitreo',			38.9111,   -6.3411,  'Roman Empire',	 3)
INSERT INTO travel.MONUMENT VALUES(3,  'Theatre of Dionysus',		37.9704,   23.7279,  'Roman Empire',	 7)
INSERT INTO travel.MONUMENT VALUES(4,  'Odeon of Herodes Atticus',	37.9708,   23.7246,  'Roman Empire',	 7)
INSERT INTO travel.MONUMENT VALUES(5,  'Tower Bridge',				51.5055,   -0.0754,  'Victorian Era',	 6)
INSERT INTO travel.MONUMENT VALUES(6,  'Big Ben',					51.5007,   -0.1246,  'Victorian Era',	 6)
INSERT INTO travel.MONUMENT VALUES(7,  'Coventry Cathedral',		52.4086,   -1.5071,  'World War II',	 5)
INSERT INTO travel.MONUMENT VALUES(8,  'War Memorial Park',			52.3920,   -1.5225,  'World War II',	 5)
INSERT INTO travel.MONUMENT VALUES(9,  'Colosseum',					41.8902,   12.4922,  'Roman Empire',	 4)
INSERT INTO travel.MONUMENT VALUES(10, 'Pantheon',					41.8986,   12.4769,  'Roman Empire',	 4)
INSERT INTO travel.MONUMENT VALUES(11, 'Colonna dell''Abbondanza',  43.7716,   11.2543,  'Roman Empire',	 11)
INSERT INTO travel.MONUMENT VALUES(12, 'Walls of Florence',			43.7632,   11.2595,  'Roman Empire',	 11)
INSERT INTO travel.MONUMENT VALUES(13, 'Padrao dos Descobrimentos', 38.6936,   9.2057,	 'Age of Discovery', 1)
INSERT INTO travel.MONUMENT VALUES(14, 'Mosteiro dos Jeronimos',	38.69778, -9.20611,  'Age of Discovery', 1)
INSERT INTO travel.MONUMENT VALUES(15, 'Pegasus Bridge',            49.24222,  -0.27444, 'World War II',     9)
INSERT INTO travel.MONUMENT VALUES(16, 'Memorial de Caen',          49.197322, 0.383985, 'World War II',	 9)
INSERT INTO travel.MONUMENT VALUES(17, 'Longues-sur-Mer battery',   49.3433,   -0.6948,  'World War II',	 10)

INSERT INTO travel.TOURIST VALUES ('andrealves@bd.com', 'Andre Alves', '2000-04-22')
INSERT INTO travel.TOURIST VALUES ('beatrizbarros@bd.com', 'Beatriz Barros', '1995-05-05')
INSERT INTO travel.TOURIST VALUES ('catarinacruz@bd.com', 'Catarina Cruz', '1951-02-14')
INSERT INTO travel.TOURIST VALUES ('diogodias@bd.com', 'Diogo Dias', '2008-08-08')
INSERT INTO travel.TOURIST VALUES ('edgaresteves@bd.com', 'Edgar Esteves', '2012-10-20')

INSERT INTO travel.GUIDE VALUES ('fernandoferreira@bd.com', 'Fernando Ferreira', '1986-03-03', 0)
INSERT INTO travel.GUIDE VALUES ('guilhermegaspar@bd.com', 'Guilherme Gaspar', '1982-07-29', 1)

INSERT INTO travel.TARIFF VALUES (0, 900, 1000, 900, 800)
INSERT INTO travel.TARIFF VALUES (1, 800, 900, 800, 700)
INSERT INTO travel.TARIFF VALUES (2, 800, 800, 800, 800)
INSERT INTO travel.TARIFF VALUES (3, 250, 300, 240, 200)
INSERT INTO travel.TARIFF VALUES (-1, 100, 100, 100, 100)

INSERT INTO travel.TOUR_TYPE VALUES ('location')
INSERT INTO travel.TOUR_TYPE VALUES ('time')
INSERT INTO travel.TOUR_TYPE VALUES ('both')

INSERT INTO travel.TOUR VALUES (
	0,
	'France World War II landmarks',
	'World War II landmarks in France''s Normandy region',
	'200',
	'both',
	3
)

INSERT INTO travel.PRESENTIAL_TOUR VALUES (
	0,
	'5MG3+H7 Caen, France',
	'89QF+5X Arromanches-les-Bains, France'
)

INSERT INTO travel.tour_includes_monument VALUES (15, 0)
INSERT INTO travel.tour_includes_monument VALUES (16, 0)
INSERT INTO travel.tour_includes_monument VALUES (17, 0)

INSERT INTO travel.TOUR VALUES (
	-1,
	'Roman Empire webtour',
	'Roman Empire landmarks from multiple countries',
	'300',
	'time',
	-1
)

INSERT INTO travel.VIRTUAL_TOUR VALUES (
	-1,
	'https://meet.jit.si/RomanEmpireWebtourBD',
	'YFR7GSQ823JR7'
)

INSERT INTO travel.tour_includes_monument VALUES (1, -1)
INSERT INTO travel.tour_includes_monument VALUES (2, -1)
INSERT INTO travel.tour_includes_monument VALUES (3, -1)
INSERT INTO travel.tour_includes_monument VALUES (4, -1)
INSERT INTO travel.tour_includes_monument VALUES (9, -1)
INSERT INTO travel.tour_includes_monument VALUES (10, -1)
INSERT INTO travel.tour_includes_monument VALUES (11, -1)
INSERT INTO travel.tour_includes_monument VALUES (12, -1)

INSERT INTO travel.TOUR_INSTANCE VALUES('2021-10-22',  0, 0)
INSERT INTO travel.TOUR_INSTANCE VALUES('2022-11-30',  0, 1)
INSERT INTO travel.TOUR_INSTANCE VALUES('2019-02-10', -1, 1)
INSERT INTO travel.TOUR_INSTANCE VALUES('2020-12-04', -1, 0)
INSERT INTO travel.TOUR_INSTANCE VALUES('2023-11-27', -1, 0)


INSERT INTO travel.tourist_participates VALUES ('andrealves@bd.com',    0,  '2021-10-22')
INSERT INTO travel.tourist_participates VALUES ('catarinacruz@bd.com',  0,  '2022-11-30')
INSERT INTO travel.tourist_participates VALUES ('beatrizbarros@bd.com', -1, '2019-02-10')
INSERT INTO travel.tourist_participates VALUES ('catarinacruz@bd.com',  -1, '2019-02-10')
INSERT INTO travel.tourist_participates VALUES ('diogodias@bd.com',     -1, '2020-12-04')

SELECT * FROM travel.monument


-- QUERIES

-- Get coutry names
go
CREATE PROCEDURE travel.CountryList
AS
	SELECT name_ 
	FROM travel.COUNTRY;
go

EXEC travel.CountryList;

-- Get designation of eras
go
CREATE PROCEDURE travel.EraList
AS
	SELECT designation 
	FROM travel.ERA;
go

EXEC travel.EraList;


-- Get type of tour with input of an id by user
go
CREATE PROCEDURE travel.GetTypeOfTour @requested_tour INT
AS
	SELECT type_
	FROM travel.TOUR
	WHERE id = @requested_tour;
go

EXEC travel.GetTypeOfTour @requested_tour = 0;


-- Get duration of tour in hours
CREATE FUNCTION travel.GetDurationInHours (@requested_tour INT) RETURNS INT
AS
BEGIN
	DECLARE @hours INT
	SELECT @hours = duration/60
	FROM travel.TOUR
	WHERE id = @requested_tour;
	RETURN @hours;
END;

GO
SELECT travel.GetDurationInHours (-1)DROP FUNCTION travel.GetDurationInHours
-- Get monuments close to a certain location
go
CREATE PROCEDURE travel.CloseMonuments @lat DECIMAL(8, 6), @lon DECIMAL(8, 6), @max_distance INT
AS
	DECLARE @origin geography = geography::Point(@lat, @lon, 4326);
	SELECT *, ROUND(@origin.STDistance(geography::Point(latitude, longitude, 4326))/1000,3) AS distance
	FROM travel.MONUMENT
	WHERE @origin.STDistance(geography::Point(latitude, longitude, 4326)) <= @max_distance
	ORDER BY distance; 
go

DROP PROCEDURE IF EXISTS travel.CloseMonuments

EXEC travel.CloseMonuments 38.9152,-6.3385, 9999999


-- Order tours by price in a certain season
go
CREATE PROCEDURE travel.TourPricesInSeason @season CHAR(6), @max_price MONEY, @min_price MONEY
AS
	IF (@season = 'spring')
	BEGIN
		SELECT *
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		WHERE @min_price <= price_spring AND price_spring <= @max_price
		ORDER BY price_spring;
	END
	ELSE IF (@season = 'summer')
	BEGIN
		SELECT *
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		WHERE @min_price <= price_summer AND price_summer <= @max_price
		ORDER BY price_summer;
	END
	ELSE IF (@season = 'autumn')
	BEGIN
		SELECT *
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		WHERE @min_price <= price_autumn AND price_autumn <= @max_price
		ORDER BY price_autumn;
	END
	ELSE IF (@season = 'winter')
	BEGIN
		SELECT *
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		WHERE @min_price <= price_winter AND price_winter <= @max_price
		ORDER BY price_winter;
	END
go
DROP PROCEDURE IF EXISTS travel.TourPricesInSeason


EXEC travel.TourPricesInSeason 'summer', 300, 0


-- Preço de uma tour para um determinado tourist com desconto até aos 12 anos
go
CREATE PROCEDURE travel.TouristTourCost @tour_id INT, @season CHAR(6), @tourist_email  VARCHAR(128)
AS
	IF (@season = 'spring')
	BEGIN
		SELECT travel.tourist_participates.tour_id, travel.TOUR.name_, desc_, duration, type_, tariff_id, price_spring/travel.Discount(travel.GetAge(start_date_, birth_date)) AS price_summer, tourist_email, start_date_, travel.GetAge(start_date_, birth_date) AS tourist_age
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		JOIN travel.tourist_participates ON travel.TOUR.id  = travel.tourist_participates.tour_id
		JOIN travel.TOURIST ON travel.tourist_participates.tourist_email = travel.TOURIST.email
		WHERE @tourist_email = tourist_email AND @tour_id = tour_id
	END
	ELSE IF (@season = 'summer')
	BEGIN
		SELECT travel.tourist_participates.tour_id, travel.TOUR.name_, desc_, duration, type_, tariff_id, price_summer/travel.Discount(travel.GetAge(start_date_, birth_date)) AS price_summer, tourist_email, start_date_, travel.GetAge(start_date_, birth_date) AS tourist_age
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		JOIN travel.tourist_participates ON travel.TOUR.id  = travel.tourist_participates.tour_id
		JOIN travel.TOURIST ON travel.tourist_participates.tourist_email = travel.TOURIST.email
		WHERE @tourist_email = tourist_email AND @tour_id = tour_id
	END
	ELSE IF (@season = 'autumn')
	BEGIN
		SELECT travel.tourist_participates.tour_id, travel.TOUR.name_, desc_, duration, type_, tariff_id, price_autumn/travel.Discount(travel.GetAge(start_date_, birth_date)) AS price_summer, tourist_email, start_date_, travel.GetAge(start_date_, birth_date) AS tourist_age
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		JOIN travel.tourist_participates ON travel.TOUR.id  = travel.tourist_participates.tour_id
		JOIN travel.TOURIST ON travel.tourist_participates.tourist_email = travel.TOURIST.email
		WHERE @tourist_email = tourist_email AND @tour_id = tour_id
	END
	ELSE IF (@season = 'winter')
	BEGIN
		SELECT travel.tourist_participates.tour_id, travel.TOUR.name_, desc_, duration, type_, tariff_id, price_winter/travel.Discount(travel.GetAge(start_date_, birth_date)) AS price_summer, tourist_email, start_date_, travel.GetAge(start_date_, birth_date) AS tourist_age
		FROM travel.TOUR JOIN travel.TARIFF ON travel.TOUR.tariff_id = travel.TARIFF.id
		JOIN travel.tourist_participates ON travel.TOUR.id  = travel.tourist_participates.tour_id
		JOIN travel.TOURIST ON travel.tourist_participates.tourist_email = travel.TOURIST.email
		WHERE @tourist_email = tourist_email AND @tour_id = tour_id
	END
go

DROP PROCEDURE IF EXISTS travel.TouristTourCost

EXEC travel.TouristTourCost 0,'summer','andrealves@bd.com'


-- Get discount value
CREATE FUNCTION travel.Discount (@age INT) RETURNS INT
AS
BEGIN
	DECLARE @discount INT;
	IF (@age <= 12)
	BEGIN
		SET @discount = 2;
	END
	ELSE 
	BEGIN
		SET @discount = 1;
	END
	RETURN @discount
END;

GO
SELECT travel.Discount (-12)DROP FUNCTION travel.Discount


-- Get tours that contain a given monument
go
CREATE PROCEDURE travel.MonumentTours @monument_id INT
AS
	SELECT TOUR.*
	FROM travel.MONUMENT JOIN travel.tour_includes_monument ON travel.MONUMENT.id = travel.tour_includes_monument.monument_id
	JOIN travel.TOUR ON travel.tour_includes_monument.tour_id = travel.TOUR.id
	WHERE travel.MONUMENT.id = @monument_id
go

DROP PROCEDURE travel.MonumentTours

EXEC travel.MonumentTours 10


-- Tabela com: Tour, numero de instancias, lucro total, lucro médio (instancias), lucro médito (participantes),  nº médio de participantes 

-- Função de 50% de desconto para crianças


--  Get number of instances of a tour
CREATE FUNCTION travel.GetNumberInstances (@requested_tour INT) RETURNS INT
AS
BEGIN
	DECLARE @number_instances INT
	SELECT	@number_instances = COUNT(*)
	FROM travel.TOUR JOIN travel.TOUR_INSTANCE ON travel.TOUR.id = travel.TOUR_INSTANCE.id
	WHERE travel.TOUR.id = @requested_tour
	RETURN @number_instances
END;

GO
SELECT travel.GetNumberInstances (-1)DROP FUNCTION travel.GetNumberInstances-- Get season of tour instanceCREATE FUNCTION travel.GetSeason (@tour_instance_date DATETIME) RETURNS CHAR(6)
AS
BEGIN
	DECLARE @season CHAR(9)
	DECLARE @tour_dayofyear INT = DATENAME(y, @tour_instance_date)
	 
	DECLARE @winter_begin INT = DATENAME(y, '2021-12-21')
	DECLARE @winter_end INT = DATENAME(y, '2022-03-19')
	DECLARE @spring_begin INT = DATENAME(y, '2021-03-20') 
	DECLARE @spring_end INT = DATENAME(y, '2021-06-20')
	DECLARE @summer_begin INT = DATENAME(y, '2021-06-21')
	DECLARE @summer_end INT = DATENAME(y, '2021-09-21')
	DECLARE @autumn_begin INT = DATENAME(y, '2021-09-22')
	DECLARE @autumn_end INT = DATENAME(y, '2021-12-20')

	IF (@tour_dayofyear >= @winter_begin OR (@tour_dayofyear > 0 AND @tour_dayofyear <= @winter_end ))
	BEGIN 
		SET @season = 'winter'
	END	
	ELSE IF (@tour_dayofyear >= @spring_begin AND @tour_dayofyear <= @spring_end)
	BEGIN 
		SET @season = 'spring'
	END
	ELSE IF (@tour_dayofyear >= @summer_begin AND @tour_dayofyear <= @summer_end)
	BEGIN 
		SET @season = 'summer'
	END
	ELSE IF (@tour_dayofyear >= @autumn_begin AND @tour_dayofyear <= @autumn_end)
	BEGIN 
		SET @season = 'autumn'
	END
	RETURN @season
END;

GO
SELECT travel.GetSeason ('2019-02-10')DROP FUNCTION travel.GetSeason-- Get age of tourist on the start date of a tour instanceCREATE FUNCTION travel.GetAge (@tour_instance_date DATETIME, @tourist_birthday DATETIME) RETURNS INTASBEGIN	DECLARE @age INT	SET @age = DATEDIFF(year, @tourist_birthday, @tour_instance_date)	RETURN @ageEND;GO
SELECT travel.GetAge ('2019-02-10', '1951-02-14')DROP FUNCTION travel.GetAge-- Used on procedure - TouristTourOptions - to see tours in which the tourists don't participateCREATE VIEW travel.TouristNotParticipatingTourAS	SELECT travel.TOURIST.email AS tourist_email, travel.TOUR.id AS tour_id FROM travel.TOUR CROSS JOIN  travel.TOURIST	EXCEPT	SELECT travel.tourist_participates.tourist_email, travel.tourist_participates.tour_id FROM travel.tourist_participatesDROP VIEW travel.TouristNotParticipatingTour-- Get tours a tourist isn't participating but could participate if he wanted (start date > current date)go
CREATE PROCEDURE travel.TouristTourOptions @tourist_email VARCHAR(128)
AS
	SELECT travel.TOUR_INSTANCE.id, travel.TOUR_INSTANCE.start_date_
	FROM travel.TOUR_INSTANCE
	WHERE travel.TOUR_INSTANCE.id = ( 
		SELECT travel.TouristNotParticipatingTour.tour_id		FROM travel.TouristNotParticipatingTour 		WHERE tourist_email = @tourist_email)
	AND travel.TOUR_INSTANCE.start_date_ >= GETDATE()
go

DROP PROCEDURE travel.TouristTourOptions

EXEC travel.TouristTourOptions 'diogodias@bd.com'


-- Get Tours by a partial description
go
CREATE PROCEDURE travel.GetTourByPartDesc @partial_desc VARCHAR(128)
AS
	SELECT * FROM travel.TOUR
	WHERE travel.TOUR.desc_ LIKE CONCAT('%', @partial_desc,'%')
go

DROP PROCEDURE travel.GetTourByPartDesc

EXEC travel.GetTourByPartDesc 'Ro'


--lucro total das instancias / nº instancias
--lucro total: soma do que os turistas pagaram em todas as instâncias

SELECT * FROM travel.TOUR
SELECT * FROM travel.TOUR_INSTANCE

SELECT * FROM travel.TOUR JOIN travel.TOUR_INSTANCE ON  travel.TOUR.id = travel.TOUR_INSTANCE


go
CREATE PROCEDURE travel.TotalProfit @tour_id INT
AS
	
go

DROP PROCEDURE travel.TotalProfit

EXEC travel.TotalProfit -1

