# SQL

## SQLの歴史

- 1970: Edgar F. Coddが「A Relational Model of Data for Large Shared Data Banks」という論文を発表し，関係モデルを提唱．
- 1974: IBMがSystem Rプロジェクトを開始し，関係データベースの実装を試みる．SQLの前身であるSEQUEL（Structured English Query Language）が開発される．
- 1986: ANSI（米国規格協会）がSQLを標準化し，SQL-86として発表．
- 1989: ISO（国際標準化機構）がSQLを国際標準化し，SQL-89として発表．
- ...
- 2023: 最新のSQL標準である[ISO/IEC 9075:2023](https://www.iso.org/standard/76583.html)が発表される．

## SQLとは

**SQL（Structured Query Language）** はRDBMSにおいてデータの操作を行うためのドメイン固有言語である．

SQLは以下4種類の命令に分類される．

- データ定義言語（DDL）
- データ操作言語（DML）
- データ制御言語（DCL）
- トランザクション制御言語（TCL）

リレーショナル代数の8つの演算のうち，和，差，共通，直積，選択，射影の5つの演算が独立である．その他の演算は，これらの演算を組み合わせることで実現できる．SQLは，和，差，共通，直積，選択，射影の5つの演算を表現することができるから，**リレーショナル完備**である．ただし，SQLは**チューリング完全**ではない．

:::{note}
C, C++, Java, Pythonなどのプログラミング言語は，チューリング完全である．
:::

## SQLite

[SQLite](https://www.sqlite.org)は，C言語で実装された軽量なRDBMSである．

- [オープンソース](https://sqlite.org/src/doc/trunk/README.md)
- [最も広く使われているRDBMS](https://sqlite.org/mostdeployed.html)

### インストール

[VSCode](https://code.visualstudio.com/)の拡張機能を使ってSQLiteをインストールする．

1. VSCodeを起動する．
2. 左側の拡張機能アイコンをクリックする．
3. 検索ボックスに「SQLite」と入力する．
4. 「install」をクリックし，SQLiteをインストールする．
5. インストールが完了したら，VSCodeを再起動する．

### 作業フォルダーの作成

1. 作業フォルダー「learning_sqlite」を作成する．
2. VSCodeを起動し，「learning_sqlite」フォルダーを開く．
3. 「learning_sqlite」フォルダー内に「test.db」と「test.sql」という2つのファイルを作成する．
4. 「test.sql」ファイルを開く．

### テーブルの作成

下記のSQL文を「test.sql」ファイルに記述する．
```sql
CREATE TABLE users (
    ID TEXT,
    Name TEXT,
    Age INTEGER
);
INSERT INTO users (ID, Name, Age)
VALUES ('001', 'Alice', 25);
```

入力したSQL文を実行するには，以下の手順を実行する．
1. 実行したいSQL文を選択する．
2. <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>を押す．
3. 「SQLite」と入力し，「SQLite: Run Selected Query」を選択する．
4. 「test.db」を選択する．
5. <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>を押す．
6. 「SQLite」と入力し，「SQLite: Open Database」を選択する．
7. 「test.db」を選択する．
8. VSCodeの左下にある「SQLite Explorer」をクリックする．
9. 「Refresh」ボタンをクリックし，「users」テーブルが作成されていることを確認する．
10. 「users」の右側にある三角形のアイコンをクリックする．
11. 下記のように表示されることを確認する．

| ID  | Name  | Age |
| --- | ----- | --- |
| 001 | Alice | 25  |