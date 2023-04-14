# Instructions 

In this assignment you are asked to create a trigger for auditing purposes. The trigger should automatically insert audit information into a specific table whenever a new employee is added to the database. 

Begin by creating the **audit** database according to the **audit.sql** shared with you and described below: 

```
DROP DATABASE audit;

CREATE DATABASE audit;

\c audit

CREATE TABLE Employees (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
); 

CREATE TABLE EmployeesAudit (
    seq SERIAL PRIMARY KEY, 
    date DATE NOT NULL, 
    descr VARCHAR(200) NOT NULL
);
```

After the **audit** database is created, create a "trigger" function called **employee_audit_after_insert** inserts a new **EmployeesAudit** record with the current date (hint: use postgres' **CURRENT_DATE**) and a concatenation of the employee's id and name (separated by comma). For example, if employee "id: 101, name: Samuel Adams" is inserted into table **Employees**, then the following should be added automatically into table **EmployeesAudit**: 

```
 seq |    date    |      descr       
-----+------------+------------------
   1 | 2023-04-06 | 101,Samuel Adams
```

Of course the sequence number may vary depending on the order of inserts since it is an auto-incremented field. 

The actuall trigger should be named **employee_audit**. 

# Submission

You only need to submit your final **audit.sql** script to Canvas. 

# Rubric

```
+2 trigger function
+3 trigger
```
