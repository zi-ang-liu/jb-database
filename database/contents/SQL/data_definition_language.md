# データ定義言語

## CREATE DATABASE

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

