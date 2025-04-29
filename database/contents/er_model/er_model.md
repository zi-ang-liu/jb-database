# 実体関連モデル

```{epigraph}
The purpose of abstracting is not to be vague, but to create a new semantic level in which one can be absolutely precise.

-- Edsger W. Dijkstra
```


<!-- :::{note}

チェンの論文では、英語

- P. P.-S. Chen, “English, Chinese and ER diagrams,” Data Knowl. Eng., vol. 23, no. 1, pp. 5–16, Jun. 1997.

英語の
(Correspondance between English sentences structure and ERD (Entity-Relationship Diagram) constructs.)

| 品詞     | ER構造     |
| :------- | :--------- |
| 一般名詞 | 実体型     |
| 固有名詞 | 実体       |
| 他動詞   | 関連型     |
| 自動詞   | 属性型     |
| 形容詞   | 実体の属性 |
| 副詞     | 関連の属性 |
::: -->

## データモデリング

データベースを構築するには、一般的に以下の三つのデータモデルを順番に設計する。

1. **概念モデル**（Conceptual Data Model）：ある記号系を用いて実世界の構造と意味を表現するモデル。
2. **論理モデル**（Logical Data Model）：概念モデルを実装可能な形式に変換したモデル。
3. **物理モデル**（Physical Data Model）：物理的な観点で記述されるデータモデル。

:::{note}
複数の段階に分けてデータモデルを設計する考え方は、**抽象化**（abstraction）という。抽象化はコンピュータ科学の基本的な考え方である。
:::

## 概念モデル

リレーショナルデータベースにおいて、概念モデリングのための記号系は**実体関連モデル**（Entity-Relationship Model, ERモデル）である。実体関連モデルは1976年にピーター・チェン（陳品山）によって提案された。実体関連モデルを図で表現したものを**実体関連図**（entity-relationship diagram, ER図）と呼ぶ。

リレーショナルデータモデルは論理モデルのための記号系であり、実体関連モデルはリレーショナルデータベーススキーマ（relational database schema）に変換される。

| RDB        | 記号系                     |
| :--------- | :------------------------- |
| 概念モデル | 実体関連モデル             |
| 論理モデル | リレーショナルデータモデル |


## 実体関連モデルと実体関連図

**実体関連モデル**は、実体、関連、属性の三つの要素から構成される。

実体関連モデルを図で表現したものを**実体関連図**（entity-relationship diagram, ER図）と呼ぶ。**Chen記法**と**Crow's Foot記法**が代表的な記法である。

:::{note}
Crow's Footは「鳥の足」という意味で、関連型が「鳥の足」のように見えることから名付けられた。IE記法（Information Engineering記法）とも呼ばれる。
:::

### 実体と実体型

**実体**（entity）は、現実世界に存在する物体や事象を表す。**実体型**（entity type）は、実体集合（entity set）を表す。実体は実体型のインスタンス（instance）である。例えば、個々の顧客は実体であり、抽象化された顧客集合は`CUSTOMER`という実体型で表される。

実体型は一般的に名詞で、英語の大文字で表現される。`STUDENT`、`CLASS`、`PROFESSOR`などが実体型の例である。

:::{note}
学術的には、「実体型」と「実体」は厳密に区別されるが、実務上は「実体」という用語が「実体型」を指すことが多い。
:::

Crow's Foot記法では、実体型は長方形で表現される。

例えば、顧客を表す実体型`CUSTOMER`は次のように表現される。

```{mermaid}
---
title: CUSTOMER entity
---
erDiagram
    CUSTOMER {
        }
```
    
### 関連と関連型

**関連**（relationship）は、実体間の関係を表す。**関連型**（relationship type）は、実体型間の抽象化された関係を表す。関連型は一般的に動詞で、英語の小文字で表現される。

例えば、
- a STUDENT *takes* a CLASS
- a PROFESSOR *teaches* a CLASS

Crow's Foot記法は、`o`、`|`、`{`の三つの記号を用いて、実体間の関連型を表現する。ここでは、`{`を鳥の足記号を表現している。

| Notation      | Meaning |
| :------------ | :------ |
| `o`           | Zero    |
| `\|`          | One     |
| `{`（鳥の足） | Many    |

これらの記号の組み合わせで、Crow's Foot記法では以下のような表現もできる。

| Notation | Meaning      |
| :------- | :----------- |
| `o\|`    | Zero or one  |
| `\|\|`   | Exactly one  |
| `o{`     | Zero or more |
| `\|{`    | One or more  |


:::{note}
実体間の関連型は基本的に次の三種類がある。

- One-to-One（1対1、1:1）
- One-to-Many（1対多、1:N）
- Many-to-Many（多対多、N:M）

Crow's Foot記法は、1対多（0以上）、1対1（0または1）などの関連型が表現できる。
:::

#### One-to-One

`UNIVERSITY`と`PRESIDENT`という二つの実体型があるとき、両者の関連を`has`という関連型がある。`||`を用いて、「Exactly one」を表現している。

- An university has one president.
- A president is in charge of one university.

```{mermaid}
erDiagram
    UNIVERSITY ||--|| PRESIDENT : has
    UNIVERSITY{
    }
    PRESIDENT{
    }
```

`PERSON`と`CUSTOMER ACCOUNT`という二つの実体型があるとき、両者の関連を`has`という関連型がある。`o|`を用いて、「Zero or one」を表現している。

- A person has zero or one customer account.
- A customer account is owned by one person.

```{mermaid}
erDiagram
    p[Person] {
    }
    a["Customer Account"] {
    }
    p ||--o| a : has
```


#### One-to-Many

例えば、`CUSTOMER`と`ORDER`という二つの実体型があるとき、両者の関連を`places`という関連型がある。この関連型はone-to-manyである。顧客の注文はOptionalである。

- A customer can place zero or more orders.
- Each order is placed by one customer.

```{mermaid}
erDiagram
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER {
    }
    ORDER {
    }
```



#### Many-to-Many

`STUDENT`と`COURSE`という二つの実体型があるとき、両者の関連を`takes`という関連型がある。この関連型はmany-to-manyである。

- A student can take many courses.
- A course can be taken by many students.

#### Optional vs Mandatory

さらに、関連型は**optional**（任意）と**mandatory**（必須）に分けられる。

##### Optional

- A customer can place **zero or more** orders.

##### Mandatory

- An order contains **one or more** items.


### 属性

実体型や関連型は、属性を持つことができる。**属性**（attribute）は、実体や関連の性質を表す。

例えば、「科目」という実体型には「科目ID」、「科目名」、「単位数」などの属性がある。


<!-- https://dbnote.hontolab.org/content/er-model/01.html -->



### 属性

属性は実体型の下に記述される。属性が主キーである場合、PKと記述される。外部キーである場合、FKと記述される。

実体型`CUSTOMER`は、属性`custNumber`、`name`、`sector`を持つ。`custNumber`は主キーである。

```{mermaid}
---
title: CUSTOMER entity
---
erDiagram
    CUSTOMER {
            string custNumber PK
            string name
            string sector
        }
```

また、`ORDER`は、顧客の注文を表す実体型である。属性`orderNumber`、`deliveryAddress`を持つ。`orderNumber`は主キーである。

```{mermaid}
---
title: ORDER entity
---
erDiagram
    ORDER {
            int orderNumber PK
            string deliveryAddress
        }
```

### 関連型

関連型は**one-to-one**、**one-to-many**、**many-to-many**の三種類で表現される。

#### One-to-one






