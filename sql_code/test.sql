CREATE TABLE users (
    ID TEXT,
    Name TEXT,
    Age INTEGER
);

INSERT INTO users (ID, Name, Age)
VALUES ('001', 'Alice', 25);

ALTER TABLE users
ADD COLUMN Email TEXT;

ALTER TABLE users
DROP COLUMN Email;

DROP TABLE users;

CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER
);

CREATE TABLE scores (
    StudentID INTEGER,
    CourseID INTEGER,
    Score INTEGER,
    PRIMARY KEY (StudentID, CourseID)
);

CREATE TABLE departments (
    DepartmentID INTEGER PRIMARY KEY,
    DepartmentName TEXT
);

CREATE TABLE employees (
    EmployeeID INTEGER PRIMARY KEY,
    Name TEXT,
    DepartmentID INTEGER REFERENCES departments(DepartmentID)
);

DROP TABLE users;

CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Email TEXT UNIQUE
);

DROP TABLE users;

CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER CHECK (Age >= 18 AND Age <= 65)
);

CREATE TABLE products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    Price REAL,
    DiscountPrice REAL,
    CONSTRAINT PriceCheck CHECK (Price >= DiscountPrice)
);

INSERT INTO products (ProductID, ProductName, Price, DiscountPrice)
VALUES (1, 'Laptop', 1000.00, 800.00),
       (2, 'Smartphone', 500.00, 450.00),
       (3, 'Tablet', 300.00, 250.00);

DROP TABLE users;
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER DEFAULT 18
);
INSERT INTO users (ID, Name)
VALUES ('1', 'Alice'),
       ('2', 'Bob'),
       ('3', 'Charlie');

UPDATE users
SET Age = Age + 1;

DROP TABLE employees;

CREATE TABLE employees (
    ID TEXT,
    Name TEXT,
    Age INTEGER,
    Department TEXT
);

INSERT INTO employees (ID, Name, Age, Department)
VALUES ('001', 'Alice', 25, 'HR'),
       ('002', 'Bob', 30, 'IT'),
       ('003', 'Charlie', 35, 'Finance'),
       ('004', 'Alice', 28, 'IT');

SELECT Name
FROM employees
WHERE Age < 30;


DROP TABLE products;

CREATE TABLE products (
    id INT,
    name TEXT,
    price REAL
);
INSERT INTO products (id, name, price) VALUES
(1, 'Product A', 10.0),
(2, 'Product B', 20.0),
(3, 'Product C', 30.0);
SELECT MIN(price)
FROM products;
SELECT MAX(price)
FROM products;