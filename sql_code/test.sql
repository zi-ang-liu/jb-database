CREATE TABLE students (
    student_id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL
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

INSERT INTO students (student_id, name, email) VALUES
('S001', 'Alice', 's001@example.ac.jp'),
('S002', 'Bob', 's002@example.ac.jp'),
('S003', 'Charlie', 's003@example.ac.jp');

INSERT INTO classes (class_id, name) VALUES
('C001', 'Mathematics'),
('C002', 'Physics'),
('C003', 'Chemistry');

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

SELECT email FROM students
WHERE name = 'Alice';

SELECT student_id, class_id FROM enrollments
WHERE grade >= 80;

SELECT student_id, name FROM students
WHERE name LIKE '%e%';

SELECT student_id, name FROM students
WHERE name LIKE '%e%';

SELECT student_id, name FROM students
WHERE name LIKE 'A%';

SELECT student_id FROM enrollments
WHERE class_id = 'C001' AND grade >= 60;

SELECT DISTINCT student_id FROM enrollments
WHERE (class_id = 'C001' OR class_id = 'C002') AND grade >= 80;

SELECT DISTINCT student_id FROM enrollments
WHERE class_id IN ('C001', 'C002');

SELECT COUNT(*) FROM enrollments
WHERE class_id = 'C001' AND grade BETWEEN 80 AND 100;