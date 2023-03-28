-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Dillon Seacat
-- Description: SQL for the In-N-Out Store

DROP DATABASE innout;

CREATE DATABASE innout;

\c innout

-- TODO: table create statements
    CREATE TABLE Customers (
        id SERIAl PRIMARY KEY,
        name VARCHAR(50) NOT NULL,
        gender CHAR(1) DEFAULT '?' CHECK (gender IN('M', 'F', '?'))
    );

    CREATE TABLE Categories (
        code CHAR(3) PRIMARY KEY,
        description VARCHAR(30) NOT NULL
    );

    CREATE TABLE Items (
        code INT PRIMARY KEY,
        description VARCHAR(50) NOT NULL,
        price REAL NOT NULL,
        category_code CHAR(3),
        FOREIGN KEY (category_code) REFERENCES Categories (code)
    );


    CREATE TABLE Sales (
        id SERIAL PRIMARY KEY,
        customer_id INT NOT NULL,
        item_code INT NOT NULL,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        date DATE NOT NULL,
        time TIME NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES Customers (id),
        FOREIGN KEY (item_code) REFERENCES Items (code)
    );


-- TODO: table insert statements
    INSERT INTO Categories (code, description) VALUES 
    ('BVR', 'Beverages'),
    ('DRY', 'Dairy'),
    ('PRD', 'Produce(fruits and vegetables)'),
    ('FRZ', 'Frozen'),
    ('BKY', 'Bakery'),
    ('MEA', 'Meat');

    INSERT INTO Items (code, description, price, category_code) VALUES 
    ('001', 'Coke', .99, 'BVR'),
    ('002', 'Milk', 2.99, 'DRY'),
    ('003', 'Bananas', .59, 'PRD'),
    ('004', 'Rolls', 1.99, 'BKY'),
    ('005', 'Chicken', 5.99, 'MEA'),
    ('006', 'Pizza', 4.99, 'FRZ');
    INSERT INTO Items(code, description, price) VALUES
    ('007', 'Brush', 2.99);

    INSERT INTO Customers (name, gender) VALUES 
    ('Dillon Seacat', 'M'),
    ('Caitlyn Seacat', 'F'),
    ('Matt Seacat', 'M'),
    ('April Seacat', 'F'),
    ('Robert Seacat', '?');
    

    INSERT INTO Sales (customer_id, item_code, price, quantity, date, time) VALUES 
    (1, '001', .99, 2, '2023-03-18', '06:00:00'),
    (2, '002', 2.99, 2, '2023-03-18', '07:00:00'),
    (3, '003', .59, 3, '2023-03-18', '08:00:00'),
    (4, '004', 1.99, 1, '2023-03-18', '09:00:00'),
    (4, '004', 1.99, 2, '2023-03-18', '10:00:00'),
    (4, '005', 5.99, 1, '2023-03-18', '11:00:00'),
    (4, '006', 4.99, 2, '2023-03-18', '12:00:00'),
    (4, '007', 2.99, 1, '2023-03-18', '12:00:00');


-- TODO: SQL queries

-- a) all customer names in alphabetical order
    SELECT name FROM Customers ORDER BY name;
-- b) number of items (labeled as total_items) in the database 
    SELECT COUNT(*) AS total_items FROM Items;
-- c) number of customers (labeled as number_customers) by gender
    SELECT gender, COUNT(*) AS number_customers FROM Customers GROUP BY gender;
-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)
    SELECT i.code, i.description, c.description AS category
    FROM Items i INNER JOIN Categories c ON i.category_code = c.code ORDER BY i.code;
-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category
    SELECT code, description FROM Items WHERE category_code IS NULL ORDER BY code;
-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order
    SELECT description AS category FROM Categories WHERE code NOT IN
    (SELECT category_code FROM Items WHERE category_code IS NOT NULL)
    ORDER BY description;
-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement
    \set ID 1;
    SELECT * FROM Customers WHERE id = :ID;
-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).
    SELECT s.date, s.time, i.description AS item, s.quantity AS qtt,
    s.price, s.quantity*s.price AS total_paid FROM Sales s INNER JOIN Items i
    ON s.item_code = i.code WHERE s.customer_id  = :ID;
-- i) the total amount of sales per day showing the date and the total amount paid in chronological order
    SELECT date, SUM(price*quantity) AS total_amount FROM Sales
    GROUP BY date ORDER BY date;
-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)
    SELECT i.description AS item, SUM(s.price*s.quantity) AS total_paid
    FROM Sales s INNER JOIN Items i ON s.item_code = i.code
    GROUP BY i.description ORDER BY total_paid DESC LIMIT 1;
-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)
    -- Select the top 3 items in number of sales and their respective quantities
    SELECT i.description AS item, SUM(s.quantity) AS total
    FROM Items i JOIN Sales s ON i.code = s.item_code
    GROUP BY i.description ORDER BY total DESC LIMIT 3;

-- l) the name of the customers who never made a purchase 
    SELECT c.name FROM Customers c LEFT JOIN Sales s
    ON c.id = s.customer_id WHERE s.customer_id IS NULL;