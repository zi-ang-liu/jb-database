# 集約関数

**集約関数**（Aggregate Function）は、複数の値を受け取り、1つの値を返す関数です。SQLでは、集約関数を使用して、データの集計や統計情報を取得することができます。

以下は、SQLでよく使用される集約関数です。
- `SUM`：各行の合計値を求める
- `AVG`：各行の平均値を求める
- `MIN`：各行の最小値を求める
- `MAX`：各行の最大値を求める
- `COUNT`：行数を計算する

## MIN()関数とMAX()関数

`MIN()`関数は、指定した列の最小値を返します。`MAX()`関数は、指定した列の最大値を返します。

### 構文

```sql
SELECT MIN(column_name)
FROM table_name
WHERE condition;
```


```sql
SELECT MAX(column_name)
FROM table_name
WHERE condition;
```

### 例

次の例では、`products`テーブルから、`price`列の最小値と最大値を取得します。

```sql
CREATE TABLE products (
    id INT,
    name TEXT,
    price REAL
);

INSERT INTO products (id, name, price) VALUES
(1, 'Product A', 10.0),
(2, 'Product B', 20.0),
(3, 'Product C', 30.0);

SELECT MIN(price)
FROM products;

SELECT MAX(price)
FROM products;
```

すると、次のような結果が得られます。

| MIN(price) |
| ---------- |
| 10.0       |

| MAX(price) |
| ---------- |
| 30.0       |

`as`を使用して、列名を変更することもできます。

```sql
SELECT MIN(price) AS min_price
FROM products;
SELECT MAX(price) AS max_price
FROM products;
```

## COUNT()関数

### 構文

```sql
SELECT COUNT(column_name)
FROM table_name
WHERE condition;
```

### 例

