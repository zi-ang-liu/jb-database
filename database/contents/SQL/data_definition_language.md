# データ定義言語

## CREATE DATABASE

`CREATE DATABASE`文は、データベースを作成するために使用されます。書式は次のとおりです。

```sql
CREATE DATABASE db_name;
```

`db_name`には、作成するデーギベースの名前を指定します。

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

データ型には、数値型、文字列型、日付型などがあります。

以下に一部のデータ型を示します。

- 数値型: 
    - `INT`: 整数型
    - `FLOAT`: 浮動小数点型
- 文字列型:
    - `CHAR(n)`: 固定長文字列、`n`は文字数
    - `VARCHAR(n)`: 可変長文字列、`n`は最大文字数
- 日付型:
    - `DATE`: 日付型、`YYYY-MM-DD`形式
    - `TIME`: 時刻型、`HH:MM:SS`形式
    - `DATETIME`: 日時型、`YYYY-MM-DD HH:MM:SS`形式

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

