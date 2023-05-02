-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: 
-- Description: SQL for the camp database

CREATE DATABASE camp; 

\c camp

CREATE TABLE staff (
    email VARCHAR(50) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    nickname VARCHAR(50), 
    role VARCHAR(50)
);

INSERT INTO staff VALUES   
    ('aqua@man.com', 'Aqua Man', 'aqua', 'counselor'), 
    ('cat@woman.com', 'Cat Woman', 'catty', 'counselor'), 
    ('green@lantern.com', 'Green Lantern', 'greenny', 'security'), 
    ('drdestiny@gmail.com', 'Dr. Destiny', null, 'manager'), 
    ('wolverine@gmail.com', 'James Howlett', 'wolverine', 'cook');

CREATE TABLE cabins (
    name VARCHAR(50) PRIMARY KEY, 
    capacity INT NOT NULL, 
    leader VARCHAR(50), 
    FOREIGN KEY (leader) REFERENCES staff(email)
);

INSERT INTO cabins VALUES 
    ('greenland', 15, 'aqua@man.com'), 
    ('appalachian', 23, 'cat@woman.com');

CREATE TABLE campers (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL, 
    dob DATE NOT NULL, 
    gender VARCHAR(10), 
    cabin VARCHAR(50), 
    FOREIGN KEY (cabin) REFERENCES cabins (name)
);

INSERT INTO campers VALUES 
    (1, 'Achiles', '2011-01-01', 'male', 'greenland'), 
    (2, 'Apollo', '2011-02-01', 'male', 'greenland'),
    (3, 'Aphrodite', '2011-03-01', 'female', 'appalachian'), 
    (4, 'Isis', '2011-04-01', NULL, 'appalachian');

CREATE TABLE programs (
    name VARCHAR(50) PRIMARY KEY, 
    descr VARCHAR(200) NOT NULL, 
    price DECIMAL(10,2)
);

INSERT INTO programs VALUES 
    ('homestead', 'Our youngest adventurers learn how to make new friends, 
discover self-confidence, and learn independence', 5000), 
    ('outpost', 'Campers experience rewarding trips in the backcountry with the 
guidance and support of counselors', 5500);

CREATE TABLE participates (
    camper INT, 
    program VARCHAR(50), 
    PRIMARY KEY (camper, program),
    FOREIGN KEY (camper) REFERENCES campers (id), 
    FOREIGN KEY (program) REFERENCES programs (name)
);

INSERT INTO participates VALUES 
    (1, 'homestead'), 
    (2, 'homestead'),
    (3, 'homestead'), 
    (4, 'outpost');

CREATE TABLE guardians (
    email VARCHAR(50) PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

INSERT INTO guardians VALUES 
    ('peleus@palace.com', 'Peleus'), 
    ('thetis@palace.com', 'Thetis'),
    ('leto@gmail.com', 'Leto'), 
    ('dione@god.com', 'Dione'), 
    ('sky@god.com', 'Sky');

-- TODO: create a table to represent the relationship between campers and guardians
CREATE TABLE guardian_campers (
    seq SERIAL PRIMARY KEY, 
    guardian VARCHAR(50), 
    camper INT, 
    FOREIGN KEY (guardian) REFERENCES guardians (email), 
    FOREIGN KEY (camper) REFERENCES campers (id)
);

INSERT INTO guardian_campers (guardian, camper) VALUES 
    ('peleus@palace.com', 1), 
    ('thetis@palace.com', 1), 
    ('leto@gmail.com', 2), 
    ('dione@god.com', 3), 
    ('sky@god.com', 4);

CREATE USER "camp" PASSWORD '135791';
GRANT ALL ON TABLE staff TO "camp";
GRANT ALL ON TABLE cabins TO "camp";
GRANT ALL ON TABLE campers TO "camp";
GRANT ALL ON TABLE programs TO "camp";
GRANT ALL ON TABLE participates TO "camp";
GRANT ALL ON TABLE guardians TO "camp";
GRANT ALL ON TABLE guardian_campers TO "camp";
