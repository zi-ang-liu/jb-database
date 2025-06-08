# WHERE句

WHERE句（WHERE clause）は、SQL文において、特定の条件を満たす行を選択するために使用されます。`WHERE`句は、`SELECT`、`UPDATE`、`DELETE`などのSQL文で使用されます。

## Boolean式

https://www.sqlite.org/lang_expr.html

The SQL language features several contexts where an expression is evaluated and the result converted to a boolean (true or false) value. These contexts are:

- the WHERE clause of a SELECT, UPDATE or DELETE statement,
- the ON or USING clause of a join in a SELECT statement,
- the HAVING clause of a SELECT statement,
- the WHEN clause of an SQL trigger, and
- the WHEN clause or clauses of some CASE expressions.

To convert the results of an SQL expression to a boolean value, SQLite first casts the result to a NUMERIC value in the same way as a CAST expression. A numeric zero value (integer value 0 or real value 0.0) is considered to be false. A NULL value is still NULL. All other values are considered true.

For example, the values NULL, 0.0, 0, 'english' and '0' are all considered to be false. Values 1, 1.0, 0.1, -0.1 and '1english' are considered to be true.

Beginning with SQLite 3.23.0 (2018-04-02), SQLite recognizes the identifiers "TRUE" and "FALSE" as boolean literals, if and only if those identifiers are not already used for some other meaning. If there already exists columns or tables or other objects named TRUE or FALSE, then for the sake of backwards compatibility, the TRUE and FALSE identifiers refer to those other objects, not to the boolean values.

The boolean identifiers TRUE and FALSE are usually just aliases for the integer values 1 and 0, respectively. However, if TRUE or FALSE occur on the right-hand side of an IS operator, then the IS operator evaluates the left-hand operand as a boolean value and returns an appropriate answer.

## 演算子

```sql
CREATE TABLE students (
    StudentID TEXT PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER CHECK (Age >= 18),
    Department TEXT,
    Gender TEXT
);
```

### 比較演算子

比較演算子は、左右の値を比較し、正しければ真（`TRUE`）、そうでなければ偽（`FALSE`）を返します。

| 演算子       | 説明       |
| ------------ | ---------- |
| `=` or `==`  | 等しい     |
| `<>` or `!=` | 等しくない |
| `>`          | より大きい |
| `<`          | より小さい |
| `>=`         | 以上       |
| `<=`         | 以下       |


以下は，年齢が20歳より大きい学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Age > 20;
```

以下は，所属が「Computer Science」の学生を選択するSQL文の例です。   

```sql
SELECT * FROM students
WHERE Department = 'Computer Science';
```

### 論理演算子

論理演算子は，複数の式を組み合わせて、真偽値を返すものです。

| 演算子 | 説明   |
| ------ | ------ |
| `AND`  | かつ   |
| `OR`   | または |
| `NOT`  | 否定   |

pとqを論理変数とした場合の真理値表は次の通りです。

| p   | q   | p AND q | p OR q | NOT p |
| --- | --- | ------- | ------ | ----- |
| T   | T   | T       | T      | F     |
| T   | F   | F       | T      | F     |
| F   | T   | F       | T      | T     |
| F   | F   | F       | F      | T     |

以下は，所属が「Computer Science」の男性学生の人数を選択するSQL文の例です。

```sql
SELECT COUNT(*) FROM students
WHERE Department = 'Computer Science' AND Gender = 'Male';
```

### `BETWEEN`演算子

<!-- The BETWEEN operator is logically equivalent to a pair of comparisons. "x BETWEEN y AND z" is equivalent to "x>=y AND x<=z" except that with BETWEEN, the x expression is only evaluated once. -->

`BETWEEN`演算子は、ある値が指定した範囲内にあるかどうかを確認するために使用されます。`x BETWEEN y AND z`は、`x>= y AND x <= z`と論理的に同等です。ただし、`BETWEEN`を使用すると、`x`の式は一度だけ評価されます。

構文は次の通りです。

```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name BETWEEN value1 AND value2;
```

以下は，年齢が18歳から25歳の学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Age BETWEEN 18 AND 25;
```

### `IN`演算子，`NOT IN`演算子

`IN`演算子は，値のリストのいずれかに一致するかを判定する演算子です．

構文は次の通りです。

```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name IN (value1, value2, ...);
```

以下は，所属が「Computer Science」または「Mathematics」の学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Department IN ('Computer Science', 'Mathematics');
```

`or`演算子を使用して同じ結果を得ることもできますが、`IN`演算子を使用すると、より簡潔に記述できます。

```sql
SELECT * FROM students
WHERE Department = 'Computer Science' OR Department = 'Mathematics';
```

`NOT IN`演算子を使用すると、値のリストに一致しない行を選択できます。

以下は，所属が「Computer Science」または「Mathematics」以外の学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Department NOT IN ('Computer Science', 'Mathematics');
```

### `ANY`演算子，`ALL`演算子

`ANY`演算子は，値リストの各要素と比較し，いずれかが真であれば真を返します。

```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name operator ANY (value1, value2, ...);
```

`ALL`演算子は，値リストのすべての要素と比較し，すべてが真であれば真を返します。

```sql
SELECT column1, column2, ...
FROM table_name
WHERE column_name operator ALL (value1, value2, ...);
```

以下は，`ANY`演算子を使用して、年齢が19歳、20歳、21歳のいずれかより大きい学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Age > ANY (19, 20, 21);
```

以下は，`ALL`演算子を使用して、年齢が19歳、20歳、21歳のすべてより大きい学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Age > ALL (19, 20, 21);
```

`ANY`と`ALL`は、主に副問合せと組み合わせて使用されます。

### `LIKE`演算子

`LIKE`演算子は，文字列の**パターンマッチング**（pattern matching）を行う演算子です。

| symbol | 説明                    |
| ------ | ----------------------- |
| `%`    | 任意の0文字以上の文字列 |
| `_`    | 任意の1文字             |

以下は，名前が「John」で始まる学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Name LIKE 'John%';
```

以下は，学籍番号が「75」で終わる学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE StudentID LIKE '%75';
```

以下は，名前の3文字目が「a」である学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Name LIKE '__a%';
```

以下は，名前に「z」が含まれる学生を選択するSQL文の例です。

```sql
SELECT * FROM students
WHERE Name LIKE '%z%';
```

## 練習

`student.db`というデータベースを作成し、`WHERE`句の練習を行います。

```sql
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
```

### 練習問題

1. `students`テーブルから、名前が「Alice」の学生のメールアドレスを選択してください。
2. `enrollments`テーブルから、成績が80点以上の学生のIDとクラスIDを選択してください。
3. `students`テーブルから、名前に「e」が含まれる学生のIDと名前を選択してください。
4. `students`テーブルから、名前が「A」で始まる学生のIDと名前を選択してください。
5. 科目`C001`の成績が60点以上の学生のIDを選択してください。
6. `C001`や`C002`のいずれかの科目で成績が80点以上の学生のIDを選択してください。ただし，`DISTINCT`を使用して重複を除外してください。
7. `IN`演算子を使用して、`C001`または`C002`のいずれかの科目に登録している学生のIDを選択してください。
8. `BETWEEN`演算子を使用して、`C001`の成績が90点以上かつ100点以下の学生数を選択してください。


### 解答例
```sql
SELECT email FROM students
WHERE name = 'Alice';
```

```sql
SELECT student_id, class_id FROM enrollments
WHERE grade >= 80;
```

```sql
SELECT student_id, name FROM students
WHERE name LIKE '%e%';
```

```sql
SELECT student_id, name FROM students
WHERE name LIKE 'A%';
```

```sql
SELECT student_id FROM enrollments
WHERE class_id = 'C001' AND grade >= 60;
```

```sql
SELECT DISTINCT student_id FROM enrollments
WHERE (class_id = 'C001' OR class_id = 'C002') AND grade >= 80;
```

```sql
SELECT DISTINCT student_id FROM enrollments
WHERE class_id IN ('C001', 'C002');
```


```sql
SELECT COUNT(*) FROM enrollments
WHERE class_id = 'C001' AND grade BETWEEN 90 AND 100;
```