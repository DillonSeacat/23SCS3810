"""
CS3810: Principles of Database Systems
Instructor: Thyago Mota
Description: A simple hierarchical db for courses enrollment
"""

import os

class Entity: 
    """
    models an entity's interface with a key
    """

    def get_key(self) -> any:
        """
        defines a method to return an entity's key (used for search purposes)
        """
        pass

class Course(Entity): 
    """
    models a course entity with prefix, code, and description
    """

    def __init__(self, prefix, code, description) -> None:
        self.prefix      = prefix 
        self.code        = code
        self.description = description

    def get_key(self): 
        """
        a course's prefix and code are defined as the entity's key
        """
        return self.prefix, self.code

    def __str__(self) -> str:
        """
        returns a string representation of a course object in csv style
        """
        return self.prefix + "," + str(self.code) + "," + self.description

class Section(Entity): 
    """
    models a course section entity with course prefix, course code, section number, and instructor name
    """

    def __init__(self, course, year, semester, number, instructor) -> None:
        self.course     = course
        self.year       = year
        self.semester   = semester
        self.number     = number 
        self.instructor = instructor

    def get_key(self): 
        """
        a section's course and number are defined as the entity's key
        """
        return self.course, self.number

    def __str__(self) -> str:
        """
        returns a string representation of a section object in csv style
        """
        return str(self.course) + "," + str(self.year) + "," + self.semester + "," + self.number + "," + self.instructor

class Student(Entity): 
    """
    models a student entity with id and name
    """

    def __init__(self, id, name) -> None:
        self.id   = id
        self.name = name 

    def get_key(self): 
        """
        a student's id is defined as the entity's key
        """
        return self.id

    def __str__(self) -> str:
        """
        returns a string representation of a student object in csv style
        """
        return str(self.id) + "," + self.name

class DB: 

    def list_courses() -> list: 
        """
        TODO #1: list all courses
        """
        courses = []
        with open(os.path.join('db', 'courses.csv'), 'r') as file:
            for line in file:
                line = line.strip()
                prefix, number, description = line.split(',')
                course = Course(prefix, number, description)
                courses.append(course)
            return courses

        

    def list_sections(course) -> list: 
        """
        TODO #2: list all sections of a course
        """
        sections = []
        with open(os.path.join('db', course.prefix + str(course.code), 'sections.csv'), 'r') as file:
            for line in file:
                line = line.strip()
                year, semester,  number, instructor = line.split(',')
                year = int(year)
                section = Section(course, year, semester, number, instructor)
                sections.append(section)
            return sections

    def list_students(section) -> list:
        """
        TODO #3: list all students enrolled in a section
        """
        pass

    def list_schedule(id, year, semester) -> list:
        """
        TODO #4: list a student's schedule
        """
        pass

def menu(): 
    print("1. List all courses")
    print("2. List sections of a course")
    print("3. List students enrolled in a course section")
    print("4. List a student schedule")
    print("5. Quit")

if __name__ == "__main__":

    while (True):
        menu()
        option = int(input("? "))
        if option == 1:
            print("Courses:")
            for course in DB.list_courses():
                print(course)
            print()
        elif option == 2:
            prefix = input("prefix? ")
            code = int(input("code? "))
            course = Course(prefix, code, "")
            print("Sections of " + str(course) + ":")
            for section in DB.list_sections(course):
                print(section)
        elif option == 3: 
            prefix = input("prefix? ")
            code = int(input("code? "))
            course = Course(prefix, code, "")
            year = int(input("year? "))
            semester = input("semester? ")
            number = input("number? ")
            section = Section(course, year, semester, number, "")
            print("Students enrolled in " + str(section) + ":")
            for student in DB.list_students(section):
                print(student)
        elif option == 4: 
            id = int(input("id? "))
            year = int(input("year? "))
            semester = input("semester? ")
            print("Schedule for student with id " + str(id) + ": ")
            for section in DB.list_schedule(id, year, semester):
                print(section)
        elif option == 5:
            break
        else:
            print("Invalid option!")
    print("Bye!")
