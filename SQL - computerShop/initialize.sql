DROP VIEW IF EXISTS salesOverview; 

-- Create tables for computer shop -- 
DROP TABLE IF EXISTS Sales;
CREATE TABLE Sales(
	id SERIAL,
	model INTEGER,
	orderDate DATE,
	PRIMARY KEY (id)
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product(
	manufacturer VARCHAR(255),
	model INTEGER,
	type VARCHAR(20),
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS PC;
CREATE table PC(
	name VARCHAR(255),
	model INTEGER, 
	speed FLOAT, 
	ram INTEGER, 
	storage INTEGER, 
	price INTEGER,
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS Laptop;
CREATE table Laptop(
	name VARCHAR(255),
	model INTEGER, 
	speed FLOAT, 
	ram INTEGER, 
	storage INTEGER, 
	screenSize FLOAT, 
	price INTEGER,
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS Accessory;
CREATE TABLE Accessory(
	model INTEGER,
	type VARCHAR(15),
	price INTEGER,
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS Keyboard;
CREATE TABLE Keyboard(
	name VARCHAR(255),
	model INTEGER,
	keys VARCHAR(15),
	color VARCHAR(15),
	numpad BOOL,
	wireless BOOL,
	PRIMARY KEY (model)
);

DROP TABLE IF EXISTS Mouse;
CREATE TABLE Mouse(
	name VARCHAR(255),
	model INTEGER,
	buttons INTEGER,
	color VARCHAR(15),
	wireless BOOL,
	PRIMARY KEY (model)
);

-- Insert data -- 
----- PC
insert into Product values('Lenovo', 1001, 'pc');
insert into PC values('IdeaCentre Gaming 5', 1001, 2.5, 8, 512, 5797);

insert into Product values('Lenovo', 1002, 'pc');
insert into PC values('LOQ', 1002, 2.5, 8, 2048, 7999);

insert into Product values('Acer', 1003, 'pc');
insert into PC values('Nitro N50-650', 1003, 3.2, 16, 512, 5999);

insert into Product values('HP', 1004, 'pc');
insert into PC values('Omen 25L', 1004, 2.1, 16, 1024, 9999);

insert into Product values('HP', 1005, 'pc');
insert into PC values('Victus 15', 1005, 2.5, 16, 512, 9356);

insert into Product values('Lenovo', 1006, 'pc');
insert into PC values('IdeaCentre', 1006, 1.6, 16, 512, 5999);

insert into Product values('Asus', 1007, 'pc');
insert into PC values('ExpertCenter', 1007, 3.3, 8, 256, 5919);

insert into Product values('Acer', 1008, 'pc');
insert into PC values('Aspire XC-840', 1008, 2.9, 4, 128, 2299);

----- Laptop
insert into Product values('Lenovo', 2001, 'laptop');
insert into Laptop values('Yoga 7 2-i-1', 2001, 1.7, 8, 512, 14, 8999);

insert into Product values('Lenovo', 2002, 'laptop');
insert into Laptop values('IdeaPad Slim 3 R3', 2002, 2.4, 8, 128, 14, 3999);

insert into Product values('Lenovo', 2003, 'laptop');
insert into Laptop values('IdeaPad 4 R5', 2003, 1.2, 4, 128, 14, 4499);

insert into Product values('Acer', 2004, 'laptop');
insert into Laptop values('Aspire 3', 2004, 2.4, 8, 512, 15.6, 5999);

insert into Product values('Acer', 2005, 'laptop');
insert into Laptop values('Aspire 4', 2005, 2.8, 16, 512, 15.6, 6999);

insert into Product values('Acer', 2006, 'laptop');
insert into Laptop values('Aspire 5', 2006, 0.9, 16, 512, 14, 18799);

insert into Product values('Asus', 2007, 'laptop');
insert into Laptop values('X415', 2007, 1.7, 8, 128, 14, 4499);

insert into Product values('Asus', 2008, 'laptop');
insert into Laptop values('X515', 2008, 2.0, 8, 256, 14, 5499);

insert into Product values('Asus', 2009, 'laptop');
insert into Laptop values('VivoBook', 2009, 2.4, 8, 128, 15.6, 4799);

insert into Product values('Asus', 2010, 'laptop');
insert into Laptop values('VivoBook Go', 2010, 2.8, 8, 512, 15.6, 5799);

--- Keyboard
insert into Product values('Logitech', 3001, 'accessory');
insert into Accessory values(3001, 'keyboard', 1199);
insert into Keyboard values('G915', 3001, 'Mechanical', 'Black', TRUE, TRUE);

insert into Product values('Razer', 3002, 'accessory');
insert into Accessory values(3002, 'keyboard', 1499);
insert into Keyboard values('Blackwidow v3 Mini', 3002, 'Mechanical', 'Black', FALSE, TRUE);

insert into Product values('Logitech', 3003, 'accessory');
insert into Accessory values(3003, 'keyboard', 1499);
insert into Keyboard values('G815', 3003, 'Mechanical', 'Black', TRUE, TRUE);

insert into Product values('Logitech', 3004, 'accessory');
insert into Accessory values(3004, 'keyboard', 399);
insert into Keyboard values('G413 TKL', 3004, 'Mechanical', 'Black', FALSE, FALSE);

insert into Product values('Lenovo', 3005, 'accessory');
insert into Accessory values(3005, 'keyboard', 1789);
insert into Keyboard values('rackPoint Keyboard II', 3005, 'Membrane', 'Black', FALSE, TRUE);

insert into Product values('Lenovo', 3006, 'accessory');
insert into Accessory values(3006, 'keyboard', 740);
insert into Keyboard values('4Y41B69381', 3006, 'Membrane', 'Black', TRUE, FALSE);

--- Mouse
insert into Product values('Acer', 4001, 'accessory');
insert into Accessory values(4001, 'mouse', 714);
insert into Mouse values('Predator', 4001, 5, 'Black',  FALSE);

insert into Product values('Lenovo', 4002, 'accessory');
insert into Accessory values(4002, 'mouse', 653);
insert into Mouse values('Yoga', 4002, 2, 'Grey',  TRUE);

insert into Product values('Lenovo', 4003, 'accessory');
insert into Accessory values(4003, 'mouse', 388);
insert into Mouse values('ThinkPad', 4003, 3, 'Black',  TRUE);

insert into Product values('Logitech', 4004, 'accessory');
insert into Accessory values(4004, 'mouse', 450);
insert into Mouse values('G Pro', 4004, 2, 'Black',  TRUE);

--- Sales
COPY sales(id, model, orderDate)
FROM 'C:/Users/Public/salesData.csv'
DELIMITER ','
CSV HEADER;
