-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The astronauts database

CREATE DATABASE astronauts;

\c astronauts

DROP TABLE Astronauts;

\d Astronauts

CREATE TABLE Astronauts(
    id SERIAL PRIMARY KEY, 
    lastName VARCHAR(25) NOT NULL,
    firstName VARCHAR(25) NOT NULL, 
    suffix CHAR(10), 
    gender CHAR(1) NOT NULL, 
    birth DATE NOT NULL, 
    city VARCHAR(25),
    state VARCHAR(30), 
    country VARCHAR(25), 
    status VARCHAR(15), 
    daysInSpace INT NOT NULL, 
    flights INT NOT NULL);

\copy Astronauts
    (lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, flights) from /var/lib/postgresql/data/astronauts.csv DELIMITER ',' CSV HEADER;

-- a) the total number of astronauts.
SELECT COUNT(*) FROM Astronauts;

-- b) the total number of American astronauts.
SELECT COUNT(*) AS total FROM Astronauts WHERE country = 'USA';

-- c) the list of nationalities of all astronauts in alphabetical order.
SELECT DISTINCT country FROM Astronauts ORDER BY 1;

-- d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names).
SELECT CONCAT(lastName, ', ', firstName) AS name FROM Astronauts ORDER BY 1;

-- e) the total number of astronauts by gender.
SELECT gender, COUNT(*) AS total FROM Astronauts GROUP BY gender;

-- f) the total number of female astronauts that are still active.
SELECT COUNT(*) AS total FROM Astronauts 
WHERE gender = 'F' AND status = 'Active';

-- g) the total number of American female astronauts that are still active.
SELECT COUNT(*) AS total FROM Astronauts 
WHERE gender = 'F' AND country = 'USA' AND status = 'Active';

-- h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d).
SELECT CONCAT(lastName, ', ', firstName) AS name FROM Astronauts 
WHERE gender = 'F' AND country = 'USA' AND status = 'Active' ORDER BY 1;

-- i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d).
SELECT CONCAT(lastName, ', ', firstName) AS name, birth, date_part('year', AGE(birth)) AS age FROM Astronauts WHERE country = 'China' ORDER BY lastName;

SELECT CONCAT(lastName, ', ', firstName) AS name, birth, AGE(birth) AS age FROM Astronauts WHERE country = 'China' ORDER BY lastName;

-- j) the total number of astronauts by country.
SELECT COUNT(*) AS total, country FROM Astronauts GROUP BY country ORDER BY 1 DESC;

-- k) the total number of American astronauts per state ordered by the totals in descending order.
SELECT COUNT(*) AS total, state FROM Astronauts WHERE country = 'USA' GROUP BY state ORDER BY 1 DESC;


-- l) the total number of astronauts by statuses (i.e., active or retired).
SELECT COUNT(*) AS total, status FROM Astronauts GROUP BY status;

-- m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d).
SELECT CONCAT(lastName, ', ', firstName) AS name, country FROM Astronauts WHERE country <> 'USA' ORDER BY 1;

SELECT CONCAT(lastName, ', ', firstName) AS name, country FROM Astronauts WHERE country != 'USA' ORDER BY 1;

-- n) the average age of all American astronauts that are still active.
SELECT AVG(date_part('year', AGE(birth))) AS "avg age" FROM Astronauts WHERE country = 'USA' AND status = 'Active';
