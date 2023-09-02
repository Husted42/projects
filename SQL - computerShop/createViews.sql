--##-- Functions --##--
-- INDEX Function
DROP FUNCTION IF EXISTS getIndexNumbers(n NUMERIC, basis NUMERIC);
CREATE FUNCTION getIndexNumbers(n NUMERIC, basis NUMERIC)
	returns NUMERIC
	language plpgsql
as
$$
BEGIN 
	return ROUND(n/basis * 100, 2);
END;$$;

SELECT * FROM indexNumbers;

--##-- Views/Tables --##--
---- ) Create a view of sales that include prices
DROP VIEW IF EXISTS salesOverview CASCADE; 
CREATE VIEW salesOverview AS
SELECT Sales.model, Sales.orderDate, Product.type, Product.manufacturer,
CONCAT(PC.name, Laptop.name, Mouse.name, Keyboard.name) AS name,
CAST(CONCAT(PC.price, Laptop.price, Accessory.price) AS NUMERIC) AS price
FROM Sales
LEFT JOIN PC ON Sales.model = PC.model
LEFT JOIN Laptop ON Sales.model = Laptop.model
LEFT JOIN Mouse ON Sales.model = Mouse.model
LEFT JOIN Keyboard ON Sales.model = Keyboard.model
LEFT JOIN Accessory ON Sales.model = Accessory.model
LEFT JOIN Product ON Sales.model = Product.model
ORDER BY orderDate DESC;

SELECT * FROM salesOverview;

----) Index numbers for turnover by year
DO $$
DECLARE 
	basisIndex INTEGER;

BEGIN
	-- Tempoary table of turnover by year
	CREATE TEMPORARY TABLE turnoverByYear AS(
		SELECT SUM(price) AS turnover, to_char(orderDate, 'YYYY') AS year FROM salesOverview
		GROUP BY year ORDER BY year);
	
	basisIndex := (SELECT turnover FROM turnoverByYear WHERE turnoverByYear.year LIKE '2010');
	
	DROP TABLE IF EXISTS indexNumbers CASCADE; 
	-- CREATE TABLE
	CREATE TABLE indexNumbers AS(
	SELECT getIndexNumbers(turnover, basisIndex) AS index, turnover, year FROM turnoverByYear);
	
	DROP TABLE turnoverByYear CASCADE;
END $$;

SELECT * FROM indexNumbers;

----) Index numbers by year and category
DO $$
DECLARE 
	basisAccessory NUMERIC;
	basisLaptop NUMERIC;
	basisPC NUMERIC;

BEGIN
	-- Tempoary table of turnover by year
	DROP TABLE IF EXISTS soldByYearAndType CASCADE;
	CREATE TABLE soldByYearAndType AS(
		SELECT SUM(price) AS salesSum, type, to_char(orderDate, 'YYYY') AS year FROM salesOverview
		GROUP BY year, type 
		ORDER BY year, type);
	
	basisAccessory := (SELECT salesSum FROM soldByYearAndType WHERE 
				   soldByYearAndType.year LIKE '2010' AND type LIKE 'accessory');
	basisLaptop := (SELECT salesSum FROM soldByYearAndType WHERE 
				   soldByYearAndType.year LIKE '2010' AND type LIKE 'laptop');
	basisPC := (SELECT salesSum FROM soldByYearAndType WHERE 
				   soldByYearAndType.year LIKE '2010' AND type LIKE 'pc');
	
	UPDATE soldByYearAndType 
	SET salesSum = getIndexNumbers(salesSum, basisAccessory)
	WHERE type = 'accessory';
	
	UPDATE soldByYearAndType 
	SET salesSum = getIndexNumbers(salesSum, basisLaptop)
	WHERE type = 'laptop';
	
	UPDATE soldByYearAndType 
	SET salesSum = getIndexNumbers(salesSum, basisPC)
	WHERE type = 'pc';
	
RAISE NOTICE '% % %', basisAccessory, basisLaptop, basisPC;
	
END $$;

SELECT * FROM soldByYearAndType;
