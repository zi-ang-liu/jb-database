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