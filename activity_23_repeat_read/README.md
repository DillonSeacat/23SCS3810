# Part 1

In this first part, you will simulate a "non-repeatable read" scenario. You will need to open two psql sessions, both operating on the **bank** database (create in the previous activity). Let's name them session **A** and **B** to avoid confusion. 

Use the following commands in psql session **A**. 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
SELECT balance FROM Accounts WHERE number = 101;
-- pause 
```

Switch to psql session **B** and do the following: 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
UPDATE Accounts SET balance = 5000 WHERE number = 101;
COMMIT;
```

Now, switch back to session **A** and run the select statement again. You will see the update, therefore having two different responses for a query within the same transaction. 

```
SELECT balance FROM Accounts WHERE number = 101;
```

# Part 2

In this second part, you will simulate a "repeatable read" scenario. Use the following commands in psql session **A**. 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT balance FROM Accounts WHERE number = 101;
-- pause 
```

Switch to psql session **B** and do the following: 

```
\c bank
\set AUTOCOMMIT OFF
START TRANSACTION;
UPDATE Accounts SET balance = 10000 WHERE number = 101;
COMMIT;
```

Now, switch back to session **A** and run the select statement again. You should not be able to see the update this time. 

```
SELECT balance FROM Accounts WHERE number = 101;
```