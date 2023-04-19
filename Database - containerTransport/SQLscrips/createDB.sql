CREATE TABLE vessels (
  vessel_id INT AUTO_INCREMENT,
  type VARCHAR(15),
  owned_since DATE,
  env_id INT,
  PRIMARY KEY (vessel_id)
);

CREATE TABLE env_class (
	env_id INT PRIMARY KEY,
    env_name VARCHAR(10),
    emmision NUMERIC (2, 1)
);

ALTER TABLE vessels
ADD FOREIGN KEY(env_id)
REFERENCES env_class(env_id);

CREATE TABLE captains(
	emp_id int,
    fname VARCHAR(20),
    lname VARCHAR(30),
    PRIMARY KEY(emp_id)
);

CREATE TABLE routes(
	vessel_id INT,
	departure_date DATE,
    emp_id INT,
    goods_amount INT,
    lenght INT,
    total_emmison INT DEFAULT NULL,
    PRIMARY KEY(vessel_id, departure_date),
    FOREIGN KEY(vessel_id) REFERENCES vessels(vessel_id),
    FOREIGN KEY(emp_id) REFERENCES captains(emp_id) ON DELETE SET NULL
);


-- add enviroment classes
INSERT INTO env_class VALUES(1, 'A', 3.0);
INSERT INTO env_class VALUES(2, 'B', 4.5);
INSERT INTO env_class VALUES(3, 'C', 6.0);
INSERT INTO env_class VALUES(4, 'D', 7.5);
INSERT INTO env_class VALUES(5, 'E', 9.0);

-- add vessels
INSERT INTO vessels(type, owned_since, env_id) VALUES('KFM Gold', '1990-05-20', 1);
INSERT INTO vessels(type, owned_since, env_id) VALUES('KFM Silver', '1991-01-04', 2);
INSERT INTO vessels(type, owned_since, env_id) VALUES('Zode Silver', '1994-06-28', 1);
INSERT INTO vessels(type, owned_since, env_id) VALUES('MST Gold', '1995-07-30', 1);
INSERT INTO vessels(type, owned_since, env_id) VALUES('MST Bronze', '1999-12-16', 2);
INSERT INTO vessels(type, owned_since, env_id) VALUES('LDS Gold', '2001-02-15', 1);
INSERT INTO vessels(type, owned_since, env_id) VALUES('KFM Silver', '2001-02-22', 3);
INSERT INTO vessels(type, owned_since, env_id) VALUES('Zode Gold', '2001-08-28', 3);
INSERT INTO vessels(type, owned_since, env_id) VALUES('KFM Silver', '2003-07-03', 1);
INSERT INTO vessels(type, owned_since, env_id) VALUES('MST Bronze', '2008-06-09', 4);

-- add captains
INSERT INTO captains VALUES(1, 'Archibald', 'Haddock');
INSERT INTO captains VALUES(2, 'James', 'Hook');
INSERT INTO captains VALUES(3, 'Ferdinand', 'Magellan');
INSERT INTO captains VALUES(4, 'Bartholomew', 'Roberts');
INSERT INTO captains VALUES(5, 'Ferdinand ', 'Nelson');

-- add routes
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('5', '2022-02-26', '2', '166', '6654', '40989');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('7', '2022-03-26', '4', '188', '8056', '63481');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('1', '2022-04-03', '1', '157', '9762', '44612');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('8', '2022-04-03', '3', '194', '6457', '51269');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('9', '2022-04-27', '5', '200', '5223', '26115');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('3', '2022-06-01', '1', '178', '6261', '29928');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('10', '2022-06-02', '2', '162', '9757', '88984');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('1', '2022-06-05', '3', '156', '8481', '38673');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('4', '2022-06-13', '4', '181', '9025', '43410');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('8', '2022-06-25', '5', '176', '5722', '44403');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('5', '2022-07-13', '5', '167', '6804', '41987');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('7', '2022-07-14', '2', '180', '9623', '75059');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('6', '2022-08-08', '3', '189', '6563', '32093');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('3', '2022-08-12', '1', '190', '5627', '27572');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('9', '2022-08-15', '2', '175', '5074', '24101');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('7', '2022-08-21', '4', '160', '6036', '45874');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('10', '2022-08-25', '5', '185', '7865', '73538');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('10', '2022-09-07', '2', '198', '9298', '88145');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('7', '2022-09-08', '3', '182', '8452', '66095');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('9', '2022-09-11', '1', '153', '9540', '43216');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('6', '2022-09-20', '1', '158', '7647', '35023');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('5', '2022-09-26', '4', '184', '8012', '50796');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('7', '2022-10-15', '3', '171', '8625', '66499');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('2', '2022-10-17', '1', '183', '9875', '62509');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('8', '2022-11-12', '5', '193', '7778', '61680');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('2', '2022-11-16', '2', '161', '8398', '51312');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('3', '2022-11-20', '3', '165', '7283', '33866');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('10', '2022-11-29', '1', '150', '5417', '48753');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght, total_emmison) VALUES ('4', '2022-11-30', '4', '158', '7282', '33352');
INSERT INTO routes (vessel_id, departure_date, emp_id, goods_amount, lenght) VALUES ('3', '2022-12-10', '4', '164', '6582');