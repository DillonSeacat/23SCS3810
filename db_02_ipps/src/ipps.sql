-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Adam Abubakar and Dillon Seacat
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
    Rndrng_Prvdr_CCN CHAR(6) PRIMARY KEY,
    Rndrng_Prvdr_Org_Name VARCHAR(100),
    Rndrng_Prvdr_St VARCHAR(100),
    Rndrng_Prvdr_City VARCHAR(30),
    Rndrng_Prvdr_State_Abrvtn CHAR(2),
    Rndrng_Prvdr_State_FIPS INT,
    Rndrng_Prvdr_Zip5 CHAR(5),
    ruca_Rndrng_Prvdr_RUCA DECIMAL,
    FOREIGN KEY(ruca_Rndrng_Prvdr_RUCA) REFERENCES RUCA(Rndrng_Prvdr_RUCA)
);

CREATE TABLE Conditions(
    DRG_Cd CHAR(3) PRIMARY KEY,
    DRG_Desc VARCHAR(500)
);

CREATE TABLE Billing(
    provider_Rndrng_Prvdr_CCN CHAR(6),
    conditions_DRG_Cd CHAR(3),
    Tot_Dschrgs INT,
    Avg_Submtd_Cvrd_Chrg DECIMAL,
    Avg_Tot_Pymt_Amt DECIMAL,
    Avg_Mdcr_Pymt_Amt DECIMAL,
    PRIMARY KEY(provider_Rndrng_Prvdr_CCN, conditions_DRG_Cd),
    FOREIGN KEY(provider_Rndrng_Prvdr_CCN) REFERENCES Provider(Rndrng_Prvdr_CCN),
    FOREIGN KEY(conditions_DRG_Cd) REFERENCES Conditions(DRG_Cd)
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
    -- ********************
    SELECT CONCAT(Rndrng_Prvdr_State_Abrvtn, ' ', Rndrng_Prvdr_Org_Name) AS Provider_and_State 
    FROM Provider ORDER BY Provider_and_State;

    SELECT Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_Org_Name 
    FROM Provider; GROUP BY Provider_and_State ORDER BY Provider_and_State;
    -- ********************

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
    SELECT RUCA.Rndrng_Prvdr_RUCA, RUCA.Rndrng_Prvdr_RUCA_Desc, COUNT(*) AS Total_Providers 
    FROM Provider INNER JOIN RUCA ON Provider.ruca_Rndrng_Prvdr_RUCA = RUCA.Rndrng_Prvdr_RUCA 
    GROUP BY RUCA.Rndrng_Prvdr_RUCA, RUCA.Rndrng_Prvdr_RUCA_Desc;

-- g) Show the DRG description for code 308 
    SELECT DRG_Desc FROM Conditions WHERE DRG_Cd = '308';

-- h) List the top 10 providers (with their correspondent state) that charged (as described in Avg_Submtd_Cvrd_Chrg) the most for the DRG code 308. Output should display the provider name, their city, state, and the average charged amount in descending order.   
    SELECT CONCAT(p.Rndrng_Prvdr_Org_Name, ', ', p.Rndrng_Prvdr_City, ', ', p.Rndrng_Prvdr_State_Abrvtn) AS Provider, b.Avg_Submtd_Cvrd_Chrg 
    FROM Billing b INNER JOIN Provider p ON b.provider_Rndrng_Prvdr_CCN = p.Rndrng_Prvdr_CCN 
    WHERE b.conditions_DRG_Cd = '308' ORDER BY b.Avg_Submtd_Cvrd_Chrg DESC LIMIT 10;

-- i) List the average charges (as described in Avg_Submtd_Cvrd_Chrg) of all providers per state for the DRG code 308. Output should display the state and the average charged amount per state in descending order (of the charged amount) using only two decimals. 
    SELECT p.Rndrng_Prvdr_State_Abrvtn AS state , ROUND(AVG(b.Avg_Submtd_Cvrd_Chrg),2) AS average_amount_charged
    FROM Billing b INNER JOIN Provider p ON b.provider_Rndrng_Prvdr_CCN = p.Rndrng_Prvdr_CCN 
    WHERE b.conditions_DRG_Cd = '308' GROUP BY state ORDER BY average_amount_charged DESC;

-- j) Which provider and clinical condition pair had the highest difference between the amount charged (as described in Avg_Submtd_Cvrd_Chrg) and the amount covered by Medicare only (as described in Avg_Mdcr_Pymt_Amt)?
    SELECT A.Rndrng_Prvdr_Org_Name, C.DRG_Desc, ROUND((B.Avg_Submtd_Cvrd_Chrg - B.Avg_Mdcr_Pymt_Amt),2) AS difference_between_amount_charged_and_medicare 
    FROM Provider A INNER JOIN Billing B ON A.Rndrng_Prvdr_CCN = B.provider_Rndrng_Prvdr_CCN INNER JOIN Conditions C ON B.conditions_DRG_Cd = C.DRG_Cd 
    ORDER BY difference_between_amount_charged_and_medicare DESC LIMIT 1;