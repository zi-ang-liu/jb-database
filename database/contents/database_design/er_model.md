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

<!-- 1. https://dbnote.hontolab.org/content/er-model/01.html
2. https://www.ibe.kagoshima-u.ac.jp/static/www1/edu/database/ERD.html -->

## データモデリング

データベースを構築するには、一般的に以下の三つのデータモデルを順番に設計する。

1. **概念モデル**（Conceptual Data Model）：ある記号系を用いて実世界の構造と意味を表現するモデル。
2. **論理モデル**（Logical Data Model）：概念モデルを実装可能な形式に変換したモデル。
3. **物理モデル**（Physical Data Model）：物理的な観点で記述されるデータモデル。

:::{note}
複数の段階に分けてデータモデルを設計する考え方は、**抽象化**（abstraction）という。抽象化はコンピュータ科学の基本的な考え方である。
:::

```{mermaid}
flowchart TD
    Miniword --> 概念モデル
    概念モデル --> 論理モデル
    論理モデル --> 物理モデル
```

### RDBMSの構築

```{mermaid}
flowchart TD
    Miniword --> 実体関連モデル
    実体関連モデル -->|実体関連図| リレーショナルモデル
    リレーショナルモデル -->|リレーショナルデータベーススキーマ| 物理モデル
```

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

例えば、`CUSTOMER`と`ORDER`と`LINE-ITEM`という三つの実体型があるとき、`CUSTOMER`は`ORDER`を`places`、`ORDER`は`LINE-ITEM`を`contains`という関連型で結ぶことができる。さらに、これらの関連型には、対応関係を表すための**濃度**（cardinality）がある。

- A CUSTOMER places *zero or more* ORDERS.
- An ORDER is placed by *exactly one* CUSTOMER.
- AN ORDER contains *one or more* LINE-ITEMS.
- A LINE-ITEM is contained in *exactly one* ORDER.

Crow's Foot記法では、以下のように表現される。

```{mermaid}
erDiagram
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER {
    }
    ORDER ||--|{ LINE-ITEM : contains
    ORDER {
    }
    LINE-ITEM {
    }
```

Crow's Foot記法は、`o`、`|`、`{`の三つの記号を用いて、実体間の関連型を表現する。ここでは、`{`を鳥の足記号を表現している。

| Notation      | Meaning |
| :------------ | :------ |
| `o`           | Zero    |
| `\|`          | One     |
| `{`（鳥の足） | Many    |

これらの記号の組み合わせで、Crow's Foot記法では以下のような表現もできる。

| Notation | Meaning      | Type      |
| :------- | :----------- | :-------- |
| `o\|`    | Zero or one  | Optional  |
| `\|\|`   | Exactly one  | Mandatory |
| `o{`     | Zero or more | Optional  |
| `\|{`    | One or more  | Mandatory |

少なくとも一つの実体が必要な場合は、`|`を用いて「Mandatory」（必須）を表現する。例えば、大学では少なくとも一人の学長が必要である。
一方、実体が存在しなくてもよい場合は、`o`を用いて「Optional」（任意）を表現する。例えば、注文システムでは顧客が注文を持たない場合もある。


:::{note}
実体間の関連型は基本的に次の三種類がある。

- One-to-One（1対1、1:1）
- One-to-Many（1対多、1:N）
- Many-to-Many（多対多、N:M）

Crow's Foot記法は、1対多（0以上）、1対1（0または1）などの関連型が表現できる。
:::

#### Exactly one

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

#### Zero or one

`PERSON`と`CUSTOMER ACCOUNT`という二つの実体型があるとき、両者の関連を`has`という関連型がある。`o|`を用いて、「Zero or one」を表現している。

- A person has zero or one customer account.
- A customer account is owned by one person.

```{mermaid}
erDiagram
    p[PERSON] {
    }
    a["ACCOUNT"] {
    }
    p ||--o| a : has
```


#### Zero or more

例えば、`CUSTOMER`と`ORDER`という二つの実体型があるとき、両者の関連を`places`という関連型がある。`o{`を用いて、「Zero or more」を表現している。

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

#### One or more

`ORDER`と`LINE-ITEM`という二つの実体型があるとき、両者の関連を`contains`という関連型がある。`|{`を用いて、「One or more」を表現している。

- An order contains one or more line items.
- A line item is contained in exactly one order.

```{mermaid}
erDiagram
    ORDER ||--|{ LINE-ITEM : contains
    ORDER {
    }
    LINE-ITEM {
    }
```

### 属性

実体型や関連型は、属性を持つことができる。**属性**（attribute）は、実体や関連の性質を表す。

Crow's Foot記法では、属性は実体型や関連型の下に記述される。属性は実体型や関連型の性質を表す。属性が主キーである場合、PKと記述される。外部キーである場合、FKと記述される。

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

`ORDER`は、顧客の注文を表す実体型である。属性`orderNumber`、`deliveryAddress`を持つ。`orderNumber`は主キーである。

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

`LINE-ITEM`は、注文の明細を表す実体型である。属性`productCode`、`quantity`、`pricePerUnit`を持つ。`productCode`は主キーである。

```{mermaid}
---
title: LINE-ITEM entity
---
erDiagram
    LINE-ITEM {
        string productCode
        int quantity
        float pricePerUnit
    }
```

`CUSTOMER`、`ORDER`、`LINE-ITEM`の三つの実体型を持つER図は次のように表現される。

```{mermaid}
erDiagram
    CUSTOMER ||--o{ ORDER : places
    CUSTOMER {
        string name
        string custNumber PK
        string sector
    }
    ORDER ||--|{ LINE-ITEM : contains
    ORDER {
        int orderNumber PK
        string deliveryAddress
    }
    LINE-ITEM {
        string productCode PK
        int quantity
        float pricePerUnit
    }
```

## 弱実体型

**弱実体型**（weak entity type）は、自身の属性だけでは主キーを持たない実体型である。弱実体型を一意識別するためには、**所有実体型**（owner entity type）と呼ばれる実体型が必要である。

例えば、`EMPLOYEE`と`DEPENDENT`という二つの実体型があるとする。`DEPENDENT`は弱実体型であり、その所有実体型は`EMPLOYEE`である。
`EMPLOYEE`は`DEPENDENT`の間に`has`という関連型を持つ。このような関連型を**識別関連型**（identifying relationship type）と呼ぶ。

`DEPENDENT`は`name`（first name）と`birthDate`（date of birth）という属性を持つが、これらの属性だけでは`DEPENDENT`を一意に識別できない。
`DEPENDENT`の`name`と`EMPLOYEE`の`employeeNumber`を組み合わせて、初めて`DEPENDENT`を一意に識別できる。`name`のような属性（集合）を**部分キー**（partial key）と呼ぶ。部分キーと所有実体型の主キーを組み合わせて、弱実体型を一意に識別する。

Crow's Foot記法では、所有実体型の主キーを弱実体型の外部キーとして表現する。

```{mermaid}
erDiagram
    EMPLOYEE ||--o{ DEPENDENT : has
    EMPLOYEE {
        string employeeNumber PK
        string firstName
        string lastName
        string department
    }
    DEPENDENT {
        string name PK
        string employeeNumber PK, FK
        date birthDate
    }
```

<!-- ## リレーショナルデータベーススキーマへの変換

### 実体型の変換

````{prf:definition}
:label: definition-entity-to-relation
:nonumber:
$E(\underline{K}, A_1, A_2, \ldots, A_n)$という実体型$E$があるとき，リレーションスキーマ$R(\underline{K}, A_1, A_2, \ldots, A_n)$に変換される
````

```{mermaid}
erDiagram
    CUSTOMER {
        string custNumber PK
        string name
        string sector
    }
```

実体型`CUSTOMER`は、リレーションスキーマ$\text{CUSTOMER}(\underline{\text{custNumber}}, \text{name}, \text{sector})$に変換される。

### 1対1関連型の変換

````{prf:definition}
:label: definition-one-to-one
:nonumber:
$R(C_1, C_2, ..., C_p)$を$E_1(\underline{K}, A_1, A_2, \ldots, A_n)$と$E_2(\underline{H}, B_1, B_2, \ldots, B_m)$という二つの実体型の1対1関連型$R$とする。$R$は次のいずれかのリレーションスキーマに変換される。
- $\boldsymbol{R}(\underline{K}, H, C_1, C_2, \ldots, C_p)$
- $\boldsymbol{R}(\underline{H}, K, B_1, B_2, \ldots, B_m)$
````

```{mermaid}
erDiagram
    EMPLOYEE {
        string employeeNumber PK
        string firstName
        string lastName
        string department
    }
    COMPANY-CAR {
        string CarID PK
        string Model
        date Purchase Date
    }
    EMPLOYEE ||--|| COMPANY-CAR : has
```

実体型`EMPLOYEE`と`COMPANY-CAR`は、1対1の関連型`has`を持つ。リレーションスキーマは次のいずれかの形式に変換される。
- $\text{has}(\underline{\text{employeeNumber}}, \text{CarID})$
- $\text{has}(\underline{\text{CarID}}, \text{employeeNumber})$

### 1対多関連型の変換

````{prf:definition}
:label: definition-one-to-many
:nonumber:
$R(C_1, C_2, ..., C_p)$を$E_1(\underline{K}, A_1, A_2, \ldots, A_n)$と$E_2(\underline{H}, B_1, B_2, \ldots, B_m)$という二つの実体型の1対多関連型$R$とする。$R$は次のリレーションスキーマに変換される。
- $\boldsymbol{R}(K, \underline{H}, C_1, C_2, \ldots, C_p)$
````

```{mermaid}
erDiagram
    MANUFACTURER {
        string companyNumber PK
        string address
    }
    PRODUCT {
        string productCode PK
        string name
    }
    MANUFACTURER ||--o{ PRODUCT : produces
````

実体型`MANUFACTURER`と`PRODUCT`は、1対多の関連型`produces`を持つ。リレーションスキーマは$\text{produces}(\underline{\text{productCode}}, \text{companyNumber})$に変換される。

### 多対多関連型の変換

````{prf:definition}
:label: definition-many-to-many
:nonumber:
$R(C_1, C_2, ..., C_p)$を$E_1(\underline{K}, A_1, A_2, \ldots, A_n)$と$E_2(\underline{H}, B_1, B_2, \ldots, B_m)$という二つの実体型の多対多関連型$R$とする。$R$は次のリレーションスキーマに変換される。
- $\boldsymbol{R}(\underline{K}, \underline{H}, C_1, C_2, \ldots, C_p)$
````

```{mermaid}
erDiagram
    STUDENT {
        string studentID PK
        string firstName
        string lastName
    }
    CLASS {
        string classID PK
        string className
    }
    STUDENT }|--|{ CLASS : enrolls
````

実体型`STUDENT`と`CLASS`は、多対多の関連型`enrolls`を持つ。リレーションスキーマは$\text{enrolls}(\underline{\text{studentID}}, \underline{\text{classID}})$に変換される。

### 弱実体型の変換

````{prf:definition}
:label: definition-weak-entity
:nonumber:
$E_\text{weak}(\underline{K}, A_1, A_2, \ldots, A_n)$を弱実体型$E$とし，$E_\text{owner}(\underline{H}, B_1, B_2, \ldots, B_m)$を所有実体型$E_\text{owner}$とする。$E_\text{weak}$は次のリレーションスキーマに変換される。

- $\boldsymbol{R_\text{weak}}(\underline{H}, \underline{K}, A_1, A_2, \ldots, A_n)$
````

```{mermaid}
erDiagram
    EMPLOYEE {
        string employeeNumber PK
        string firstName
        string lastName
        string department
    }
    DEPENDENT {
        string name PK
        date birthDate
    }
    EMPLOYEE ||--o{ DEPENDENT : has
````

実体型`EMPLOYEE`は、実体型`DEPENDENT`の所有実体型である。リレーションスキーマは$\text{DEPENDENT}(\underline{\text{employeeNumber}}, \underline{\text{name}}, \text{birthDate})$に変換される。 -->

## 具体例

### ER図

学生、履修、科目の三つの実体型を持つER図は次のように表現される。

```{mermaid}
erDiagram
    STUDENT {
        string studentID PK
        string firstName
        string lastName
        string address
    }
    ENROLLMENT {
        string studentID PK, FK
        string classID PK, FK
        date enrollmentDate
    }
    CLASS {
        string classID PK
        string className
        string professorID
    }
    STUDENT ||--o{ ENROLLMENT : enrolls
    CLASS ||--o{ ENROLLMENT : contains
```

### リレーションナルデータベーススキーマ

- STUDENT(<u>studentID</u>, firstName, lastName, address)
- ENROLLMENT(<u>studentID</u>, <u>classID</u>, enrollmentDate)
- CLASS(<u>classID</u>, className, professorID)
- ENROLLMENTのstudentIDはSTUDENTのstudentIDの外部キーである。
- ENROLLMENTのclassIDはCLASSのclassIDの外部キーである。

## draw.ioを用いたER図の作成

[draw.io](https://www.drawio.com)は無料で利用できる作図ツールである。draw.ioを用いたERDの作成について[こちら](https://drawio-app.com/erd/)に詳しい説明がある。

以下の手順でdraw.ioを用いてER図を作成することができる。

1. [draw.io](https://www.drawio.com)にアクセスし、「Start」をクリックする。
2. 「Create New Diagram」をクリックする。
3. 「Basic」から「Entity Relationship Diagram」を選択する。
4. 「Create」をクリックする。
5. [こちら](https://www.youtube.com/watch?v=JYZPdU5F2iM)を参考にして、ER図を作成する。

:::{note}
この資料に載せているER図は、[Mermaid.js](https://mermaid.js.org/)を用いて作成したものである。[Mermaid.js](https://mermaid.js.org/)は、MarkdownでER図を作成できるツールである。Mermaid.jsを用いたERDの作成について[こちら](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)に詳しい説明がある。

1. [こちら](https://mermaid.js.org/syntax/entityRelationshipDiagram.html)にアクセスし、使い方を学ぶ。
2. [こちら](https://mermaid.js.org)にアクセスし、「Try Playground」をクリックする。
3. 下側にある「Code」をクリックし、ER図を作成する。

他にも、[Microsoft Visio](https://www.microsoft.com/ja-jp/microsoft-365/visio/flowchart-software)や[Lucidchart](https://www.lucidchart.com/)などのツールもある。
:::

## 練習

1. 学生、履修、科目の三つの実体型を持つER図をdraw.ioを用いて作成せよ。
2. A大学では、教員（PROFESSOR）は学生（STUDENT）を指導(advises)する。一名の教員は0人以上の学生を指導する。一名の学生は一名の教員に指導される。教員は、教員番号（professorID）、名前（name）、学部（department）を持つ。学生は、学生番号（studentID）、名前（name）、住所（address）、教員番号（professorID）を持つ。学生の教員番号は教員の教員番号の外部キーである。ER図をdraw.ioを用いて作成せよ。
3. A大学の教室管理システムを作成するために、BUILDING、ROOM、CLASSの三つの実体型を持つER図をdraw.ioを用いて作成せよ。BUILDINGは、建物ID（buildingID）、建物名（buildingName）を持つ。ROOMは、部屋番号（roomNumber）、建物ID（buildingID）、部屋種類（roomType）を持つ。CLASSは、科目ID（classID）、部屋番号（roomNumber）、科目時間（classTime）を持つ。主キー、外部キーは適切に設定せよ。
    - A building contains zero or more rooms.
    - A room is contained in exactly one building.
    - A room is used for zero or more classes.
    - A class is held in exactly one room.


## 発展的実習

大学管理システムを作成するために、下記の実体型を持つER図をdraw.ioを用いて作成せよ。属性などは適切に設定せよ。

- PROFESSOR
- SCHOOL
- DEPARTMENT
- SEMESTER
- CLASS
- ROOM
- BUILDING
- COURSE
- STUDENT
- ENROLLMENT