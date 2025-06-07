# Google ColabでSQLiteを使用する方法

- [sqlite3 — DB-API 2.0 interface for SQLite databases](https://docs.python.org/3/library/sqlite3.html)

## データベースの作成

`import sqlite3`を使用してSQLiteモジュールをインポートします．

`sqlite3.connect()` を呼び出して、SQLiteデータベースを作成します。以下のコードは、`example.db`というデータベースに接続します。データベースが存在しない場合は、新しく作成されます。

```python
import sqlite3
con = sqlite3.connect('example.db')
```

## `cursor`の作成

SQL文を実行し，結果を取得するために、`cursor`を作成します。

```python
cur = con.cursor()
```

## テーブルの作成

`execute()`メソッドを使用して、SQL文を実行します。

以下の例では、`students`というテーブルを作成します．

```python
cur.execute('''
CREATE TABLE students (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL
)''')
```

作成したテーブルを確認するために、`sqlite_master`テーブルをクエリします。

```python
res = cur.execute("SELECT name FROM sqlite_master")
res.fetchall()
```

`('students',)`のような結果が返されれば、テーブルが正しく作成されています。


## データの追加

`execute()`メソッドを使用して、データをテーブルに追加します。

以下の例では、`students`テーブルに3人の学生のデータを挿入します。

```python
cur.execute('''
INSERT INTO students (id, name, age) VALUES
('s001', 'Alice', 20),
('s002', 'Bob', 22),
('s003', 'Charlie', 21)
''')
```

`con.commit()`を呼び出して、変更をデータベースに保存します。

```python
con.commit()
```

```python
res = cur.execute("SELECT * FROM students")
res.fetchall()
```

`[('s001', 'Alice', 20), ('s002', 'Bob', 22), ('s003', 'Charlie', 21)]`のような結果が返されれば、データが正しく追加されています。




