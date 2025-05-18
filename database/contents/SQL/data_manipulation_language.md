# データ操作言語

## データの追加

`INSERT INTO`文を使用して、テーブルに新しい行を追加します。

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

すべての列にデータを追加する場合は、列名を省略することもできます。

```sql
INSERT INTO users 
VALUES ('002', 'Bob', 30);
```