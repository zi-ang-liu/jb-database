# SQL実習

SQLの書き方を身につけるため、[Chinookデータベース](chinook.md)を使用し、SQLの総合実習を行う。

## 問題

1. `tracks`テーブルから、`track_id`、`name`を取得するSQL文を書け。
2. `tracks`テーブルから、`track_id`、`name`、`albumid`を取得し、`albumid`で昇順に並べ替えるSQL文を書け。
3. `tracks`テーブルから、`track_id`、`name`、`albumid`を取得するSQL文を書け。ただし、`albumid`が`1`のものだけを対象とする。
4. `tracks`テーブルから、`track_id`、`name`、`albumid`を取得するSQL文を書け。ただし、以下の条件を満たすものとする。
   - `albumid`が`1`のもの
   - `milliseconds`が`200000`以上のもの
5. `tracks`テーブルから、`name`、`albumid`、`composer`を取得するSQL文を書け。ただし、`composer`の名前に`"Steve"`が含まれるものだけを対象とする。