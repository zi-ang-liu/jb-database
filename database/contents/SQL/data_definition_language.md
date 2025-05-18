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





### 

<!-- ## CREATE DATABASE

**CREATE DATABASE文**は、データベースを作成するために使用されます。

### 構文

```sql
CREATE DATABASE database_name;
```

「database_name」には、作成するデータベースの名前を指定します。

### 例

例として、`test_db`というデータベースを作成する場合は、次のようにします。

```sql
CREATE DATABASE test_db;
```

`CREATE DATABASE`のような命令は、SQLの予約語と呼ばれます。他にも`SELECT`、`DROP`、`IN`などがあります。SQLの文では、予約語を大文字と小文字を区別しませんが、一般的に予約語は大文字で記述する。

また、SQLの文末にはセミコロン`;`を付けることが必要です。`;`がないとエラーが発生することがあります。

```{note}
**SQLの基本ルール**
- 文末にはセミコロン`;`を付ける
- 予約語は大文字で記述する
```

## DROP DATABASE

`DROP DATABASE`文は、データベースを削除するために使用されます。書式は次のとおりです。

```sql
DROP DATABASE db_name;
```

## データ型

SQLiteでは，全ての値は，次の5つのstorage classのいずれかに分類されます。

- NULL
- INTEGER
- REAL
- TEXT
- BLOB


## CREATE TABLE

`CREATE TABLE`文は、テーブルを作成するために使用されます。書式は次のとおりです。

```sql
CREATE TABLE table_name (
    column1_name data_type,
    column2_name data_type,
    ...
);
```

`table_name`には、作成するテーブルの名前を指定します。`column1_name`、`column2_name`には、テーブルの列名を指定します。`data_type`には、列のデータ型を指定します。

例として、`students`というテーブルを作成する場合は、次のようにします。

```sql
CREATE TABLE students (
    id INT,
    name VARCHAR(50),
    age INT
);
```
 -->
