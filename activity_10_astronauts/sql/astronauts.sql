-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The astronauts database

CREATE DATABASE astronauts;

DROP TABLE Astronauts;

CREATE TABLE Astronauts (
    id SERIAL PRIMARY KEY,
    lastName VARCHAR(35) NOT NULL,
    firstName VARCHAR(35) NOT NULL,
    suffix CHAR(10),
    gender CHAR(1),
    birth DATE NOT NULL,
    city VARCHAR(25),
    state VARCHAR(30),
    country VARCHAR(25),
    status VARCHAR(30),
    daysInSpace INT NOT NULL,
    flights INT NOT NULL
);

\copy Astronauts
    (lastName, firstName, suffix, gender, birth, city, state, country, status, daysInSpace, flights) 
    from /var/lib/postgresql/data/astronauts.csv DELIMITER ',' CSV HEADER;


a) the total number of astronauts. 
SELECT COUNT(*) FROM Astronauts;

b) the total number of American astronauts.
SELECT COUNT(*) AS total FROM Astronauts WHERE country = 'USA'; 

c) the list of nationalities of all astronauts in alphabetical order. 
SELECT DISTINCT country FROM Astronauts ORDER BY 1;

d) all astronaut names ordered by last name (use the format Last Name, First Name, Suffix to display the names). 
SELECT CONCAT(lastName, ', ', firstName, ', ', suffix) AS name FROM Astronauts ORDER BY 1;

e) the total number of astronauts by gender. 
SELECT gender, COUNT(*) AS total FROM Astronauts GROUP BY gender;

f) the total number of female astronauts that are still active. 

g) the total number of American female astronauts that are still active. 

h) the list of all American female astronauts that are still active ordered by last name (use the same name format used in d). 

i) the list of Chinese astronauts, displaying only their names and ages (use the same name format used in d). 

j) the total number of astronauts by country. 

SELECT COUNT(*) AS total, country FROM Astronauts 

k) the total number of American astronauts per state ordered by the totals in
descending order. 

SELECT COUNT(*) AS total, state, FROM, Astronauts WHERE country = 'USA'
GROUP BY state ORDER BY 1 DESC;

l) the total number of astronauts by statuses (i.e., active or retired). 



m) name and age of all non-American astronauts in alphabetical order (use the same name format used in d). 



n) the average age of all American astronauts that are still active. 



