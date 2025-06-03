# 集約関数

**集約関数**（Aggregate Function）は、複数の値を受け取り、1つの値を返す関数です。SQLでは、集約関数を使用して、データの集計や統計情報を取得することができます。

以下は、SQLでよく使用される集約関数です。
- `SUM`：各行の合計値を求める
- `AVG`：各行の平均値を求める
- `MIN`：各行の最小値を求める
- `MAX`：各行の最大値を求める
- `COUNT`：行数を計算する

## MIN()関数とMAX()関数

`MIN()`関数は、指定した列の最小値を返します。`MAX()`関数は、指定した列の最大値を返します。

### 構文

```sql
SELECT MIN(column_name) AS alias
FROM table_name
WHERE condition;
```


```sql
SELECT MAX(column_name) AS alias
FROM table_name
WHERE condition;
```

### 使用例

次の例では、`products`テーブルから、`price`列の最小値と最大値を取得します。

```sql
CREATE TABLE products (
    id INT,
    name TEXT,
    price REAL
);

INSERT INTO products (id, name, price) VALUES
(1, 'Product A', 10.0),
(2, 'Product B', 20.0),
(3, 'Product C', 30.0);

SELECT MIN(price)
FROM products;

SELECT MAX(price)
FROM products;
```

すると、次のような結果が得られます。

| MIN(price) |
| ---------- |
| 10.0       |

| MAX(price) |
| ---------- |
| 30.0       |

`AS`を使用して、列名を変更することもできます。

```sql
SELECT MIN(price) AS min_price
FROM products;
SELECT MAX(price) AS max_price
FROM products;
```

## SUM()関数とAVG()関数

`SUM()`関数は、指定した列の合計値を返します。`AVG()`関数は、指定した列の平均値を返します。

### 構文

```sql
SELECT SUM(column_name) AS alias
FROM table_name
WHERE condition;
```

```sql
SELECT AVG(column_name) AS alias
FROM table_name
WHERE condition;
```

### 使用例

次の例では、`products`テーブルから、`price`列の合計値と平均値を取得します。

```sql
SELECT SUM(price) AS total_price
FROM products;
```

```sql
SELECT AVG(price) AS average_price
FROM products;
```

## COUNT()関数

`COUNT()`関数は、指定した列の行数をカウントします。

### 構文

```sql
SELECT COUNT(column_name)
FROM table_name
WHERE condition;
```

### 使用例

`products`テーブルが次のように定義されているとします。

```sql
CREATE TABLE products (
    id INT,
    name TEXT,
    price REAL
);

INSERT INTO products (id, name, price) VALUES
(1, 'Product A', 10.0),
(2, 'Product B', 20.0),
(3, 'Product C', 30.0);
(4, 'Product D', NULL);
```

下の例では、`products`テーブルの行数をカウントします。

```sql
SELECT COUNT(*)
FROM products;
```

すると、次のような結果が得られます。
| COUNT(*) |
| -------- |
| 4        |

`COUNT()`関数は、特定の列に対しても使用できます。NULL値はカウントされません。

```sql
SELECT COUNT(price)
FROM products;
```

すると、次のような結果が得られます。
| COUNT(price) |
| ------------ |
| 3            |

```{note}
`COUNT(*)`は、テーブル内のすべての行をカウントしますが、`COUNT(column_name)`は、指定した列にNULLでない値がある行のみをカウントします。
```

また，`WHERE`句を使用して、特定の条件に一致する行のみをカウントすることもできます。

```sql
SELECT COUNT(*)
FROM products
WHERE price > 15.0;
```

## 練習

下記の`scores`テーブルを使用して、集約関数の練習を行います。

```sql
CREATE TABLE scores (
    StudentID TEXT,
    CourseID TEXT,
    Score INTEGER,
    PRIMARY KEY (StudentID, CourseID)
);
INSERT INTO scores (StudentID, CourseID, Score) VALUES
('S001', 'C001', 85),
('S002', 'C001', 78),
('S003', 'C001', 92),
('S001', 'C002', 88),
('S002', 'C002', 90),
('S003', 'C002', 95);
```

1. 科目`C001`の最高得点を求めよ。
2. 科目`C002`の平均得点を求めよ。
3. 科目`C002`の学生数を求めよ。
4. 科目`C002`において、得点が90点以上の学生の数を求めよ。
5. 科目`C002`において、90点以上の学生のIDと得点を取得せよ。


```sql
SELECT MAX(Score) AS max_score
FROM scores
WHERE CourseID = 'C001';
```

```sql
SELECT AVG(Score) AS average_score
FROM scores
WHERE CourseID = 'C002';
```

```sql
SELECT COUNT(DISTINCT StudentID) AS student_count
FROM scores
WHERE CourseID = 'C002';
```

```sql
SELECT COUNT(DISTINCT StudentID) AS high_scorers
FROM scores
WHERE CourseID = 'C002' AND Score >= 90;
```

```sql
SELECT StudentID, Score
FROM scores
WHERE CourseID = 'C002' AND Score >= 90;
```