"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Student: Dillon Seacat
Description: A simple FMS for projects
"""

import os
import csv

PRJ_FILE_NAME = "projects.csv"
EMP_FILE_NAME = "employees.csv"

class Entity: 
    """
    models an entity's interface with a key
    """

    def get_key(self) -> any:
        """
        defines a method to return an entity's key (used for search purposes)
        """
        pass

class Employee(Entity): 
    """
    models an employee entity with id, name, and department
    """

    def __init__(self, id, name, department) -> None:
        self.id          = id 
        self.name        = name
        self.department  = department

    def get_key(self): 
        """
        an employee's id is defined as the entity's key
        """
        return self.id

    def __str__(self) -> str:
        """
        returns a string representation of an employee object in csv style
        """
        return str(self.id) + "," + self.name + "," + self.department

class Project(Entity): 
    """
    models a project entity with title, start and end dates, budget, and one or more employees
    """

    def __init__(self, title, start, end, budget, employees) -> None:
        self.title     = title 
        self.start     = start
        self.end       = end
        self.budget    = budget
        self.employees = employees

    def get_key(self): 
        """
        a project's title is defined as the entity's key
        """
        return self.title

    def __str__(self) -> str:
        """
        returns a string representation of a project object in csv style
        """
        return self.title + ',' + self.start + ',' + self.end + ',' + str(self.budget)

class CRUD: 
    """
    models a CRUD (Create, Read, Update, and Delete) interface
    """

    def create(self, entity) -> bool: 
        """
        defines a method to create a new entity
        """
        pass

    def read(self, key) -> any: 
        """
        defines a method to search for an entity by its key
        """
        pass 

    def update(self, entity) -> bool: 
        """
        defines a method to update an entity
        """
        pass

    def delete(self, key) -> bool: 
        """
        defines a method to delete an entity by its key
        """
        pass

class ProjectCRUD(CRUD): 
    """
    models a CRUD for project entities
    """

    def create(self, entity) -> bool:
        """
        a project entity should only be created if it does not exist
        """
        key = entity.get_key()
        result = False
        if not self.read(key): 
            try: 
                prj_file = open(os.path.join('db', PRJ_FILE_NAME), "a")
                prj_file.write(str(entity) + '\n')
                try: 
                    if not os.path.exists(os.path.join("db", key)):
                        os.mkdir(os.path.join("db", key))
                    emp_file = open(os.path.join("db", key, EMP_FILE_NAME), "w")
                    for emp in entity.employees: 
                        emp_file.write(str(emp) + '\n')
                finally: 
                    emp_file.close()
                result = True
            finally: 
                prj_file.close()
        return result

    """
    TODO #1: 
        * open db/projects.csv for reading
        * perform a linear search for the project using the provided key
        * if the project is found, return it
        * else, return None
    """
    
    def read(self, key) -> Project: 
        projs = None
        try:
            with open(os.path.join('db', 'projects.csv'), 'r') as file:
                for line in file:
                    line = line.strip()
                    cols = line.split(",")
                    title = (cols[0])
                    if title == key:
                        start = cols[1]
                        end = cols[2]
                        budget = cols[3]
                        employees=([])
                        with open(os.path.join('db',key, 'employees.csv'), 'r') as file:
                            for line in file:
                                line = line.strip()
                                cols = line.split(",")
                                id = str(cols[0])
                                name = cols[1]
                                department = cols[2]
                                employee = Employee(id, name, department)
                                employees.append(employee)
                        projs = Project(title, start, end, budget, employees)
        finally:
            file.close()
        return projs





    def delete(self, key) -> bool: 
        result = False
        if self.read(key): 
            try: 
                file = open(os.path.join("db", PRJ_FILE_NAME), "r")
                lines = file.readlines()
                file.close()
                file = open(os.path.join("db", PRJ_FILE_NAME), "w")
                for line in lines: 
                    line = line.strip()
                    cols = line.split(",")
                    title = cols[0]
                    if title == key:
                        continue
                    file.write(line + "\n")
                result = True
            finally: 
                file.close()
            os.remove(os.path.join("db", key, EMP_FILE_NAME))
            os.rmdir(os.path.join("db", key))
            result = True
        return result
        
class DB:

    """
    TODO #2: 
        * return the employee associated with the (given) id
        * if the employee is not found, return None
    """
    def find_employee(id):
        empList=[]
        try:
            with open(os.path.join('db',title, 'employees.csv'), 'r') as file:
                for line in file:
                    line = line.strip()
                    cols = line.split(",")
                    id = str(cols[0])
                    name = cols[1]
                    department = cols[2]
                    empList = Employee(id, name, department)
                    empList.append(employee)
                    if id in empList:
                       return empList
        finally:
            return None



       
def menu(): 
    print("1. Create")
    print("2. Read")
    print("3. Delete")
    print("4. Quit")
    
if __name__ == "__main__":

    prjCRUD = ProjectCRUD()
    while (True):
        menu()
        option = int(input("? "))
        if option == 1:
            title = input("title? ")
            start = input("start (yyyy-mm-dd)? ")
            end = input("end (yyyy-mm-dd)? ")
            budget = int(input("budget? "))
            employees = []
            print("Now enter employees (first is the manager)!")
            while True:
                line = input("id? ")
                if line == "":
                    break
                id = int(line)
                if DB.find_employee(id): 
                    print('There is already an employee with id ' + str(id) + '!')
                else:
                    name = input("name? ")
                    department = input("department? ")
                    employee = Employee(id, name, department)
                    employees.append(employee)
            project = Project(title, start, end, budget, employees)
            if prjCRUD.create(project): 
                print("New project successfully created!")
            else:
                print("Fail to create a new project!")
        elif option == 2:
            title = input("title? ")
            project = prjCRUD.read(title)
            if project: 
                print(project)
                for emp in project.employees:
                    print('\t' + str(emp))
            else:
                print("Project not found!")
        elif option == 3: 
            title = input("title? ")
            if prjCRUD.delete(title):
                print("Project succcessfully deleted!")
            else:
                print("Fail to delete project!")
        elif option == 4:
            break
        else:
            print("Invalid option!")
    print("Bye!")
