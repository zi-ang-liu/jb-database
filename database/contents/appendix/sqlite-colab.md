# Python SQLite3モジュール

## 参考資料

- [sqlite3 — DB-API 2.0 interface for SQLite databases](https://docs.python.org/3/library/sqlite3.html)

## Cursor

### データベースの作成

`import sqlite3`を使用してSQLiteモジュールをインポートします．

`sqlite3.connect()` を呼び出して、SQLiteデータベースを作成します。以下のコードは、`example.db`というデータベースに接続します。データベースが存在しない場合は、新しく作成されます。

```python
import sqlite3
con = sqlite3.connect('example.db')
```

### `cursor`の作成

SQL文を実行し，結果を取得するために、`cursor`を作成します。

```python
cur = con.cursor()
```

### テーブルの作成

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
res.fetchone()
```

`('students',)`のような結果が返されれば、テーブルが正しく作成されています。


### データの追加

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

この結果には，一つの`list`に複数の`tuple`が含まれています。各`tuple`は、テーブルの各行を表しています。

### `list`からのデータの追加

以下の例では、pythonの`list`からデータを追加します。

```python
data = [
    ('s004', 'David', 23),
    ('s005', 'Eve', 19)
]
cur.executemany('''
INSERT INTO students (id, name, age) VALUES (?, ?, ?)''', data)
con.commit()
```

`?`はplaceholderで、`executemany()`メソッドは`data`リストの各要素を順番に置き換えます。

```python
res = cur.execute("SELECT * FROM students")
res.fetchall()
```

`cur.execute()`の結果をiterateすることで、各行を個別に処理することもできます。

```python
for row in cur.execute("SELECT name, age FROM students ORDER BY age"):
    print(row)
```


### `close()`メソッド

データベースの操作が完了したら、`close()`メソッドを使用して、`cursor`とデータベース接続を閉じます。

```python
cur.close()
con.close()
```

### データベースに接続する

作成したデータベースに再度接続するには、同じように`sqlite3.connect()`を使用します。

```python
new_con = sqlite3.connect('example.db')
new_cur = new_con.cursor()

res = new_cur.execute("SELECT * FROM students ORDER BY age DESC")
student_id, name, age = res.fetchone()
print(f'The oldest student is {name} with age {age}.')

new_cur.close()
new_con.close()
```

## pandas

```python
import pandas as pd
import sqlite3

# sample data
df = pd.DataFrame({
    'id': ['s001', 's002', 's003'],
    'name': ['Alice', 'Bob', 'Charlie'],
    'age': [20, 22, 21]
})

# write to SQLite database
con = sqlite3.connect('pd_example.db')
df.to_sql('students', con, if_exists='replace', index=False)

# read from SQLite database
df_read = pd.read_sql_query('SELECT * FROM students', con)
print(df_read)

# another query
df_read = pd.read_sql_query('SELECT name, age FROM students WHERE age > 20', con)
print(df_read)

# close connection
con.close()
```

## `pandas.DataFrame.to_sql()`

- https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_sql.html

`DataFrame`をSQLiteデータベースに書き込む．

```python
pandas.DataFrame.to_sql(name, con, schema=None, if_exists='fail', index=True, index_label=None, chunksize=None, dtype=None, method=None)

"""
parameters
---
name : str
    書き込むテーブルの名前．
con : sqlite3.Connection
    SQLiteデータベースへの接続オブジェクト．
"""
```

## `pandas.read_sql_query()`

- https://pandas.pydata.org/docs/reference/api/pandas.read_sql_query.html

SQLクエリの結果を`DataFrame`に読み込む．

```python
pandas.read_sql_query(sql, con, index_col=None, coerce_float=True, params=None, parse_dates=None, chunksize=None)

"""
parameters
---
sql : str
    SQLクエリ文．
con : str or sqlite3 connection
    SQLiteデータベースへの接続オブジェクト．
"""
```



