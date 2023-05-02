# Instructions

Begin this assignment by running the **camp.sql** script that creates the **camp** database. Next, study the database schema and make sure you understand the relationships between the entities **programs** and **campers**. 

# Programs and Campers 

Your task is to finish a Python script that does ORM (Object-Relational Mapping) using SQLAlchemy to represent a many-many relationship between tables **programs** and **campers**. 

Finish the 5 TO-DO's embedded in the code. 

Example session for **homestead**: 

```
name? homestead
{homestead,Our youngest adventurers learn how to make new friends, 
discover self-confidence, and learn independence,5000.0}
        {1,Achiles,2011-01-01,male}
        {2,Apollo,2011-02-01,male}
        {3,Aphrodite,2011-03-01,female}
```

Example session for **outpost**: 

```
name? outpost
{outpost,Campers experience rewarding trips in the backcountry with the 
guidance and support of counselors,5500.0}
        {4,Isis,2011-04-01,?}
```

Example session when program does not exist: 

```
name? databases
Program does not exist!
```

# Submission 

You only need to submit **campers.py** file for this assignment. 

# Rubric 

+1 point for each TO-DO completed!
