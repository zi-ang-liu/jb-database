# 副問合せ

基本的な構文は以下の通りです。`>`、`<`、`=`などの比較演算子を使用します。

```sql
SELECT column_name
FROM table_name
WHERE column_name operator (SELECT column_name FROM table_name WHERE condition);
```

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

## 単一行副問合せ

単一行副問合せ（Single-row subquery）は、副問合せが1行1列の値を返すSQLの構文です。

以下は、科目C001の成績が最も高い学生のIDを取得する例です。

```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);
```

以下は、科目C001において平均成績以上の学生のIDを取得する例です。

```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade > (
    SELECT AVG(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);
```

## 複数行副問合せ

複数行副問合せ（Multiple-row subquery）は、副問合せが複数行の値を返すSQLの構文です。`IN`、`ANY`、`ALL`などの演算子を使用します。

```sql
SELECT column_name
FROM table_name
WHERE column_name operator (SELECT column_name FROM table_name WHERE condition);
```

以下は、科目C001登録している学生の名前を取得する例です。

```sql
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C001'
);
```

## 複数列副問合せ

複数列副問合せ（Multiple-column subquery）は、副問合せが複数の列を返すSQLの構文です。

以下は、科目C001において、最も成績が高い学生のID、成績、科目IDを取得する例です。

```sql
SELECT student_id, class_id, grade
FROM enrollments
WHERE (class_id, grade) IN (
    SELECT class_id, MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);
```

## 練習問題

1. 科目C002の成績が最も高い学生のIDを取得せよ。
1. 科目C002の成績が最も高い学生の名前を取得せよ。
1. 点数が最も高いクラスのIDを取得せよ。
1. 点数が最も高いクラスの名前を取得せよ。
1. 科目C003を登録している学生のID、名前、出身地を取得せよ。
1. 科目C003において、平均成績以上の学生のIDを取得せよ。
1. 'Physics' and 'Mathematics'の両方を登録している学生のIDを取得せよ。


```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C002' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C002'
);
```

```sql
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
```

```sql
SELECT class_id
FROM enrollments
WHERE grade = (
    SELECT MAX(grade)
    FROM enrollments
);
```

```sql
SELECT name
FROM classes
WHERE class_id = (
    SELECT class_id
    FROM enrollments
    WHERE grade = (
        SELECT MAX(grade)
        FROM enrollments
    )
);
```

```sql
SELECT student_id, name, birth_place
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C003'
);
```

```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C003' AND grade >= (
    SELECT AVG(grade)
    FROM enrollments
    WHERE class_id = 'C003'
);
```

```sql
SELECT student_id
FROM enrollments
WHERE class_id IN (
    SELECT class_id
    FROM classes
    WHERE name IN ('Physics', 'Mathematics')
)
GROUP BY student_id
HAVING COUNT(DISTINCT class_id) = 2;
```