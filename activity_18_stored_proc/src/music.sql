CREATE DATABASE music; 

\c music

CREATE TABLE albums ( 
  id SERIAL NOT NULL PRIMARY KEY, 
  title VARCHAR(30) NOT NULL, 
  artist VARCHAR(30) NOT NULL, 
  year INT NOT NULL 
); 

CREATE TABLE tracks ( 
  id INT NOT NULL, 
  num INT NOT NULL, 
  name VARCHAR(30) NOT NULL, 
  PRIMARY KEY (id, num), 
  FOREIGN KEY (id) REFERENCES albums (id) 
); 

INSERT INTO Tracks VALUES (1, 1, 'Roots Bloody Roots'); 
INSERT INTO Tracks VALUES (1, 2, 'Attitude'); 
INSERT INTO Tracks VALUES (1, 3, 'Ratamahatta'); 
INSERT INTO Tracks VALUES (2, 1, 'Morbid Visions'); 
INSERT INTO Tracks VALUES (2, 2, 'Mayhem'); 

CREATE FUNCTION check_year(year INT) RETURNS INT
    LANGUAGE plpgsql
    AS 
    $$
        BEGIN
            IF year >= 1950 THEN 
                RETURN year; 
            ELSE 
                RAISE EXCEPTION 'Year is invalid!!!';
            END IF;
        END;
    $$;

CREATE PROCEDURE number_albums(IN art VARCHAR(30))
    LANGUAGE plpgsql
    AS 
    $$
        BEGIN
            PERFORM COUNT(*) FROM Albums WHERE Albums.artist = art; 
        END;
    $$;



