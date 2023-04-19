-- Find the average total__emmision from each env_class (FUNCTION)
SELECT env_class.env_name, AVG(routes.total_emmison) AS averageEmmission
FROM routes
JOIN vessels
ON routes.vessel_id = vessels.vessel_id
JOIN env_class
ON vessels.env_id = env_class.env_id
GROUP BY env_class.env_id;

-- Find the captains that have sailed longer than 9000 km. in a single route
SELECT captains.fname, captains.lname
FROM captains
WHERE captains.emp_id IN(
	SELECT routes.emp_id
	FROM routes
	WHERE routes.lenght > 9000
);

-- Find a list of all captains names and vessels names
SELECT captains.fname, captains.lname
FROM captains
UNION
SELECT vessels.vessel_id, vessels.type
FROM vessels;

-- Find all vessels bought in june and july (WILDCARD)
SELECT *
FROM vessels
WHERE owned_since LIKE '____-07%' OR owned_since LIKE '____-06%'
ORDER BY owned_since;

-- Find the estimated emmsion from each vessel
SELECT vessels.vessel_id, vessels.type, env_class.env_name, env_class.emmision
FROM vessels
JOIN env_class
ON vessels.env_id = env_class.env_id;






