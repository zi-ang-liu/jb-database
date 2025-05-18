# データ定義言語

データ定義言語（Data Definition Language, DDL）は、データを定義するためのSQL文を指します。DDLは、テーブルの作成、変更、削除など、データベースの構造を定義するために使用されます。DDLの主なコマンドには、`CREATE`、`ALTER`、`DROP`などがあります。

## テーブルの作成

`CREATE TABLE`文は、新しいテーブルを作成するために使用されます。書式は次のとおりです。

```sql
CREATE TABLE table_name (
    column1_name data_type,
    column2_name data_type,
    ...
);
```

```{note}
**SQLの基本ルール**
- 文末にはセミコロン`;`を付ける
- 予約語は大文字で記述する
```

`table_name`には、作成するテーブルの名前を指定します。

`column1_name`、`column2_name`には、テーブルの列名を指定します。

`data_type`には、列のデータ型を指定します。SQLiteでは、全ての値は、次の5つのstorage classのいずれかに分類されます。

- NULL
- INTEGER
- REAL
- TEXT
- BLOB

例として、`users`というテーブルを作成する場合は、次のようにします。

```sql
CREATE TABLE users (
    ID TEXT,
    Name TEXT,
    Age INTEGER
);
```

## テーブルの変更

`ALTER TABLE`文は、既存のテーブルを変更するために使用されます。

### 列の追加

`ADD COLUMN`を使用して、テーブルに新しい列を追加することができます。書式は次のとおりです。

```sql
ALTER TABLE table_name
ADD COLUMN column_name data_type;
```

次の例では、`users`テーブルに`Email`列を追加します。

```sql
ALTER TABLE users
ADD COLUMN Email TEXT;
```

### 列の削除

`DROP COLUMN`を使用して、テーブルから列を削除することができます。書式は次のとおりです。

```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```

次の例では、`users`テーブルから`Email`列を削除します。

```sql
ALTER TABLE users
DROP COLUMN Email;
```

## テーブルの削除

`DROP TABLE`文は、テーブルを削除するために使用されます。書式は次のとおりです。

```sql
DROP TABLE table_name;
```

次の例では、`users`テーブルを削除します。

```sql
DROP TABLE users;
```


## 練習

1. students(StudentID, Name, Age, Email)というテーブルを作成せよ。
2. studentsテーブルに、`Address`列を追加せよ。
3. studentsテーブルから、`Email`列を削除せよ。
4. studentsテーブルを削除せよ。

## 制約

### 主キー

主キー（primary key）はタプルを一意識別するために使用される。

SQLiteでは、主キーはテーブル作成時に指定することができます。

```sql
CREATE TABLE table_name (
    column1_name data_type PRIMARY KEY,
    column2_name data_type,
    ...
);
```

以下の例では、`ID`列を主キーとして指定しています。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER
);
```

主キーが複数の列から構成される場合は、次のように指定します。

```sql
CREATE TABLE table_name (
    column1_name data_type,
    column2_name data_type,
    ...,
    PRIMARY KEY (column1_name, column2_name)
);
```

以下の例では、`StudentID`と`CourseID`の2つの列を主キーとして指定しています。

```sql
CREATE TABLE scores (
    StudentID INTEGER,
    CourseID INTEGER,
    Score INTEGER,
    PRIMARY KEY (StudentID, CourseID)
);
```
