CREATE TABLE students (
    student_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    birth_place TEXT NOT NULL
);

CREATE TABLE classes (
    class_id TEXT PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE enrollments (
    student_id TEXT NOT NULL,
    class_id TEXT NOT NULL,
    enrollment_date TEXT NOT NULL,
    grade INTEGER,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
    PRIMARY KEY (student_id, class_id)
);

INSERT INTO students (student_id, name, birth_place) VALUES
('S001', 'Alice', 'New York'),
('S002', 'Bob', 'London'),
('S003', 'Charlie', 'Tokyo'),
('S004', 'Tanaka', 'Tokyo');

INSERT INTO classes (class_id, name) VALUES
('C001', 'Mathematics'),
('C002', 'Physics'),
('C003', 'Chemistry'),
('C004', 'Biology');

INSERT INTO enrollments (student_id, class_id, enrollment_date, grade) VALUES
('S001', 'C001', '2023-04-21', 85),
('S001', 'C002', '2023-05-01', 90),
('S001', 'C003', '2023-04-01', 53),
('S002', 'C001', '2023-04-11', 78),
('S002', 'C002', '2023-04-14', 82),
('S002', 'C003', '2023-04-24', 75),
('S003', 'C001', '2023-04-25', 88),
('S003', 'C002', '2023-05-04', 92),
('S003', 'C003', '2023-04-01', 88);

-- Query to find student ids who have the highest grade in class C001 using a subquery

SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

-- Query to find student ids who have the higher grade in class c001 than average grade in class C001
SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade > (
    SELECT AVG(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

-- Multiple-row subquery
-- Query to find student names who have enrolled in class c001

SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C001'
);

-- Multiple-column subquery
-- Query to find student ids, grades, and class ids for students who got the highest grade in class C001
SELECT student_id, class_id, grade
FROM enrollments
WHERE (class_id, grade) IN (
    SELECT class_id, MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

-- Query to find student names, grades, and class ids for students who got the highest grade in class C001

SELECT s.name, e.grade, e.class_id
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
WHERE (e.class_id, e.grade) IN (
    SELECT class_id, MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

-- problem 1
-- single-row subquery
-- Query to find student ids who have the highest grade in class C002 using a subquery
SELECT student_id
FROM enrollments
WHERE class_id = 'C002' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C002'
);

-- Query to find student names who have the highest grade in class C002 using a subquery
SELECT name
FROM students
WHERE student_id = (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C002' AND grade = (
        SELECT MAX(grade)
        FROM enrollments
        WHERE class_id = 'C002'
    )
);

-- multiple-row subquery
-- Query to find class names that have the highest grade
SELECT name
FROM classes
WHERE class_id IN (
    SELECT class_id
    FROM enrollments
    WHERE grade = (
        SELECT MAX(grade)
        FROM enrollments
    )
);

SELECT class_id
FROM enrollments
WHERE grade = (
    SELECT MAX(grade)
    FROM enrollments
);

SELECT student_id, name, birth_place
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C003'
);

SELECT student_id
FROM enrollments
WHERE class_id = 'C003' AND grade >= (
    SELECT AVG(grade)
    FROM enrollments
    WHERE class_id = 'C003'
);

SELECT student_id
FROM enrollments
WHERE class_id IN (
    SELECT class_id
    FROM classes
    WHERE name IN ('Physics', 'Mathematics')
)
GROUP BY student_id
HAVING COUNT(DISTINCT class_id) = 2;

SELECT students.name, enrollments.class_id
FROM students
INNER JOIN enrollments
ON students.student_id = enrollments.student_id;

SELECT classes.name, enrollments.student_id
FROM classes
LEFT JOIN enrollments
ON classes.class_id = enrollments.class_id;


CREATE TABLE employees (
    id TEXT PRIMARY KEY,
    name TEXT,
    department TEXT,
    age INTEGER,
    salary INTEGER
);
INSERT INTO employees (id, name, department, age, salary) VALUES
('1', 'Alice', 'HR', 30, 600),
('2', 'Bob', 'Engineering', 25, 700),
('3', 'Charlie', 'HR', 35, 800),
('4', 'David', 'Engineering', 28, 900);

SELECT * FROM employees
ORDER BY age ASC;