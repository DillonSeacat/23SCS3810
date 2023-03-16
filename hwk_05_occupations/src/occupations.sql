-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: Dillon Seacat
-- Description: a database of occupations

CREATE DATABASE occupations;

\c occupations

DROP TABLE IF EXISTS Occupations;


-- TODO: create table Occupations
CREATE TABLE Occupations( 
    Code VARCHAR(15) PRIMARY KEY,
    Occupation VARCHAR(1000) NOT NULL,
    JobFamily VARCHAR(1000) NOT NULL
);
-- TODO: populate table Occupations
\copy Occupations
    (Code, Occupation, JobFamily)
    FROM /var/lib/postgresql/data/occupations.csv DELIMITER ',' CSV HEADER;
-- TODO: a) the total number of occupations (expect 1016).
SELECT COUNT(*) FROM Occupations;
-- TODO: b) a list of all job families in alphabetical order (expect 23).
SELECT DISTINCT JobFamily FROM Occupations ORDER BY 1;
-- TODO: c) the total number of job families (expect 23)
SELECT COUNT(DISTINCT JobFamily) FROM Occupations;
-- TODO: d) the total number of occupations per job family in alphabetical order of job family.
SELECT JobFamily, COUNT(*) FROM Occupations GROUP BY JobFamily ORDER BY 1;
-- TODO: e) the number of occupations in the "Computer and Mathematical" job family (expect 38)
SELECT COUNT(*) FROM Occupations WHERE JobFamily = 'Computer and Mathematical';
-- BONUS POINTS

-- TODO: f) an alphabetical list of occupations in the "Computer and Mathematical" job family.
SELECT Occupation FROM Occupations WHERE JobFamily = 'Computer and Mathematical' ORDER BY 1;
-- TODO: g) an alphabetical list of occupations in the "Computer and Mathematical" job family that begins with the word "Database"
SELECT Occupation FROM Occupations WHERE JobFamily = 'Computer and Mathematical' AND Occupation LIKE 'Database%' ORDER BY 1;