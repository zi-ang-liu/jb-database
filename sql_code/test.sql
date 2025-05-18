CREATE TABLE users (
    ID TEXT,
    Name TEXT,
    Age INTEGER
);

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