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

SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade) AS max_grade
    FROM enrollments
    WHERE class_id = 'C001'
);

SELECT student_id, class_id, grade
FROM enrollments
WHERE (class_id, grade) = (
    SELECT class_id, MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
)

SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade > (
    SELECT AVG(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);

SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C001'
);

SELECT name
FROM students
WHERE student_id = ANY (
    SELECT student_id
    FROM enrollments
    WHERE grade > 90
);