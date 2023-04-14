-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): DILLON SEACAT
-- Description: IPPS database

DROP DATABASE ipps;

CREATE DATABASE ipps;

\c ipps

-- create tables

CREATE TABLE RUCA(
    Rndrng_Prvdr_RUCA DECIMAL PRIMARY KEY,
    Rndrng_Prvdr_RUCA_Desc VARCHAR(250)
);

CREATE TABLE Provider (
    Rndrng_Prvdr_CCN CHAR(5) PRIMARY KEY,
    Rndrng_Prvdr_Org_Name VARCHAR(100),
    Rndrng_Prvdr_St VARCHAR(100),
    Rndrng_Prvdr_City VARCHAR(30),
    Rndrng_Prvdr_State_Abrvtn CHAR(2),
    Rndrng_Prvdr_State_FIPS INT, --FOREIGN KEY FOR STATES
    Rndrng_Prvdr_Zip5 CHAR(5),
    Rndrng_Prvdr_RUCA DECIMAL
);

CREATE TABLE Conditions(
    DRG_Cd CHAR(3) PRIMARY KEY,
    DRG_Desc VARCHAR(500)
);

CREATE TABLE Billing(
    Rndrng_Prvdr_CCN CHAR(5) PRIMARY KEY,
    DRG_Cd CHAR(3) PRIMARY KEY,
    Tot_Dschrgs INT,
    Avg_Submtd_Cvrd_Chrg DECIMAL,
    Avg_Tot_Pymt_Amt DECIMAL,
    Avg_Mdcr_Pymt_Amt DECIMAL
);



-- create user with appropriate access to the tables

CREATE USER "ipps" PASSWORD '135791';
GRANT ALL ON TABLE Provider TO "ipps";
GRANT ALL ON TABLE RUCA TO "ipps";
GRANT ALL ON TABLE Conditions TO "ipps";
GRANT ALL ON TABLE Billing TO "ipps";

-- queries

-- a) List all diagnosis in alphabetical order.    
    SELECT DRG_Desc FROM Conditions ORDER BY DRG_Desc;

-- b) List the names and correspondent states (including Washington D.C.) of all of the providers in alphabetical order (state first, provider name next, no repetition). 
    SELECT CONCAT(Rndrng_Prvdr_State_Abrvtn, ' ', Rndrng_Prvdr_Org_Name) AS Provider_and_State 
    FROM Provider GROUP BY Provider_and_State ORDER BY Provider_and_State;

-- c) List the total number of providers.
    SELECT COUNT(*) AS Total_Providers FROM Provider;

-- d) List the total number of providers per state (including Washington D.C.) in alphabetical order (also printing out the state).  
    SELECT Rndrng_Prvdr_State_Abrvtn, COUNT(*) AS Total_Providers FROM Provider 
    GROUP BY Rndrng_Prvdr_State_Abrvtn ORDER BY Rndrng_Prvdr_State_Abrvtn;

-- e) List the providers names in Denver (CO) or in Lakewood (CO) in alphabetical order  
    SELECT Rndrng_Prvdr_Org_Name FROM Provider 
    WHERE Rndrng_Prvdr_City IN ('Denver', 'Lakewood') 
    AND Rndrng_Prvdr_State_Abrvtn = 'CO' 
    ORDER BY Rndrng_Prvdr_Org_Name;

-- f) List the number of providers per RUCA code (showing the code and description)
    SELECT r.Rndrng_Prvdr_RUCA, r.Rndrng_Prvdr_RUCA_Desc, COUNT(*) AS Total_Providers 
    FROM Provider p INNER JOIN RUCA r ON p.Rndrng_Prvdr_RUCA = r.Rndrng_Prvdr_RUCA 
    GROUP BY r.Rndrng_Prvdr_RUCA, r.Rndrng_Prvdr_RUCA_Desc;

-- g) Show the DRG description for code 308 
    SELECT DRG_Desc FROM Conditions WHERE DRG_Cd = '308';

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   
    SELECT CONCAT(Rndrng_Prvdr_Org_Name, ', ', Rndrng_Prvdr_City, ', ', Rndrng_Prvdr_State_Abrvtn) AS Provider, Avg_Submtd_Cvrd_Chrg 
    FROM Billing b INNER JOIN Provider p ON b.Rndrng_Prvdr_CCN = p.Rndrng_Prvdr_CCN 
    WHERE DRG_Cd = '308' ORDER BY Avg_Submtd_Cvrd_Chrg DESC LIMIT 10;

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 
    SELECT 

-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
