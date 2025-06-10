# GROUP BY

`GROUP BY`句は，データをグループ化するために使用されます。特に，`SUM()`，`AVG()`，`COUNT()`などの集約関数と組み合わせて使用されます。

## 構文

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE condition
GROUP BY column_name;
```

## 使用例

