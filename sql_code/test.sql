CREATE TABLE students (
    StudentID TEXT PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER CHECK (Age >= 18),
    Department TEXT,
    Gender TEXT
);
INSERT INTO students (StudentID, Name, Age, Department, Gender) VALUES
('S001', 'Alice', 20, 'Computer Science', 'Female'),
('S002', 'Bob', 22, 'Mathematics', 'Male'),
('S003', 'Charlie', 19, 'Computer Science', 'Male'),
('S004', 'David', 21, 'Physics', 'Male');

SELECT * FROM students
WHERE Age > 20;

SELECT * FROM students
WHERE Department = 'Computer Science';

SELECT COUNT(*) FROM students
WHERE Department = 'Computer Science' AND Gender = 'Male';

SELECT * FROM students
WHERE Age BETWEEN 18 AND 25;

SELECT * FROM students
WHERE Department IN ('Computer Science', 'Mathematics');

SELECT * FROM students
WHERE Department = 'Computer Science' OR Department = 'Mathematics';

SELECT * FROM students
WHERE Department NOT IN ('Computer Science', 'Mathematics');

SELECT * FROM students
WHERE Age > ANY(19, 20, 21);