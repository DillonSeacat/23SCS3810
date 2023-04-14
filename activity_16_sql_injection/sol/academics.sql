-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The academics database

CREATE DATABASE academics;

\c academics

CREATE TABLE Courses (
    code VARCHAR(3) NOT NULL,
    number INT NOT NULL,  
    descr VARCHAR(50) NOT NULL, 
    PRIMARY KEY (code, number)
);

INSERT INTO Courses VALUES 
    ('CS', 2050, 'Computer Science 2'), 
    ('CS', 3810, 'Principles of Database Systems');

CREATE TABLE Students (
    id SERIAL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

INSERT INTO Students (name) VALUES 
    ('Sneaky Peaky'), 
    ('Butch Cassidy'), 
    ('John Dillinger');

CREATE TABLE Grades (
    code VARCHAR(3) NOT NULL, 
    number INT NOT NULL,
    id INT NOT NULL, 
    letter VARCHAR(2) NOT NULL, 
    PRIMARY KEY (id, code, number), 
    FOREIGN KEY (code, number) REFERENCES Courses (code, number), 
    FOREIGN KEY (id) REFERENCES Students (id)
);

INSERT INTO Grades VALUES
    ('CS', 3810, 1, 'F');

-- UPDATE Grades SET letter = 'A+' WHERE name = 

CREATE USER "academics" PASSWORD '135791';
GRANT ALL ON TABLE Courses TO "academics";
GRANT ALL ON TABLE Students TO "academics";
GRANT ALL ON TABLE Grades TO "academics";
GRANT ALL ON SEQUENCE students_id_seq TO "academics";

SELECT * FROM Grades 
NATURAL JOIN Students 
NATURAL JOIN Courses
WHERE name = 'Sneaky Peaky'; 