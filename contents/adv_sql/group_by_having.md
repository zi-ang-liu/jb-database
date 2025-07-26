# GROUP BY句とHAVING句

`employees`テーブルが次のように定義されているとします。

```sql
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
```

各部門ごとの平均給与を求める場合は，繰り返して`WHERE`句を使用して各部門の平均給与を計算することができます．

```sql
SELECT AVG(salary) AS HR_Average_Salary
FROM employees
WHERE department = 'HR';

SELECT AVG(salary) AS Engineering_Average_Salary
FROM employees
WHERE department = 'Engineering';
```

## GROUP BY句

`GROUP BY`句は，指定した基準に基づいてデータをグループ化し、集約関数を使用して各グループの統計情報を取得することができます．

### 構文

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE condition
GROUP BY column_name;
```

### 使用例

それぞれの部門ごとの平均給与を求めるには、次のように`GROUP BY`句を使用します。

```sql
SELECT department, AVG(salary) AS Average_Salary
FROM employees
GROUP BY department;
```

このクエリは、`employees`テーブルから各部門ごとの平均給与を計算します．結果は次のようになります：
```plaintext
| department  | Average_Salary |
| ----------- | -------------- |
| HR          | 700            |
| Engineering | 800            |
```

## HAVING句 

`HAVING`句は、`GROUP BY`句でグループ化された結果に対して条件を指定するために使用されます．

`HAVING`句と`WHERE`句と似ていますが、`WHERE`句はグループ化前の行に対して条件を適用し、`HAVING`句はグループ化後の結果に対して条件を適用します．

### 構文

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE condition
GROUP BY column_name
HAVING aggregate_function(column_name) condition;
```

### 使用例

例えば、各部門の平均給与が750以上の部門のみを取得するには、次のように`HAVING`句を使用します。
```sql
SELECT department, AVG(salary) AS Average_Salary
FROM employees
GROUP BY department
HAVING AVG(salary) >= 750;
```
このクエリは、各部門の平均給与が750以上の部門のみを返します．結果は次のようになります：
```plaintext
| department  | Average_Salary |
| ----------- | -------------- |
| Engineering | 800            |
```

## 練習

Chinookデータベースを使用して，下記のクエリを作成せよ．

1. `tracks`テーブルから各アルバムごとのトラック数を求めるクエリを作成せよ．
2. `albums`テーブルから各アーティストごとのアルバム数を求めるクエリを作成せよ．
3. `tracks`テーブルから各ジャンルごとのトラック数を求めるクエリを作成せよ．ただし，トラック数が10以上のジャンルのみを対象とする．
4. `customers`テーブルから各国ごとの顧客数を求めるクエリを作成せよ．ただし，顧客数が5人以上の国のみを対象とする．

### 解答

```sql
-- 1. 
SELECT AlbumId, COUNT(TrackId) AS TrackCount
FROM tracks
GROUP BY AlbumId;

-- 2.
SELECT ArtistId, COUNT(AlbumId) AS AlbumCount
FROM albums
GROUP BY ArtistId;

-- 3.
SELECT GenreId, COUNT(TrackId) AS TrackCount
FROM tracks
GROUP BY GenreId
HAVING COUNT(TrackId) >= 10;

-- 4.
SELECT Country, COUNT(CustomerId) AS CustomerCount
FROM customers
GROUP BY Country
HAVING COUNT(CustomerId) >= 5;
```



