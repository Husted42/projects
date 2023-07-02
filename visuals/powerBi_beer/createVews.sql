DROP TABLE IF EXISTS main CASCADE;
DROP TABLE IF EXISTS byCountry CASCADE;

CREATE TABLE main(
	brewer VARCHAR(255),
	name VARCHAR(255),
	alc decimal,
	country VARCHAR(255),
	rating smallint,
	price decimal
);
COPY main FROM 'C:\C\gitHub\Projects\visuals\powerBi_beer\new_data.csv' DELIMITER ',' CSV HEADER;

CREATE VIEW byCountry AS 
SELECT country, TRUNC(AVG(rating), 1) FROM main 
GROUP BY country
HAVING COUNT(name) > 3
ORDER BY AVG(rating) DESC;

CREATE VIEW byBrewer AS 
SELECT brewer, TRUNC(AVG(rating), 1) FROM main 
WHERE brewer != 'na'
GROUP BY brewer
HAVING COUNT(name) > 2
ORDER BY AVG(rating) DESC;

COPY (select * from byCountry) TO 'C:\C\gitHub\Projects\visuals\powerBi_beer\view_byCountry.csv' 
   DELIMITER ',' CSV HEADER;

COPY (select * from byBrewer) TO 'C:\C\gitHub\Projects\visuals\powerBi_beer\view_byBrewer.csv' 
	DELIMITER ',' CSV HEADER;