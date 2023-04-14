import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
conn.autocommit = True
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')
    id = input('id? ')
    sql = '''
        prepare statement as 
        SELECT * FROM Grades 
        WHERE id = $1;
    '''
    cur = conn.cursor()
    cur.execute(sql) 
    cur.execute("execute statement (%s)", (id))
    for row in cur:
        print(row)  

    print('Bye!')
    conn.close()