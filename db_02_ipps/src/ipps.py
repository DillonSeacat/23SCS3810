"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): 
Description: A data load script for the IPPS database
"""

import psycopg2
import configparser as cp

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))

conn = psycopg2.connect(**params)
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    print('Bye!')
    conn.close()