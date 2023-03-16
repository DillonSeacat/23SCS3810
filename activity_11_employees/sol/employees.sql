-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The employees database

-- TODOd: create database employees
CREATE DATABASE employees;

\c employees

-- TODOd: create table departments
CREATE TABLE Departments (
    code CHAR(2) PRIMARY KEY, 
    "desc" VARCHAR(25) NOT NULL
);

-- TODOd: populate table departments
INSERT INTO Departments VALUES 
    ('HR', 'Human Resources'), 
    ('IT', 'Information Technology'), 
    ('SL', 'Sales');

INSERT INTO Departments VALUES 
    ('MK', 'Marketing');

-- TODOd: create table employees
CREATE TABLE Employees (
  id   SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  sal  DECIMAL(8, 2) NOT NULL,
  deptCode CHAR(2),
  FOREIGN KEY (deptCode) REFERENCES Departments ( code )
);

-- TODO: populate table Employees

INSERT INTO Employees (name, sal, deptCode) VALUES
  ( 'Sam Mai Tai', 50000, 'HR' );

INSERT INTO Employees (name, sal, deptCode) VALUES
  ( 'James Brandy', 55000, 'HR' ),
  ('Whisky Strauss', 60000, 'HR'),
  ('Romeo Curacau', 65000, 'IT'),
  ('Jose Caipirinha', 65000, 'IT'),
  ('Tony Gin and Tonic', 80000, 'SL');

INSERT INTO Employees (name, sal, deptCode) VALUES
  ('Debby Derby', 85000, 'SL');

INSERT INTO Employees (name, sal, deptCode) VALUES
  ('Morbid Mojito', 150000, NULL);

-- TODOd: a) list all rows in Departments.
SELECT * FROM Departments;

-- TODOd: b) list only the codes in Departments.
SELECT code FROM Departments;

-- TODOd: c) list all rows in Employees.
SELECT * FROM Employees;

-- TODOd: d) list only the names in Employees in alphabetical order.
SELECT name FROM Employees ORDER BY 1;

-- TODOd: e) list only the names and salaries in Employees, from the highest to the lowest salary.
SELECT name, sal FROM Employees ORDER BY 2 DESC;

-- TODOd: f) list the cartesian product of Employees and Departments.
SELECT id, deptCode, code FROM Employees, Departments ORDER BY id, code;

-- TODOd: g) do the natural join of Employees and Departments; the result should be exactly the same as the cartesian product; do you know why?
SELECT id, code, code FROM Employees 
NATURAL JOIN Departments 
ORDER BY id, code;

-- TODO: i) do an equi join of Employees and Departments matching the rows by Employees.deptCode and Departments.code (hint: use JOIN and the ON clause).

-- equijoin (theta join using equality)
SELECT * FROM Employees A, Departments B
WHERE A.deptCode = B.code;

-- equijoin
SELECT * FROM Employees A
INNER JOIN Departments B
ON A.deptCode = B.code;

-- left outer join (shows not only the employees in relationship with departments but
-- also the ones not in relationship; in other words, employees that aren't currently working
-- on a department)
SELECT * FROM Employees a
LEFT JOIN Departments B
ON A.deptCode = B.code;

SELECT * FROM Employees a
RIGHT JOIN Departments B
ON A.deptCode = B.code;

-- TODO: j) same as previous query but project name and salary of the employees plus the description of their departments.
SELECT name, sal, "desc" AS description
FROM Employees A
INNER JOIN Departments B
ON A.deptCode = B.code;

-- TODO: k) same as previous query but only the employees that earn less than 60000.
SELECT name, sal, "desc" AS description
FROM Employees A
INNER JOIN Departments B
ON A.deptCode = B.code
WHERE sal < 60000;

-- TODO: l) same as query ‘i’  but only the employees that earn more than ‘Jose Caipirinha’.
SELECT name, sal, "desc" AS description
FROM Employees A
INNER JOIN Departments B
ON A.deptCode = B.code
WHERE sal > (
    SELECT sal FROM Employees WHERE name = 'Jose Caipirinha'
);

-- TODO: m) list the left outer join of Employees and Departments (use the ON clause to match by department code); how does the result of this query differs from query ‘i’?
-- done

-- TODO: n) from query ‘m’, how would you do the left anti-join?

-- TODO: o) show the number of employees per department.

-- TODO: p) same as query ‘o’ but I want to see the description of each department (not just their codes).
