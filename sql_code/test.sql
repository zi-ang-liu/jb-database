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

