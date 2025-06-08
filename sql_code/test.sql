CREATE TABLE departments (
    DepartmentID TEXT PRIMARY KEY,
    DepartmentName TEXT NOT NULL
);

CREATE TABLE employees (
    EmployeeID TEXT PRIMARY KEY,
    Name TEXT NOT NULL,
    DepartmentID TEXT,
    FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID)
);

INSERT INTO departments (DepartmentID, DepartmentName) VALUES
('D001', 'Human Resources'),
('D002', 'Engineering'),
('D003', 'Sales');
INSERT INTO employees (EmployeeID, Name, DepartmentID) VALUES
('E001', 'Alice', 'D001'),
('E002', 'Bob', 'D002'),
('E003', 'Charlie', 'D002'),
('E004', 'David', NULL);

SELECT employees.Name, departments.DepartmentName
FROM employees
INNER JOIN departments
ON employees.DepartmentID = departments.DepartmentID;

SELECT employees.Name, departments.DepartmentName
FROM employees
LEFT JOIN departments
ON employees.DepartmentID = departments.DepartmentID;

SELECT employees.Name, departments.DepartmentName
FROM employees
FULL OUTER JOIN departments
ON employees.DepartmentID = departments.DepartmentID;

SELECT departments.DepartmentName, employees.Name
FROM departments
CROSS JOIN employees;

SELECT a.Name AS Employee1, b.Name AS Employee2, a.DepartmentID
FROM employees a
JOIN employees b
ON a.DepartmentID = b.DepartmentID
WHERE a.EmployeeID <> b.EmployeeID;