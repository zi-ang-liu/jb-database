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

## データの挿入

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


