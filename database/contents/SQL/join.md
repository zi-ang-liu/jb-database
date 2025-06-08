# JOIN

`JOIN`句は、複数のテーブルを結合します。

## INNER JOIN

構文は以下の通りです。

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```

`departments`テーブルと`employees`テーブルを以下のように定義します。

```sql
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
```

以下は、`employees`テーブルと`departments`テーブルを結合して、各従業員の名前と所属部門名を取得するSQL文の例です。

```sql
SELECT employees.Name, departments.DepartmentName
FROM employees
INNER JOIN departments
ON employees.DepartmentID = departments.DepartmentID;
```

結果は以下の通りです。

```
Name      | DepartmentName
Alice    | Human Resources
Bob      | Engineering
Charlie  | Engineering
```

## LEFT JOIN

`LEFT JOIN`は、左側のテーブルのすべての行と、右側のテーブルの一致する行を結合します。右側のテーブルに一致する行がない場合、結果にはNULLが含まれます。

構文は以下の通りです。

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;
```

以下は、`employees`テーブルと`departments`テーブルを左結合して、各従業員の名前と所属部門名を取得するSQL文の例です。

```sql
SELECT employees.Name, departments.DepartmentName
FROM employees
LEFT JOIN departments
ON employees.DepartmentID = departments.DepartmentID;
```

結果は以下の通りです。

```
Name      | DepartmentName
Alice    | Human Resources
Bob      | Engineering
Charlie  | Engineering
David    | NULL
```

## FULL OUTER JOIN

`FULL OUTER JOIN`は、左側のテーブルと右側のテーブルの両方のすべての行を結合します。一致する行がない場合、結果にはNULLが含まれます。

構文は以下の通りです。

```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2
ON table1.column_name = table2.column_name;
```

以下は、`employees`テーブルと`departments`テーブルをフルアウト結合して、各従業員の名前と所属部門名を取得するSQL文の例です。

```sql
SELECT employees.Name, departments.DepartmentName
FROM employees
FULL OUTER JOIN departments
ON employees.DepartmentID = departments.DepartmentID;
```

結果は以下の通りです。

```
Name      | DepartmentName
Alice    | Human Resources
Bob      | Engineering
Charlie  | Engineering
David    | NULL
NULL      | Sales
```

## CROSS JOIN

`CROSS JOIN`は、2つのテーブルの直積を生成します。

構文は以下の通りです。

```sql
SELECT columns
FROM table1
CROSS JOIN table2;
```

以下は、`departments`テーブルと`employees`テーブルをクロス結合して、すべての組み合わせを取得するSQL文の例です。

```sql
SELECT departments.DepartmentName, employees.Name
FROM departments
CROSS JOIN employees;
```

結果は以下の通りです。

```
DepartmentName      | Name
Human Resources     | Alice
Human Resources     | Bob
Human Resources     | Charlie
... (他の組み合わせも続く)
Sales              | David
```

## SELF JOIN

`SELF JOIN`は、同じテーブルを2回結合することです。自己結合は、テーブル内の行を比較するために使用されます。

構文は以下の通りです。

```sql
SELECT a.columns, b.columns
FROM table a
JOIN table b
ON a.column_name = b.column_name;
```

以下は、`employees`テーブルを自己結合して、同じ部門に所属する従業員のペアを取得するSQL文の例です。

```sql
SELECT a.Name AS Employee1, b.Name AS Employee2, a.DepartmentID
FROM employees a
JOIN employees b
ON a.DepartmentID = b.DepartmentID
WHERE a.EmployeeID <> b.EmployeeID;
```

結果は以下の通りです。

```
Employee1 | Employee2 | DepartmentID
Bob      | Charlie   | D002
Charlie  | Bob       | D002
```

## 練習

`student.db`というデータベースを作成し、`JOIN`句の練習を行います。

```sql
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
```

### 練習問題

1. `students`テーブルと`enrollments`テーブルを結合して、各学生の名前とその学生が登録している科目の番号を取得せよ。
2. `classes`テーブルと`enrollments`テーブルを左結合して、各科目の名前とその科目に登録している学生の番号を取得せよ。
3. `students`テーブルと`enrollments`テーブルを`CROSS JOIN`して、学籍番号と科目番号の直積を取得せよ。
4. `students`テーブルを自己結合して、同じ出生地の学生のペアを取得せよ。

### 解答例

```sql
SELECT students.name, enrollments.class_id
FROM students
INNER JOIN enrollments
ON students.student_id = enrollments.student_id;
```

```sql
SELECT classes.name, enrollments.student_id
FROM classes
LEFT JOIN enrollments
ON classes.class_id = enrollments.class_id;
```

```sql
SELECT students.student_id, enrollments.class_id
FROM students
FULL OUTER JOIN enrollments
ON students.student_id = enrollments.student_id;
```

```sql
SELECT a.name AS Student1, b.name AS Student2, a.birth_place
FROM students a
JOIN students b
ON a.birth_place = b.birth_place
WHERE a.student_id <> b.student_id;
```