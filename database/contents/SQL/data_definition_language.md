# データ定義言語

データ定義言語（Data Definition Language, DDL）は、データを定義するためのSQL文を指します。DDLは、テーブルの作成、変更、削除など、データベースの構造を定義するために使用されます。DDLの主なコマンドには、`CREATE`、`ALTER`、`DROP`などがあります。さらに、制約（constraints）を使用して、データの整合性を保つためのルールを定義することもできます。

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

### データの追加

テーブルを作成した後、データを追加するには、`INSERT INTO`文を使用します。書式は次のとおりです。

```sql
INSERT INTO table_name (column1_name, column2_name, ...)
VALUES (value1, value2, ...);
```

次の例では、`users`テーブルにデータを追加します。

```sql
INSERT INTO users (ID, Name, Age)
VALUES ('001', 'Alice', 25);
```

```{note}
`INSERT`文は、DDLではなく、データ操作言語（DML）に分類されます。説明の都合上、ここに記載しています。
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


## 練習１

1. students(StudentID, Name, Age, Email)というテーブルを作成せよ。
2. studentsテーブルに、`Address`列を追加せよ。
3. studentsテーブルから、`Email`列を削除せよ。
4. studentsテーブルに、`INSERT INTO`文を使用して、任意のデータを追加せよ。
5. studentsテーブルを削除せよ。

## 制約

### 主キー

主キー（primary key）はタプルを一意識別するために使用される。

#### 主キーの指定（1）

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

#### 主キーの指定（2）

複数の列を組み合わせて主キーを指定することもできます。

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

### 外部キー


外部キー（foreign key）は、他のテーブルの主キーを参照するために使用されます。外部キーは、リレーション間の関係を表現するための制約です。

#### 外部キーの指定（1）

SQLiteでは、外部キーはテーブル作成時に指定することができます。

```sql
CREATE TABLE table_name (
    column_name data_type REFERENCES other_table(column_name),
    ...
);
```

例えば、employees(<u>EmployeeID</u>, Name, DepartmentID)とdepartments(<u>DepartmentID</u>, DepartmentName)という2つのテーブルがあるとします。`employees`テーブルの`DepartmentID`列は、`departments`テーブルの`DepartmentID`列を参照する外部キーとして指定できます。

```sql
CREATE TABLE departments (
    DepartmentID INTEGER PRIMARY KEY,
    DepartmentName TEXT
);

CREATE TABLE employees (
    EmployeeID INTEGER PRIMARY KEY,
    Name TEXT,
    DepartmentID INTEGER REFERENCES departments(DepartmentID)
);
```

#### 外部キーの指定（2）

外部キーは、下記のように指定することもできます。

```sql
CREATE TABLE table_name (
    column1_name data_type,
    column2_name data_type,
    ...,
    FOREIGN KEY (column1_name) REFERENCES other_table(column_name)
);
```

以下の例では、`employees`テーブルの`DepartmentID`列が、`departments`テーブルの`DepartmentID`列を参照する外部キーとして指定されています。

```sql
CREATE TABLE departments (
    DepartmentID INTEGER PRIMARY KEY,
    DepartmentName TEXT
);

CREATE TABLE employees (
    EmployeeID INTEGER PRIMARY KEY,
    Name TEXT,
    DepartmentID INTEGER,
    FOREIGN KEY (DepartmentID) REFERENCES departments(DepartmentID)
);
```

### NOT NULL制約

NOT NULL制約は、列にNULL値を許可しないことを指定します。NOT NULL制約は以下のように指定します。

```sql
CREATE TABLE table_name (
    column_name data_type NOT NULL,
    ...
);
```

以下の例では、`Name`列にNOT NULL制約を指定しています。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT NOT NULL,
    Age INTEGER
);
```

`NOT NULL`制約を指定されていない列はNULL値を許可します。この例では、`Age`列はNULL値を許可します。

### UNIQUE制約

UNIQUE制約は、列の値が一意であることを指定します。UNIQUE制約は以下のように指定します。

```sql
CREATE TABLE table_name (
    column_name data_type UNIQUE,
    ...
);
```

以下の例では、`Email`列にUNIQUE制約を指定しています。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Email TEXT UNIQUE
);
```

### CHECK制約

CHECK制約は、列の値が特定の条件を満たすことを指定します。CHECK制約は以下のように指定します。

```sql
CREATE TABLE table_name (
    column_name data_type CHECK (expression),
    ...
);
```

以下の例では、`Age`列にCHECK制約を指定しています。ユーザーの年齢は18歳以上でなければなりません。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER CHECK (Age >= 18)
);
```

`AND`や`OR`を使用して複数の条件を組み合わせることもできます。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER CHECK (Age >= 18 AND Age <= 65)
);
```

テーブルレベルの制約を指定することもできます。

```sql
CREATE TABLE table_name (
    column1_name data_type,
    column2_name data_type,
    ...,
    CONSTRAINT constraint_name CHECK (expression)
);
```

以下の例では、products(<u>ProductID</u>, ProductName, Price, DiscountPrice)というテーブルに、`Price >= DiscountPrice`という制約を指定しています。

```sql
CREATE TABLE products (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    Price REAL,
    DiscountPrice REAL,
    CONSTRAINT PriceCheck CHECK (Price >= DiscountPrice)
);
```

### DEFAULT制約

DEFAULT制約は、列にデフォルト値を指定します。DEFAULT制約は以下のように指定します。

```sql
CREATE TABLE table_name (
    column_name data_type DEFAULT default_value,
    ...
);
```

以下の例では、`Age`列にデフォルト値として`18`を指定しています。

```sql
CREATE TABLE users (
    ID TEXT PRIMARY KEY,
    Name TEXT,
    Age INTEGER DEFAULT 18
);
```

## 練習２

1. departments(<u>DepartmentID</u>, DepartmentName)というテーブルを作成せよ。
   - `DepartmentID`は主キーとする
   - `DepartmentName`はNULLを許可しない制約を付けよ。
2. students(<u>StudentID</u>, Name, Age, Email, DepartmentID)というテーブルを作成せよ。
   - `StudentID`は主キーとする。
   - `Email`はUNIQUE制約を付けよ。
   - `DepartmentID`はdepartmentsテーブルの外部キーとする。
   - `Age`は18歳以上でなければならない制約を付けよ。
3. courses(<u>CourseID</u>, CourseName, Credits)というテーブルを作成せよ。
   - `CourseID`は主キーとする。
   - `Credits`は1以上の整数でなければならない制約を付けよ。
4. scores(<u>StudentID</u>, <u>CourseID</u>, Score)というテーブルを作成せよ。
   - `StudentID`はstudentsテーブルの外部キーとする。
   - `CourseID`はcoursesテーブルの外部キーとする。
   - `Score`は0以上100以下の整数でなければならない制約を付けよ。