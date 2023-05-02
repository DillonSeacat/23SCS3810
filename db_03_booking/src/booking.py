"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student(s): Dillon Seacat
Description: A room reservation system
"""

import psycopg2
from psycopg2 import extensions, errors
import configparser as cp
from datetime import datetime

def menu(): 
    print('1. List')
    print('2. Reserve')
    print('3. Delete')
    print('4. Quit')

def db_connect():
    config = cp.RawConfigParser()
    config.read('ConfigFile.properties')
    params = dict(config.items('db'))
    conn = psycopg2.connect(**params)
    conn.autocommit = False 
    with conn.cursor() as cur: 
        cur.execute('''
            PREPARE QueryReservationExists AS 
                SELECT * FROM Reservations 
                WHERE abbr = $1 AND room = $2 AND date = $3 AND period = $4;
        ''')
        cur.execute('''
            PREPARE QueryReservationExistsByCode AS 
                SELECT * FROM Reservations 
                WHERE code = $1;
        ''')
        cur.execute('''
            PREPARE NewReservation AS 
                INSERT INTO Reservations (abbr, room, date, period) VALUES
                ($1, $2, $3, $4);
        ''')
        cur.execute('''
            PREPARE UpdateReservationUser AS 
                UPDATE Reservations SET "user" = $1
                WHERE abbr = $2 AND room = $3 AND date = $4 AND period = $5; 
        ''')
        cur.execute('''
            PREPARE DeleteReservation AS 
                DELETE FROM Reservations WHERE code = $1;
        ''')
    return conn

# TODO: display all reservations in the system using the information from ReservationsView
def list_op(conn):
    with conn.cursor() as cur:
        cur.execute('SELECT * FROM ReservationsView')
        rows = cur.fetchall()
        if rows:
            print('code,date,period,start,end,building-room,user')
            for row in rows:
                print(','.join(str(val) for val in row))
        else:
            print('No reservations found.')


# TODO: reserve a room on a specific date and period, also saving the user who's the reservation is for
def reserve_op(conn): 
    abbr = input("Building abbreviation: ")
    room = input("Room number: ")
    date = input("Date (YYYY-MM-DD): ")
    period = input("Period of the day (A-H): ")
    user = input("User name: ")

    # Set isolation level to serializable
    conn.set_isolation_level(extensions.ISOLATION_LEVEL_SERIALIZABLE)

    try:
        with conn.cursor() as cur:
            # Check if room is available
            cur.execute("EXECUTE QueryReservationExists (%s, %s, %s, %s);", (abbr, room, date, period))
            reservation_exists = cur.fetchone() is not None

            if reservation_exists:
                print("Sorry, this room is already reserved for the selected date and period.")
                return

            # Secure the booking
            cur.execute("EXECUTE NewReservation (%s, %s, %s, %s);", (abbr, room, date, period))
            booking_code = cur.lastrowid

            # Update reservation with user info
            cur.execute("EXECUTE UpdateReservationUser (%s, %s, %s, %s, %s);", (user, abbr, room, date, period))

        # Commit transaction
        conn.commit()

        print(f"Reservation {booking_code} for {abbr}-{room} on {date} ({period}) has been made for {user}.")
    except errors.DeadlockDetected:
        # Rollback transaction on deadlock
        conn.rollback()
        print("Sorry, there was a problem with the booking process. Please try again.")


# TODO: delete a reservation given its code
def delete_op(conn):
    reservation_code = input('Enter the reservation code to be deleted: ')
    try:
        conn.set_isolation_level(extensions.ISOLATION_LEVEL_SERIALIZABLE)
        with conn.cursor() as cur:
            cur.execute('EXECUTE QueryReservationExistsByCode (%s);', (reservation_code,))
            result = cur.fetchone()
            if result:
                cur.execute('EXECUTE DeleteReservation (%s);', (reservation_code,))
                print('Reservation deleted successfully.')
                conn.commit()
            else:
                print('Reservation not found.')
    except errors.TransactionRollbackError:
        print('Transaction rolled back.')
        conn.rollback()
    except Exception as e:
        print(f'Error occurred: {str(e)}')
        conn.rollback()


if __name__ == "__main__":
    with db_connect() as conn: 
        op = 0
        while op != 4: 
            menu()
            op = int(input('? '))
            if op == 1: 
                list_op(conn)
            elif op == 2:
                reserve_op(conn)
            elif op == 3:
                delete_op(conn)