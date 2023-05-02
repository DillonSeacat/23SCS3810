# Instructions

Consider the **books** database in MongoDB. 

```
// db creation
use books;

db.books.insertOne({
  isbn: '1933988673',
  title: 'Unlocking Android',
  author: 'Charlie Collins',
  date: { year: 2009, month: 4 },
  pages: 250
});

db.books.insertOne({
  isbn: '1935182722',
  title: 'Android in Action, Second Edition',
  author: 'Robi Sen',
  date: { year: 2011, month: 1 },
  pages: 120
});

db.books.insertOne({
  isbn: '1617290084',
  title: 'Specification by Example',
  author: 'Gojko Adzic',
  date: { year: 2011, month: 6 },
  pages: 840
});

db.books.insertOne({
  isbn: '1933988797',
  title: 'Flex on Java',
  author: 'Andres Almiray',
  date: { year: 2010, month: 10 },
  pages: 95
});

db.books.insertOne({
  isbn: '1617291609',
  title: 'MongoDB in Action',
  author: 'Kyle Banker',
  date: { year: 2012, month: 5 },
  pages: 350
});
```

Answer the following queries using MongoDB's query language. Submit a javascript file named **books.js** on Canvas. 


// list all books
db.books.find({})

// list all book titles
db.books.find({}, {'title': 1})

// list all books written by X, where X is an author that you know is listed in your collection
db.books.find({author: 'Kyle Banker'})

// list all books published in Y, where Y is a year
db.books.find({'date.year': 2012})

// list all books that have more than 100 pages but less than 500 pages
db.books.find({$and: [{pages: {$gt: 100}}, {pages: {$lt: 500}}]})
db.books.find({pages:{$gt:100,$lt:500}})

```