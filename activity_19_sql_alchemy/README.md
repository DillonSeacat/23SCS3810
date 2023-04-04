# Instructions

This activity will use the **music** database created in the previous activity. Since you will be connecting to the database via SQL Alchemy, you need to setup the following user: 

```
CREATE USER music_admin WITH PASSWORD '135791'; 
GRANT ALL PRIVILEGES ON TABLE albums TO music_admin; 
GRANT ALL PRIVILEGES ON TABLE tracks TO music_admin; 
```

Next, create a virtual environment and install the following modules: 

```
psycopg2
configparser
sqlachemy
```

After installing the required modules, write the following ConfigFile.properties file: 

```
[db]
host=localhost 
port=5432
dbname=music
user=music_manager
password=135791
```

Then, run the code below just to check if you are able to connect to postgres via SQL Alchemy with psycopg2. 

```
import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # TODO: ask the user for a hotel's name and then using prepared statement 
    # show the information about the hotel
    name = input("? ")
    cur = conn.cursor()
    sql = "SELECT * FROM hotels WHERE name = '%s'"
    cur.execute(sql % (name))
    for row in cur:
        print(row)  


    print('Bye!')
    conn.close()
```

If that worked: GREAT! Let's continue. Usually we write each class on its own file, but for simplification let's have everything in the same script. 

```
import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class Track(Base): 
    __tablename__ = "tracks"
    id = Column(Integer, ForeignKey("albums.id"), primary_key=True)
    num = Column(Integer, primary_key=True)
    name = Column(String)

class Album(Base): 
    __tablename__ = "albums"
    id = Column(Integer, primary_key=True)
    title = Column(String)
    artist = Column(String)
    year = Column(Integer)
    tracks = relationship("Track", primaryjoin="Album.id==Track.id")

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

url = URL.create(
    "postgresql+psycopg2",
    username=params['user'],
    password=params['password'],
    host=params['host'],
    port=params['port'],
    database=params['dbname']
)

engine = create_engine(url)
if engine: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(Album)
    for album in query.all():
        print(album.id, album.title, album.artist, album.year)
        for track in album.tracks:
            print("\t", track.num, track.name)
```