"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Adam Abubakar
Description: A data load script for the IPPS database
"""

import psycopg2
import configparser as cp
import os
import csv


config = cp.RawConfigParser()
config.read('ConfigFile.properties')
params = dict(config.items('db'))
conn = psycopg2.connect(**params)
# check if next line is needed
conn.autocommit = True
if conn: 
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')

    # parse line in file then insert values into the tables
    file = open("../data/MUP_IHP_RY22_P02_V10_DY20_PrvSvc.csv")
    data =list(csv.reader(file))
    # with open(os.path.join("../data","MUP_IHP_RY22_P02_V10_DY20_PrvSvc.csv"), newline= '') as file:
    #     # csv_reader = csv.reader(file, delimiter=',', quotechar='"')
    #     # next(csv_reader)
    #     file.readline() # skip the 1st line
    for cols in data:
        # line = line.strip()
        # i = 0
        # print(line[1])
        # cols = line.split(",")
        xRndrng_Prvdr_CCN = cols[0]
        xRndrng_Prvdr_Org_Name = cols[1]
        xRndrng_Prvdr_St = cols[2]
        xRndrng_Prvdr_City = cols[3]
        xRndrng_Prvdr_State_Abrvtn = cols[4]
        xRndrng_Prvdr_State_FIPS = cols[5]
        xRndrng_Prvdr_Zip5 = cols[6]
        xRndrng_Prvdr_RUCA = cols[7]
        print(xRndrng_Prvdr_RUCA)
        xRndrng_Prvdr_RUCA_Desc = cols[8]
        xDRG_Cd = cols[9]
        xDRG_Desc = cols[10]
        xTot_Dschrgs = cols[11]
        xAvg_Submtd_Cvrd_Chrg = cols[12]
        xAvg_Tot_Pymt_Amt = cols[13]
        xAvg_Mdcr_Pymt_Amt = cols[14]
        # xRndrng_Prvdr_CCN, xRndrng_Prvdr_Org_Name, xRndrng_Prvdr_St, xRndrng_Prvdr_City, xRndrng_Prvdr_State_Abrvtn, xRndrng_Prvdr_State_FIPS, xRndrng_Prvdr_Zip5, xRndrng_Prvdr_RUCA, xRndrng_Prvdr_RUCA_Desc, xDRG_Cd, xDRG_Desc, xTot_Dschrgs, xAvg_Submtd_Cvrd_Chrg, xAvg_Tot_Pymt_Amt, xAvg_Mdcr_Pymt_Amt= line
        # print(xRndrng_Prvdr_CCN, xRndrng_Prvdr_Org_Name, xRndrng_Prvdr_St, xRndrng_Prvdr_City, xRndrng_Prvdr_State_Abrvtn, xRndrng_Prvdr_State_FIPS, xRndrng_Prvdr_Zip5, xRndrng_Prvdr_RUCA, xRndrng_Prvdr_RUCA_Desc, xDRG_Cd, xDRG_Desc, xTot_Dschrgs, xAvg_Submtd_Cvrd_Chrg, xAvg_Tot_Pymt_Amt, xAvg_Mdcr_Pymt_Amt)
        
        
        sqlRUCA = '''
        INSERT INTO RUCA (rndrng_prvdr_ruca, rndrng_prvdr_ruca_desc)
        VALUES ($1 , $2);
        '''
        prepareRUCA = 'prepareRUCA'
       
        sqlProvider = '''
            INSERT INTO Provider (Rndrng_Prvdr_CCN, Rndrng_Prvdr_Org_Name, Rndrng_Prvdr_St, Rndrng_Prvdr_City, Rndrng_Prvdr_State_Abrvtn, Rndrng_Prvdr_State_FIPS, Rndrng_Prvdr_Zip5, ruca_Rndrng_Prvdr_RUCA)
            VALUES($1, $2, $3, $4 , $5, $6, $7, $8)
        '''
        prepareProvider = 'prepareProvider'

        
        sqlConditions = ''' 
            INSERT INTO Conditions(DRG_Cd, DRG_Desc) VALUES ($1, $2)
        '''
        prepareCondition = 'prepareCondition'
        
        sqlBillings = '''
            INSERT INTO Billing(provider_Rndrng_Prvdr_CCN, conditions_DRG_Cd, Tot_Dschrgs, Avg_Submtd_Cvrd_Chrg, Avg_Tot_Pymt_Amt, Avg_Mdcr_Pymt_Amt)
            VALUES($1, $2, $3, $4, $5, $6)
        '''
        prepareBilling = 'prepareBilling'

        cur = conn.cursor()
        
        try:
            cur.execute('PREPARE {} AS {}'.format(prepareRUCA, sqlRUCA))
            cur.execute('EXECUTE {} (%s, %s)'.format(prepareRUCA), (xRndrng_Prvdr_RUCA, xRndrng_Prvdr_RUCA_Desc))
        except Exception as e:
            print(e)
            conn.rollback()
        else:
            conn.commit()

        try:
            cur.execute('PREPARE {} AS {}'.format(prepareProvider, sqlProvider))
            cur.execute('EXECUTE {} (%s, %s, %s, %s, %s, %s, %s, %s)'.format(prepareProvider), 
                (xRndrng_Prvdr_CCN, xRndrng_Prvdr_Org_Name, xRndrng_Prvdr_St, xRndrng_Prvdr_City, 
                 xRndrng_Prvdr_State_Abrvtn, xRndrng_Prvdr_State_FIPS, xRndrng_Prvdr_Zip5, xRndrng_Prvdr_RUCA))
        except Exception as e:
            print(e)
            conn.rollback()
        else:
            conn.commit()

        try:
            cur.execute('PREPARE {} AS {}'.format(prepareCondition, sqlConditions))
            cur.execute('EXECUTE {} (%s, %s)'.format(prepareCondition), (xDRG_Cd, xDRG_Desc))
            
        except Exception as e:
            print(e)
            conn.rollback()
        else:
            conn.commit()
        try:
            cur.execute('PREPARE {} AS {}'.format(prepareBilling, sqlBillings))
            cur.execute('EXECUTE {} (%s, %s, %s, %s, %s, %s)'.format(prepareBilling), (xRndrng_Prvdr_CCN, xDRG_Cd, xTot_Dschrgs, xAvg_Submtd_Cvrd_Chrg, xAvg_Tot_Pymt_Amt, xAvg_Mdcr_Pymt_Amt))
        except Exception as e:
            print(e)
            conn.rollback()
        else:
            conn.commit()
        
             
          
    print('Bye!')
    conn.close()
