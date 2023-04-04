-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Description: The hr database

CREATE DATABASE hr;

\c hr

CREATE TABLE Employees (
 id INT NOT NULL PRIMARY KEY,
 name VARCHAR(35) NOT NULL,
 sal INT ); 

INSERT INTO Employees VALUES
 ( 1, 'Sam Mai Tai', 35000 ),
 ( 2, 'Morbid Mojito', 65350 );

 CREATE USER "hr" PASSWORD '024680';
CREATE USER "hr_admin" PASSWORD '135791';

\du

GRANT SELECT ON TABLE Employees TO "hr";
GRANT ALL ON TABLE Employees TO "hr_admin";

docker exec -it postgres psql -d hr -U hr -W

INSERT INTO Employees VALUES (3, 'Thyago', 200000);

docker exec -it postgres psql -d hr -U hr_admin -W

CREATE DATABASE hotels;

\c hotels

CREATE TABLE hotels (
    code SERIAL PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    city VARCHAR(50) NOT NULL, 
    state CHAR(2) NOT NULL
);

INSERT INTO hotels (name, city, state) VALUES 
    ('Le Boutique', 'New Orleans', 'LA'),
    ('Supreme', 'San Francisco', 'CA');


    CREATE USER "hotel_manager" PASSWORD '135791';
GRANT ALL ON TABLE hotels TO "hotel_manager";
GRANT ALL ON SEQUENCE hotels_code_seq TO "hotel_manager";


docker exec -it postgres psql -d hotels -U hotel_manager -W


INSERT INTO hotels (name, city, state) VALUES 
    ('Broadmoor', 'Colorado Springs', 'CO');


    