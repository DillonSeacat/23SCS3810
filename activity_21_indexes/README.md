# Instructions

This activity will illustrate how query efficiency can be improved with the use of indexes.  To begin this activity, create the sample database based on the following SQL schema:  

```
CREATE DATABASE sample; 

\c sample; 

CREATE TABLE Sample ( 
  id INT NOT NULL PRIMARY KEY, 
  rnd INT NOT NULL 
); 
```

Use postgres' copy command to populate the Sample table with increasingly larger files. Between the loads you will perform two queries on the non-prime attribute "rnd": before and after an index on that attribute has been created. You will record how long it takes for postgres to answer those queries and whether using an index affects those query response times.  

Since I am very nice, I am giving you the syntax for data loading in postgres. 

```
-- replace ? by 1, 2, 3, or 4 depending which file you want to load 
DELETE FROM Sample;
\copy Sample from /var/lib/postgresql/data/sample4.csv DELIMITER ',' CSV HEADER;
```

In between queries you should run the following statements: 

```
DROP INDEX rnd; 
CREATE INDEX rnd ON Sample(rnd); 
```

Files to use:  

* sample1.csv (10KB to a final Sample size of 1K rows); 
* sample2.csv (1.2MB to a final Sample size of 100K rows); 
* sample3.csv (11.6MB to a final Sample size of 1M rows); 
* sample4.csv (125MB to a final Sample size of 10M rows). 

To make the searches to the worst-case (ie, the value is NOT to be found) let's always search for 1000000. 

```
SELECT * FROM Sample WHERE rnd = 1000000; 
```

Record your times and discuss with your classmate! Important, to enable timing on postgress use: 

```
\timing
```

You might want to average the times a few times (like 3x). 
