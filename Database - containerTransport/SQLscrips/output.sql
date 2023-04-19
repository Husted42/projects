-- Rstudio data
-- Get csv file with vessel_id, routes.goods_amout, env_class.emmision, routes.total_emmison, routes.lenght
SELECT routes.vessel_id, routes.goods_amount, env_class.emmision, routes.total_emmison, routes.lenght
FROM routes
JOIN vessels
ON routes.vessel_id = vessels.vessel_id
JOIN env_class
ON vessels.env_id = env_class.env_id
ORDER BY routes.departure_date ASC
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\emPredictionData.csv'
FIELDS TERMINATED BY ',';

-- Get csv file with vessels.vessel_id, env_class.env_name
SELECT env_class.env_name, vessels.env_id
FROM vessels
JOIN env_class
ON vessels.env_id = env_class.env_id;
ORDER BY vessel_id
INTO OUTFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\pieChartData.csv'
FIELDS TERMINATED BY ',';