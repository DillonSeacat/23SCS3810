-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): 
-- Description: SQL for the In-N-Out Store

DROP DATABASE innout;

CREATE DATABASE innout;

\c innout

-- TODO: table create statements

-- TODO: table insert statements

-- TODO: SQL queries

-- a) all customer names in alphabetical order

-- b) number of items (labeled as total_items) in the database 

-- c) number of customers (labeled as number_customers) by gender

-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)

-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category

-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order

-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement

-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).

-- i) the total amount of sales per day showing the date and the total amount paid in chronological order

-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)

-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)

-- l) the name of the customers who never made a purchase 