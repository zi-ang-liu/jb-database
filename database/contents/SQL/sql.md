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