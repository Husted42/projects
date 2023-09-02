-- 1) What is the speed and storage capacity of PC's under 5000 DKK.
SELECT PC.model, PC.speed AS GHz, PC.storage AS GB FROM PC
WHERE PC.price < 5000 ORDER BY PC.storage DESC; 

-- 2) Which laptops are in the Aspire series?
SELECT * FROM Laptop WHERE name LIKE 'Aspire%';

-- 3) Who manufactures mice?
SELECT DISTINCT Product.manufacturer FROM Product 
WHERE Product.model IN(
	SELECT Accessory.model FROM Accessory WHERE Accessory.type = 'mouse'
);

-- 4) Which laptops has more than 128 GB storage and how fast are they?
SELECT Product.manufacturer, Laptop.name, Laptop.speed FROM Laptop
LEFT JOIN Product 
ON Laptop.model = Product.model 
WHERE storage > 128
ORDER BY speed DESC;

-- 5) How much does the different keyboards cost?
SELECT Product.manufacturer, Keyboard.name, Accessory.price FROM Keyboard
LEFT JOIN Accessory ON Accessory.model = Keyboard.model
LEFT JOIN Product ON Keyboard.model = Product.model; 

-- 6) What is the average price of a Lenovo product?
SELECT AVG(a.price) FROM (
	SELECT Product.model, Laptop.price FROM Product 
	RIGHT JOIN Laptop ON Laptop.model = Product.model WHERE manufacturer = 'Lenovo'
	UNION
	SELECT Product.model, PC.price FROM Product 
	RIGHT JOIN PC ON PC.model = Product.model WHERE manufacturer = 'Lenovo'
	UNION
	SELECT Product.model, Accessory.price FROM Product
	RIGHT JOIN Accessory ON Product.model = Accessory.model WHERE manufacturer = 'Lenovo') a;

-- 7) Who manufatures PCs, but not Laptops?
SELECT DISTINCT Product.manufacturer FROM Product
WHERE Product.type = 'pc' 
AND Product.manufacturer NOT IN (
	SELECT Product.manufacturer FROM Product WHERE type = 'laptop');

-- 8) What is the cheapest wireless keyboard?
SELECT name FROM Keyboard WHERE model IN(
	SELECT Accessory.model FROM Accessory WHERE Accessory.price IN(
			SELECT MIN(price) FROM Accessory WHERE type = 'keyboard')
			AND Accessory.type = 'keyboard');
			
-- 9) Which PCs are overpriced? Meaning that they cost more than another PC
--    while being slower and having less memory.
SELECT P1.name AS n1, P2.name as n2 FROM PC P1
INNER JOIN PC P2 ON P1.model != P2.model AND p1.price > p2.price
AND p1.speed < p2.speed AND p1.ram < p2.ram;

-- n1 (LOQ) is more expensive than n2 (Nitro N50-650) and has worse specs. (Besides storage)

-- 10) Which manufacturer makes at least two diffrent mice?
SELECT Product.manufacturer FROM Product WHERE Product.model IN(
	SELECT Accessory.model FROM Accessory WHERE Accessory.type = 'mouse')
GROUP BY Product.manufacturer HAVING COUNT(Product.manufacturer) > 1;

-- 11) Which type of product sells best?
SELECT type, COUNT(type), SUM(price) FROM salesOverview
GROUP BY type;

-- 12) How did the different PC's sell?
SELECT Concat(manufacturer, ' ', name) AS modelName, COUNT(name) AS count, SUM(price) AS sum FROM salesOverview
WHERE type = 'pc' GROUP BY modelName ORDER BY sum DESC;
