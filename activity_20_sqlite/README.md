# Instructions

This activity illustrates how to setup a database using SQLite. 

## Database Script

Save the following SQL script named **pls.sql**. 

```
CREATE TABLE pls (
    id INT PRIMARY KEY, 
    name VARCHAR(50) NOT NULL
);

INSERT INTO pls VALUES 
    (1, 'Python'), 
    (2, 'Java'), 
    (3, 'SQL');
```

## Database Setup

Create a new virtual environment and write the following python script named **dbsetup.py**. 

```
import sqlite3

conn = sqlite3.connect('pls.db')
with open('pls.sql') as f:
    conn.executescript(f.read())
conn.commit()
print('done!')
```

After the script runs, a new file named **pls.db** is created. That file is your SQLite database!

## Database Query

Write the following python script named **testdb.py**: 

```
import sqlite3

conn = sqlite3.connect('pls.db')
cur = conn.cursor()
sql = 'SELECT * FROM pls'
cur.execute(sql)
for row in cur.fetchall():
    print(row)
conn.close()
```

# SQLAlchemy + SQLite Integration 

Try the code below. Make sure you create a virtual environment with SQLAlchemy installed.  

```
import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class PL(Base): 
    __tablename__ = "pls"
    id = Column(Integer, primary_key=True)
    name = Column(String)


engine = create_engine('sqlite:///pls.db')
if engine: 
    print('Connection to Postgres database was successful!')
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(PL)
    for pl in query.all():
        print(pl.id, pl.name)
```