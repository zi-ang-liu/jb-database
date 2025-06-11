# ORDER BY句

`ORDER BY`句は、クエリの結果を特定の列に基づいて並べ替えるために使用されます．

## 構文

```sql
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name [ASC|DESC];
```

並べ順は，`ASC`（昇順）または`DESC`（降順）で指定できます．デフォルトは昇順です．

## 使用例

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

次のクエリは、`employees`テーブルからすべての従業員を年齢の昇順で取得します。

```sql
SELECT * FROM employees
ORDER BY age ASC;
```

このクエリの結果は次のようになります：

```plaintext
| id  | name    | department  | age | salary |
| --- | ------- | ----------- | --- | ------ |
| 2   | Bob     | Engineering | 25  | 700    |
| 4   | David   | Engineering | 28  | 900    |
| 1   | Alice   | HR          | 30  | 600    |
| 3   | Charlie | HR          | 35  | 800    |
```

## 練習

Chinookデータベースを使用して，下記のクエリを作成せよ．

1. `customers`テーブルからすべての顧客を`FirstName`の昇順で取得するクエリを作成せよ．
2. `employees`テーブルからすべての従業員を生年月日の昇順で取得するクエリを作成せよ．
3. `tracks`テーブルから各アルバムごとのトラック数を求め，トラック数の昇順で取得するクエリを作成せよ．（HINT: GROUP BY句を使用すること）
4. `albums`テーブルから各アーティストごとのアルバム数を求め，アルバム数の降順で取得するクエリを作成せよ．ただし，アルバム数が5以上のアーティストのみを対象とすること．

### 解答

```sql
-- 1
SELECT * FROM customers
ORDER BY FirstName ASC;

-- 2
SELECT * FROM employees
ORDER BY BirthDate DESC;

-- 3
SELECT AlbumId, COUNT(*) AS TrackCount
FROM tracks
GROUP BY AlbumId
ORDER BY TrackCount ASC;

-- 4
SELECT ArtistId, COUNT(*) AS AlbumCount
FROM albums
GROUP BY ArtistId
HAVING COUNT(*) >= 5
ORDER BY AlbumCount DESC;
```