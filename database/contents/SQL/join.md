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
('E003', 'Charlie', 'D002');
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
Engineering         | Alice
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
SELECT a.Name AS Employee1, b.Name AS Employee2, 
       a.DepartmentID
FROM employees a
JOIN employees b
ON a.DepartmentID = b.DepartmentID
WHERE a.EmployeeID <> b.EmployeeID;
```

結果は以下の通りです。

```
Employee1 | Employee2 | DepartmentID
Alice     | Bob       | D001
Charlie   | Bob       | D002
Charlie   | Alice     | D002
```