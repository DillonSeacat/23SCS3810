# Part 1

In this first part, you will simulate a "phantom read" scenario. You will need to open two psql sessions, both operating on the **bank** database (create in the previous activity). Let's name them session **A** and **B** to avoid confusion. 

Use the following commands in psql session **A**. 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
SELECT * FROM Accounts;
-- pause 
```

Switch to psql session **B** and do the following: 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
INSERT INTO Accounts VALUES (303, 'Thyago Mota', 50000);
COMMIT;
```

Now, switch back to session **A** and run the select statement again. You should be able to see a "phantom row". 

```
SELECT * FROM Accounts;
```

# Part 2

In this second part, you will avoid the "phantom read" scenario by increasing the isolation level. Use the following commands in psql session **A**. 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM Accounts;
-- pause 
```

Switch to psql session **B** and do the following: 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
INSERT INTO Accounts VALUES (404, 'The Joker', 500000);
COMMIT;
```

Now, switch back to session **A** and run the select statement again. You should not be able to see the "phantom row" this time. 

```
SELECT * FROM Accounts;
```