# Introduction

This activity walks you through the steps to connect and run SQL queries in Python using the **psycopg**, Python's most popular Postgres module. More info about **psycopg** can be found at [https://pypi.org/project/psycopg2/](https://pypi.org/project/psycopg2/).

# Virtual Environment 

**Virtualenv** is a tool that allows python developers create isolated build environments. Follow steps described [here](https://virtualenv.pypa.io/en/latest/installation.html) to install **virtualenv**. 

Once you have **virtualenv** installed, you can setup a virtual environment for your project (let's say under **build**) running:

```
virtualenv build
cd build
source bin/activate
```

Note: depending on your version of Windows you may need to activate your virtualenv using: 

```
bin\activate.bat
```

OR 

```
Scripts\activate.bat
```

Once "in" the virtual environment, you can install all of the packages required for your project (without the risk of conflicts with other projects). 

To leave the virtual environment just run "deactivate". 

# Install psycopg (version 2)

```
pip3 install psycopg2
```

Note: if the command above doesn't work, try installing the binary version of the module: 

```
pip3 install psycopg2-binary
```

# Restart Postgress

This time, let's map the internal (containter) Postgres port to your computer's port using the following (making sure you update the command using your own settings for the volume mapping):

```
docker run --rm --name postgres -e POSTGRES_PASSWORD=135791 -v /Users/tmota/devel/teach/__23SCS3810_DB/postgres:/var/lib/postgresql/data -p 5432:5432 postgres
```

# Connect to Postgress from Python

Type the code below (save it as **testdb.py**), making sure you have database "hr" created (use psql to verify that). 

```
import psycopg2

params = {
    'host': 'localhost', 
    'port': 5432, 
    'dbname': 'hr', 
    'user': 'hr_admin',
    'password': '135791'
}

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    print('Bye!')
    conn.close()
```

Run **testdb.py** and verify that you are able to connect to postgres. If everything works you should get a message saying:

```
Connection to Postgres database hr was successful!
Bye!
```

# Run a Simple Query
Add the following lines of code right-after the connection but before the call to close.

```
    cur = conn.cursor()
    sql = 'SELECT id, name FROM employees'
    cur.execute(sql)
    for row in cur.fetchall(): 
        print(row)
```

Run your code again. You should be able to see the rows from table **Employees**.

# Final Note

The example here exposes the database password in the code which is bad practice that you should avoid. On the next activity we will discuss alternatives to properly secure your password in a program that access a database. 

# Further Practice

Remember the **hotels** database? Do you think you can write a Python script to connect to the **hotels** database?