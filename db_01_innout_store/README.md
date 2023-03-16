# Introduction

In this project you are asked to design and implement a database for a fictional convenience store named "In-N-Out Store". In addition, you will be required to populate the tables of you database with fake data for testing purposes. To illustrate, below are some items found in the store and their correspondent categories. 

```
 description | category  
-------------+-----------
 bread       | bakery
 coffee      | beverages
 eggs        | dairy
 gum         | 
 ham         | meat
 milk        | dairy
 pizza       | frozen
```

At the end of this project, you will use your database to answer a few queries using SQL. 

![pic1.png](pics/pic1.png)

The "In-N-Out Store" logo.

# Part A: Database Design

The purpose of the "In-N-Out" database is to support analytical queries such as "most wanted items by customers", "general sales information", and "shopping habits in general". The minimum data requirements for the database are described below: 

* customers are uniquely identified by an id number; 
* at a minimum, the system stores customer names and gender; 
* all items sold by the store need also to be saved in the database; 
* each item has a unique code, a description, a price, and a category; 
* some items may not have a category assigned to them; 
* each item category is uniquely identified by a 3-letter code but they also have long descriptions;
* sales information (i.e., what items customers buy each day/time, how many items, and the how much they paid) also needs to be recorded by the system;
* the system needs to maintain the current price of each individual item AND the price paid for an item during each individual sale (this is done to allow item prices to be updated while maintaining historical sales information). 

Your database design should be submitted as an ER diagram in crows-foot format and in a file named **innout.erd**. Use the provided file template and make sure to add your name (and the name of your partner, if working in pairs) in the comments section of the file. 

# Part B: Database Implementation

Make sure your database implementation meets the following requirements: 

* the database must be named **innout**;
* all table names should have the first letter of each word capitalized; 
* all table names should be in the plural form;
* all tables must have a primary key; 
* all attribute names of a table must be in lowercase (compound words should be connected using underscore);
* foreign attributes must be renamed to improve readability;
* customer id's must be auto-generated;
* customer's gender identification is optional and it is up to you how many different types of gender you want to represent in your database; however, if a gender value is not provided, the value for the attribute should default to '?';
* name and description attributes should always be provided; 
* all items must have their current price; 
* all sales must store the price paid for an item;
* the quantity of an item in a purchase must always be informed;
* the date and time of a purchase must always be informed;
* some items may not have a category: in that case, the category value should be set to NULL;
* all foreign keys must be set whenever appropriate. 

Your database implementation will be evaluated based on names used for tables and attributes, data types for attributes, primary and foreign key constraints, and nullable constraints. All of the above requirements will also be checked. 

The following categories MUST be represented in the system: 

* BVR for beverages
* DRY for dairy
* PRD for produce (fruits and vegetables)
* FRZ for frozen
* BKY for bakery
* MEA for meat

It is up to you if you want to add other categories. 

You must have at least 5 (five) customers, and at least one of them without informed gender (again, the value in that case should default to '?' automatically). In addition, you must also have at least one item from each of the categories, EXCEPT produce. Finally, one of the items should NOT have a category at all. Add fake sales data, making sure that at least one of the customers does not have any purchase at all. 

Your database implementation, together with all insert statements, should be submitted as an SQL script in a file named **innout.sql**. Use the provided template. 

# Part C: SQL Queries

Write the SQL for the following queries: 

a) all customer names in alphabetical order

b) number of items (labeled as total_items) in the database 

c) number of customers (labeled as number_customers) by gender

d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)

e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category

f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order

g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement

HINT: to set a variable in postgres use the following syntax. 

```
\set variable value
```

To use a variable in an SQL statement, just prefix its name with colon. 

```
SELECT :variable;
```

h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).

i) the total amount of sales per day showing the date and the total amount paid in chronological order

j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)

k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)

l) the name of the customers who never made a purchase 

# Submission 

Zip **innout.erd** and **innout.sql** files into **innout.zip**. Upload the zip to Canvas. 

```
innout.zip
|__innout.erd
|__innout.sql 
```

# Rubric 

```
+20 Part A (database design)
+45 Part B (database implementation)
    +30 table create statements 
    +15 database insert statements
+35 Part C (SQL queries): ~+3 points per query
```