# データ操作言語

## データの追加

`INSERT INTO`文を使用して、テーブルに新しい行を追加します。

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

例えば、`users`テーブルにデータを追加する場合は、次のようになります。

```sql
CREATE TABLE users (
    ID TEXT,
    Name TEXT,
    Age INTEGER
);
INSERT INTO users (ID, Name, Age)
VALUES ('001', 'Alice', 25);
```

### 列名の省略

すべての列にデータを追加する場合は、列名を省略することもできます。

```sql
INSERT INTO users 
VALUES ('002', 'Bob', 30);
```

### 複数行の追加

複数の行を一度に追加することもできます。書式は次のとおりです。

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...),
       (value3, value4, ...);
```

例えば、`users`テーブルに複数の行を追加する場合は、次のようになります。

```sql
INSERT INTO users (ID, Name, Age)
VALUES ('002', 'Bob', 30),
       ('003', 'Charlie', 35);
```

## データの更新

`UPDATE`文を使用して、既存の行のデータを更新します。

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

- `UPDATAE table_name`：更新するテーブルの名前を指定します。
- `SET`：更新する列と新しい値を指定します。
- `WHERE`：更新する行を特定する条件を指定します。条件を省略すると、すべての行が更新されます。

次の例では、`users`テーブルの`ID`が`001`の行の`Age`を26に更新します。

```sql
UPDATE users
SET Age = 26
WHERE ID = '001';
```

`where`句を省略すると、すべての行が更新されます。

次の例では、すべてのユーザーの年齢を1歳ずつ増やします。

```sql
UPDATE users
SET Age = Age + 1;
```

## データの削除

`DELETE`文を使用して、既存の行を削除します。

```sql
DELETE FROM table_name
WHERE condition;
```

- `DELETE FROM table_name`：削除するテーブルの名前を指定します。
- `WHERE`：削除する行を特定する条件を指定します。条件を省略すると、すべての行が削除されます。

例えば、`ID`が`001`の行を削除する場合は、次のようになります。

```sql
DELETE FROM users
WHERE ID = '001';
```

## データの選択

`SELECT`文を使用して、テーブルからデータを選択します。

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

- `SELECT column1, column2, ...`：選択する列を指定します。すべての列を選択する場合は、`*`を使用します。
- `FROM table_name`：選択するテーブルの名前を指定します。
- `WHERE`：選択する行を特定する条件を指定します。条件を省略すると、すべての行が選択されます。


例えば、下記の`employees`テーブルがあるとします。

```sql
CREATE TABLE employees (
    ID TEXT,
    Name TEXT,
    Age INTEGER,
    Department TEXT
);

INSERT INTO employees (ID, Name, Age, Department)
VALUES ('001', 'Alice', 25, 'HR'),
       ('002', 'Bob', 30, 'IT'),
       ('003', 'Charlie', 35, 'Finance'),
       ('004', 'Alice', 28, 'IT');
```

このテーブルからすべての列を選択する場合は、次のようになります。

```sql
SELECT * FROM employees;
```

このテーブルから`Name`と`Department`列を選択する場合は、次のようになります。

```sql
SELECT Name, Department FROM employees;
```

IT部門の従業員のIDと名前を選択する場合は、次のようになります。

```sql
SELECT ID, Name
FROM employees
WHERE Department = 'IT';
```

年齢が30歳以下の従業員の名前を選択する場合は、次のようになります。

```sql
SELECT Name
FROM employees
WHERE Age <= 30;
```

下記のように出力されます。

```text
Name
Alice
Bob
Alice
```

### SELECT DISTINCT

`SELECT DISTINCT`を使用すると、重複する行を除外して選択することができます。

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name;
```

## 練習

下記の`employees`テーブルがあるとします。

```sql
CREATE TABLE employees (
    ID TEXT PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER CHECK (Age >= 18),
    Department TEXT
);
```

このテーブルに対して、以下の操作を行ってください。
1. `('001', 'Alice', 25, 'HR'), ('002', 'Bob', 30, 'IT'), ('003', 'Charlie', 35, 'Finance')`のデータを追加せよ。
2. `001`の行の`Department`を`IT`に更新せよ。
3. `ID`が`001`の行を削除せよ。
4. `ID`が`002`の行を選択せよ。
5. 年齢が30歳以上の従業員の名前を選択せよ。