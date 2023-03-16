-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student: 
-- Description: a database of tv series

CREATE DATABASE series;

\c series

-- table Actors
CREATE TABLE Actors (
    actorId   SERIAL      PRIMARY KEY,
    actorName VARCHAR(30) NOT NULL,
    sex       CHAR(1)     NOT NULL
);

INSERT INTO Actors (actorName, sex) VALUES ('Keri Russell',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Matthew Rhys',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Andrew Lincoln',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Jon Bernthal',        'M');
INSERT INTO Actors (actorName, sex) VALUES ('Sarah Wayne Callies', 'F');
INSERT INTO Actors (actorName, sex) VALUES ('Scott Speedman',      'M');
INSERT INTO Actors (actorName, sex) VALUES ('Amy Jo Johnson',      'F');
INSERT INTO Actors (actorName, sex) VALUES ('Tangi Miller',        'F');
INSERT INTO Actors (actorName, sex) VALUES ('Jennifer Aniston',    'F');

-- table Series
CREATE TABLE Series (
    seriesId SERIAL      PRIMARY KEY,
    title    VARCHAR(30) NOT NULL
);

INSERT INTO Series (title) VALUES ('The Americans');
INSERT INTO Series (title) VALUES ('The Walking Dead');
INSERT INTO Series (title) VALUES ('Felicity');
INSERT INTO Series (title) VALUES ('Breaking Bad');

-- table Acts
CREATE TABLE Acts (
    seriesId INT NOT NULL,
    actorId  INT NOT NULL,
    PRIMARY KEY (seriesId, actorId),
    FOREIGN KEY (seriesId) REFERENCES Series (seriesId),
    FOREIGN KEY (actorId)  REFERENCES Actors (actorId)
);

-- "The Americans" cast
INSERT INTO Acts VALUES (1, 1);
INSERT INTO Acts VALUES (1, 2);
-- "The Walking Dead" cast
INSERT INTO Acts VALUES (2, 3);
INSERT INTO Acts VALUES (2, 4);
INSERT INTO Acts VALUES (2, 5);
-- "Felicity" cast
INSERT INTO Acts VALUES (3, 1);
INSERT INTO Acts VALUES (3, 6);
INSERT INTO Acts VALUES (3, 7);
INSERT INTO Acts VALUES (3, 8);

-- TODO #1) return all actors/actresses sorted by actorId

-- TODO #2) return all actresses sorted by actorName

-- TODO #3) return the counts of actors and actress using two columns: 'sex' and 'total', sorted by sex

-- TODO #4) return the names of the actors/actresses that were in 'The Americans' sorted by actorName

-- TODO #5) return the names of actors/actresses that didn't appear in any series sorted by actorName
