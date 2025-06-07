# SQLiteのインストール

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