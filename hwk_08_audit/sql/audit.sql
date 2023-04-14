-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: 
-- Description: SQL for the audit database

DROP DATABASE audit;

CREATE DATABASE audit;

\c audit

CREATE TABLE Employees (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
); 

CREATE TABLE EmployeesAudit (
    seq SERIAL PRIMARY KEY, 
    date DATE NOT NULL, 
    descr VARCHAR(200) NOT NULL
);

--- CREATE FUNCTION employee_audit_after_insert() RETURNS TRIGGER

-- CREATE TRIGGER employee_audit

-- use the following insert statements to test your trigger
INSERT INTO Employees VALUES (101, 'Samuel Adams'); 
INSERT INTO Employees VALUES (202, 'Adolph Coors');
INSERT INTO Employees VALUES (303, 'Arthur Guinness');