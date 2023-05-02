# Instructions

Connect to MongoDB and then create the **students** database and a collection with the same name according to the commands below. 

```
// open fresh database name students
use students

// create a new collection also name students
db.createCollection("students")

// insert some documents into students
db.students.insert({"id": 1, "name": "John"})
db.students.insert({"id": 2, "name": "Anna", "courses": ["CS120", "CS265"]})
db.students.insert({"name": "Jane", "year": 2022, "major": "Chemistry"})

// list all of the documents in students
print("list all of the documents in students:")
db.students.find()

// a simple select
print("a simple select:")
db.students.find({"year": 2022})

// a simple projection
print("a simple projection:")
db.students.find({}, {"name": 1})

// a selection and projection
print("a selection and projection:")
db.students.find({"year": 2022}, {"name": 1})
```