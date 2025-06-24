# 副問合せ

複雑な問い合わせを行うために，他のSQL文の結果を利用し，さらにその結果を基に問い合わせを行うことがあります．このような問い合わせを**副問合せ**（Subquery）と呼びます．

## 構文

以下は副問合せの基本的な構文です．`WHERE`句の探索条件に，他のSQL文の結果を利用します．

```sql
SELECT column_name
FROM table_name
WHERE column_name operator (SELECT column_name FROM table_name WHERE condition);
```

## 副問合せの使用例

例えば，以下の学生データベースを考えます．

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
('S004', 'Tanaka', 'Tokyo'),
('S005', 'Yamada', 'Osaka');

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

科目`C001`の成績が最も高い学生のIDを取得するには，

1. `enrollments`テーブルから科目`C001`の成績を取得し，その中で最大の成績を求める．
2. `enrollments`テーブルから科目`C001`の成績が最大の成績を持つ学生のIDを取得する．

副問合せは以下のように記述します．

```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade) AS max_grade
    FROM enrollments
    WHERE class_id = 'C001'
);
```

入れ子になったSQL文は`C001`の成績の最大値を取得し，下記の結果を返します．

```plaintext
| max_grade |
| --------- |
| 88        |
```

この結果を基に，外側のSQL文は`C001`の成績が88の学生のIDを取得します．

```plaintext
| student_id |
| ---------- |
| S003       |
```

このように，副問合せは，「まずSQL文を実行して結果を取得し，その結果を基に別のSQL文を実行する」という場面において使用されます．人間の段階的な思考に似ています．

:::{note}
ChatGPTなどの生成AIを賢くする技術の一つに，**Chain of Thought**（思考の連鎖, CoT）があります．これは，複雑な問題を解決するために，複数の段階に分けて考える方法です．

例えば，1 + 2 + 3 の計算を行う場合、まず 1 + 2 を計算し、その結果に 3 を加えるというように、段階的に思考を進めます．
:::

## 副問合せの種類

入れ子になったSQL文からの結果からは，副問合せの種類を以下のように分類できます．

| 副問合せの種類 | 入れ子SQL文の結果 |
| :------------- | ----------------- |
| 単一行副問合せ | 1行n列の値        |
| 複数行副問合せ | n行1列の値        |
| 複数列副問合せ | n行m列の値        |

## 単一行副問合せ

単一行副問合せ（Single-row subquery）は，入れ子になったSQL文が1行n列の値を返す副問合せのSQL文です．

```plaintext
| column_name1 | column_name2 | ... | column_nameN |
| ------------ | ------------ | --- | ------------ |
| value1       | value2       | ... | valueN       |
```

以下は，科目C001において，最も成績が高い学生のID，成績，科目IDを取得する例です．

```sql
SELECT student_id, class_id, grade
FROM enrollments
WHERE (class_id, grade) = (
    SELECT class_id, MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);
```

入れ子になったSQL文が下記のように1行1列の値を返す場合はよくあります．`WHERE`句の条件には`=`，`<`，`>`などの演算子を使用します．

```plaintext
| column_name |
| ----------- |
| value       |
```

以下は，科目C001の成績が最も高い学生のIDを取得する例です．入れ子になったSQL文は1行1列の値を返します．

```sql
SELECT student_id
FROM enrollments
WHERE class_id = 'C001' AND grade = (
    SELECT MAX(grade)
    FROM enrollments
    WHERE class_id = 'C001'
);
```

以下は，科目C001において平均成績以上の学生のIDを取得する例です．

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

複数行副問合せ（Multiple-row subquery）は，副問合せが複数行の値を返すSQLの構文です．

入れ子になったSQL文の結果は下記のように複数行の値を返します．`IN`などの演算子を使用します．

```plaintext
| column_name |
| ----------- |
| value1      |
| value2      |
| ...         |
| valueN      |
```

### `IN`演算子

`IN`演算子は、指定した値が入れ子になった問合せから返した値のリストのいずれかに一致する場合は`TRUE`となります．例えば，`'apple' IN ('apple', 'banana', 'orange')`は`TRUE`となります．

副問合せで使用する場合の構文は以下の通りです．

```sql
SELECT column_name
FROM table_name
WHERE column_name IN (SELECT column_name FROM table_name WHERE condition);
```

以下は，科目C001登録している学生の名前を取得する例です．

```sql
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE class_id = 'C001'
);
```

### `ANY`/`ALL`演算子

`ANY`演算子は、入れ子になった問合せから返された値に基づいて比較を行い，少なくとも1つの値が条件を満たす場合は`TRUE`となります．例えば，`5 > ANY (1, 7, 3)`は`TRUE`となります．

`ALL`演算子は、入れ子になった問合せから返された値に基づいて比較を行い，すべての値が条件を満たす場合は`TRUE`となります．例えば，`5 > ALL (1, 2, 3)`は`TRUE`となります．

副問合せで使用する場合の構文は以下の通りです．

```sql
SELECT column_name
FROM table_name
WHERE column_name operator ANY (SELECT column_name FROM table_name WHERE condition);

SELECT column_name
FROM table_name
WHERE column_name operator ALL (SELECT column_name FROM table_name WHERE condition);
```

:::{note}
SQLiteでは`ANY`がサポートされていません．
:::

以下は，少なくとも1つの科目で成績が90点以上の学生の名前を取得する例です．

```sql
SELECT name
FROM students
WHERE student_id = ANY (
    SELECT student_id
    FROM enrollments
    WHERE grade > 90
);
```

以下は，履修登録をしていない学生の名前を取得する例です．

```sql
SELECT name
FROM students
WHERE student_id != ALL (
    SELECT student_id
    FROM enrollments
);
```

## 複数列副問合せ

複数列副問合せ（Multiple-column subquery）は，副問合せがn行m列の値を返すSQLの構文です．

入れ子になったSQL文の結果は下記のように複数行複数列の値を返します．

```plaintext
| column_name1 | column_name2 | ... | column_nameM |
| ------------ | ------------ | --- | ------------ |
| value1       | value2       | ... | valueM       |
| value1       | value2       | ... | valueM       |
| ...          | ...          | ... | ...          |
| valueN       | valueN       | ... | valueM       |
```


以下は，それぞれの科目において，最も成績が高い学生のID，成績，科目IDを取得する例です．

```sql
SELECT student_id, class_id, grade
FROM enrollments
WHERE (class_id, grade) IN (
    SELECT class_id, MAX(grade)
    FROM enrollments
    GROUP BY class_id
); 
```

## 練習問題

1. 科目C002の成績が最も高い学生のIDを取得せよ．
1. 科目C002の成績が最も高い学生の名前を取得せよ．
1. 点数が最も高いクラスのIDを取得せよ．
1. 点数が最も高いクラスの名前を取得せよ．
1. 科目C003を登録している学生のID，名前，出身地を取得せよ．
1. 科目C003において，平均成績以上の学生のIDを取得せよ．
1. 'Physics' and 'Mathematics'の両方を登録している学生のIDを取得せよ．


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