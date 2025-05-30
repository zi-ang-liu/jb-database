# 操作記述

```{epigraph}
Young man, in mathematics you don't understand things. You just get used to them.

-- John von Neumann
```

## 学習目標

- 和両立を理解し，与えられたリレーションが和両立か判定できる．
- リレーション代数の基本演算を理解し，計算できる．
- 与えられたリレーションに対して，目的に応じた演算を適用できる．
  
## リレーショナル代数

**リレーショナル代数**（relational algebra）はエドガー・F・コッドによって提案された，リレーションとして表現されたデータを操作するための代数的な演算の体系である．それを実装したデータベース言語はSQLである．

リレーション代数は次の基本演算から構成される．

- 和集合演算
- 差集合演算
- 共通集合演算
- 直積演算
- 射影演算
- 選択演算
- 結合演算
- 商演算

### 和両立

````{prf:definition}
:label: definition-union-compatible
:nonumber:
リレーション$R(A_1, A_2, \ldots, A_n)$とリレーション$S(B_1, B_2, \ldots, B_m)$が和両立（union compatible）とは，次の二つの条件を満たすことである．

1. $n = m$．
2. $\text{dom}(A_i) = \text{dom}(B_i)$であり，$1 \leq i \leq n$．
````

````{prf:example}
:nonumber:

ある大学の学生データベースには，2024年度入学生のデータを格納するリレーション`学生2024`と，2025年度入学生のデータを格納するリレーション`学生2025`がある．

- 学生2024(学籍番号, 氏名, 学科)
- 学生2025(学籍番号, 氏名, 学科)

`学生2024`と`学生2025`の次数は共に3であり，それぞれの属性の定義域は共通であるため，これらは和両立である．

````

````{prf:example}
:nonumber:

A社とB社の社員を表すリレーション`A社の社員`と`B社の社員`がある．A社の社員が事務部と営業部のどちらかに所属するのに対し，B社の社員が開発部と研究部のどちらかに所属するとする．

- A社の社員(社員番号, 氏名, 部署)
- B社の社員(社員番号, 氏名, 部署)

A社とB社の部署の定義域は異なるため，これらは和両立ではない．

````

### 和集合演算

````{prf:definition}
:label: definition-union
:nonumber:

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の和集合は，$R \cup S$で書く．その定義は次の通りである．

$$R \cup S = \{t \mid t \in R \text{ or } t \in S\}$$

$R$と$S$の和集合は，$R$または$S$に属するタプル全体の集合である．
````

````{prf:example}
:nonumber:

ある大学は工学部と理学部を持っており，それぞれの学生を表すリレーション`工学部学生`と`理学部学生`がある．

- 工学部学生(学籍番号, 氏名, 学科)
- 理学部学生(学籍番号, 氏名, 学科)

`工学部学生`と`理学部学生`の和集合は，その大学の全学生を表すリレーションである．

````

````{prf:example}
:nonumber:

ある大学のプログラミングとデータベースの授業を受講する学生を表すリレーション`プログラミング`と`データベース`がある．

プログラミング(学籍番号, 氏名, 学科)
| 学籍番号 | 氏名     | 学科       |
| -------- | -------- | ---------- |
| 202464   | 田中花子 | 機械工学科 |
| 202487   | 山田太郎 | 機械工学科 |
| ...      | ...      | ...        |

データベース(学籍番号, 氏名, 学科)
| 学籍番号 | 氏名     | 学科       |
| -------- | -------- | ---------- |
| 202464   | 田中花子 | 機械工学科 |
| 202490   | 佐藤次郎 | 情報工学科 |
| ...      | ...      | ...        |

`プログラミング`と`データベース`の和集合は，プログラミングまたはデータベースの授業を受講する学生を表すリレーションである．

| 学籍番号 | 氏名     | 学科       |
| -------- | -------- | ---------- |
| 202464   | 田中花子 | 機械工学科 |
| 202487   | 山田太郎 | 機械工学科 |
| 202490   | 佐藤次郎 | 情報工学科 |
| ...      | ...      | ...        |

集合は異なる元の集まりであるため，重複するタプルは除かれる．

````


### 差集合演算

````{prf:definition}
:label: definition-difference
:nonumber:  

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の差集合は，$R - S$で書く．その定義は次の通りである．

$$R - S = \{t \mid t \in R \text{ and } t \notin S\}$$

$R$と$S$の差集合は，$R$に属し，$S$に属さないタプル全体の集合である．
````

````{prf:example}
:nonumber:

- プログラミング(学籍番号, 氏名, 学科)
- データベース(学籍番号, 氏名, 学科)

`プログラミング`と`データベース`の差集合は，プログラミングの授業を受講するがデータベースの授業を受講していない学生を表すリレーションである．

````

### 共通集合演算



````{prf:definition}
:label: definition-intersection
:nonumber:

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の共通集合は，$R \cap S$で書く．その定義は次の通りである．

$$R \cap S = \{t \mid t \in R \text{ and } t \in S\}$$

$R$と$S$の共通集合は，$R$にも属し，$S$にも属するタプル全体の集合である．
````

````{prf:example}
:nonumber:

- プログラミング(学籍番号, 氏名, 学科)
- データベース(学籍番号, 氏名, 学科)

`プログラミング`と`データベース`の共通集合は，プログラミングの授業とデータベースの授業の両方を受講する学生を表すリレーションである．

````

### 直積演算

````{prf:definition}
:label: definition-cartesian-product
:nonumber:

$R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーションとするとき，$R$と$S$の直積は，$R \times S$で書く．その定義は次の通りである．

$$R \times S = \{(r, s) \mid r \in R \text{ and } s \in S\}$$

$R$と$S$の直積は，$R$のタプルと$S$のタプルの全ての組み合わせの集合である．

````

:::{note}
$R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーションとするとき，$R$と$S$の直積$R \times S$の属性名は$R.A_i$と$S.B_i$で表す．
:::

````{prf:example}
:nonumber:

**商品**（商品番号，商品名）

| 商品番号 | 商品名 |
| -------- | ------ |
| 1        | りんご |
| 2        | みかん |

**店舗**（店舗番号，店舗名）

| 店舗番号 | 店舗名 |
| -------- | ------ |
| A        | A店    |
| B        | B店    |

`商品`と`店舗`の直積は，商品と店舗の全ての組み合わせを表すリレーションである．

| 商品.商品番号 | 商品.商品名 | 店舗.店舗番号 | 店舗.店舗名 |
| ------------- | ----------- | ------------- | ----------- |
| 1             | りんご      | A             | A店         |
| 1             | りんご      | B             | B店         |
| 2             | みかん      | A             | A店         |
| 2             | みかん      | B             | B店         |

````

### 射影演算

````{prf:definition}
:label: definition-projection
:nonumber:

$R(A_1, A_2, \ldots, A_n)$をリレーション，$R$の全属性集合を$\{A_1, A_2, \ldots, A_n\}$の部分集合を$X=\{A_{i_1}, A_{i_2}, \ldots, A_{i_m}\}$，ここに$1 \leq i_1 < i_2 < \ldots < i_m \leq n$とする．$R$の$X$上の射影を$R[X]$で表す．その定義は次の通りである．

$$R[X] = \{t[X] \mid t \in R\}$$

ここに，$t=(a_1, a_2, \ldots, a_n) \in R$とするとき，$t[X]=(a_{i_1}, a_{i_2}, \ldots, a_{i_m})$である．
````

````{prf:example}
:nonumber:

**商品**（商品番号，商品名，価格）
| 商品番号 | 商品名 | 価格 |
| -------- | ------ | ---- |
| 1        | りんご | 100  |
| 2        | みかん | 80   |

`商品`の商品番号と商品名の射影は，商品番号と商品名のみを抽出したリレーションである．

| 商品番号 | 商品名 |
| -------- | ------ |
| 1        | りんご |
| 2        | みかん |

````

### 選択演算

````{prf:definition}
:label: definition-selection
:nonumber:

$R(A_1, A_2, \ldots, A_n)$をリレーション，$A_i$と$A_j$を$\theta$-比較可能な属性とする．ここに，$\theta$は比較演算子（$=, \neq, <, \leq, >, \geq$）である．$R$の$A_i$と$A_j$上の$\theta$-選択を$R\left[A_i \theta A_j\right]$で表す．その定義は次の通りである．

$$R\left[A_i \theta A_j\right]= \{t \mid t \in R \text{ and } t[A_i] \theta t[A_j]\}$$

ここに，$A_i$と$A_j$が$\theta$-比較可能とは，次の2つの条件を満たすことである．

1. $\text{dom}(A_i) = \text{dom}(A_j)$
2. $t[A_i] \theta t[A_j]$の真か偽が定義されている

$R(A_1, A_2, \ldots, A_n)$の属性$A_i$と$c$に関する$\theta$-選択を$R\left[A_i \theta c\right]$で表す．

$$R\left[A_i \theta c\right]= \{t \mid t \in R \text{ and } t[A_i] \theta c\}$$
````

````{prf:example}
:nonumber:

**商品**（商品番号，商品名，価格）
| 商品番号 | 商品名 | 価格 |
| -------- | ------ | ---- |
| 1        | りんご | 100  |
| 2        | みかん | 80   |

`商品`の価格が100円以上の商品を抽出するための選択演算は，次のようになる．

$$\text{商品}\left[\text{価格} \geq 100\right]$$

| 商品番号 | 商品名 | 価格 |
| -------- | ------ | ---- |
| 1        | りんご | 100  |

````

### 結合演算

````{prf:definition}
:label: definition-join
:nonumber:

$R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーション，$A_i$と$B_j$を$\theta$-比較可能とする．$R$と$S$の$A_i$と$B_j$上の$\theta$-結合を$R \left[A_i \theta B_j\right] S$で表す．その定義は次の通りである．

$$R \left[A_i \theta B_j\right] S = \left\{(r, s) \mid r \in R \text{ and } s \in S \text{ and } r[A_i] \theta s[B_j]\right\}$$

````

````{prf:example}
:nonumber:

**社員**（社員番号，社員名，部署）

| 社員番号 | 氏名 | 部署 |
| -------- | ---- | ---- |
| 1        | 田中 | E1   |
| 2        | 山田 | K2   |
| 3        | 佐藤 | E1   |

**部署**（部署番号，部署名）

| 部署番号 | 部署名 |
| -------- | ------ |
| E1       | 営業   |
| K4       | 開発   |

$\text{社員}\left[\text{部署} = \text{部署番号}\right] \text{部署}$の結果は，次のようになる．

| 社員.社員番号 | 社員.氏名 | 社員.部署 | 部署.部署番号 | 部署.部署名 |
| ------------- | --------- | --------- | ------------- | ----------- |
| 1             | 田中      | E1        | E1            | 営業        |
| 2             | 山田      | K2        | K2            | 開発        |
| 3             | 佐藤      | E1        | E1            | 営業        |

````

### 商演算

````{prf:definition}
:label: definition-division
:nonumber:

$R(A_1, A_2, \ldots, A_{n-m}, B_1, B_2, \ldots, B_m)$を$n$次，$S(B_1, B_2, \ldots, B_m)$を$m$次（$n \geq m$）のリレーションとする．$R$を$S$で割った商を$R \div S$で表す．その定義は次の通りである．

$$R \div S = \{t \mid t \in R(A_1, A_2, \ldots, A_{n-m}) \text{ and } \forall u \in S, (t, u) \in R\}$$

````

````{prf:example}
:nonumber:

学生 テーブル
| 学籍番号 | 氏名     |
| -------- | -------- |
| 202401   | 山田太郎 |
| 202402   | 田中花子 |
| 202403   | 佐藤次郎 |
| 202404   | 鈴木一郎 |

履修 テーブル
| 学籍番号 | 科目           |
| -------- | -------------- |
| 202401   | プログラミング |
| 202401   | データベース   |
| 202402   | データベース   |
| 202402   | ゲーム理論     |
| 202403   | プログラミング |
| 202403   | データベース   |

プログラミングとデータベースの両方を履修している学生を検索することを考える．このとき，科目テーブルを次のようになる．

科目
| 科目           |
| -------------- |
| プログラミング |
| データベース   |

このとき，履修 ÷ 科目 の結果は，次のようになる．

| 学籍番号 |
| -------- |
| 202401   |
| 202403   |

````

## リレーショナル代数表現

**実リレーション**（base relation）はデータベースに実際に格納されているリレーションである．リレーション演算から得られた結果もリレーションである．そのようなリレーションを**導出リレーション**（derived relation）と呼ぶ．

````{prf:definition}
:label: definition-relational-algebra-expression
:nonumber:

リレーショナル代数表現（Relational Algebra Expression）
1. リレーショナルデータベースの実リレーション$R$は表現である．
2. $R$と$S$を表現とするとき，$R$と$S$が和両立であるなら，$R \cup S$，$R - S$，$R \cap S$は表現である．
3. $R$と$S$を表現とするとき，$R \times S$は表現である．
4. $R$を表現とするとき，$R[X]$は表現である．
5. $R$を表現とするとき，$R\left[A_i \theta A_j\right]$，$R\left[A_i \theta c\right]$は表現である．
6. $R$と$S$を表現とするとき，$R \left[A_i \theta B_j\right] S$は表現である．
7. $R$と$S$を表現とするとき，$R \div S$は表現である．
8. 以上の定義によって得られた表現のみがリレーショナル代数表現である．

````

## 演習

リレーション学生（<u>学籍番号</u>，学生名，学部），内定（<u>学籍番号</u>，<u>法人番号</u>，職種），会社（<u>法人番号</u>，会社名，所在地）があるとする．

**問１** すべての学生の全データを求めよ．

学生

**問２** 理工学部の学生の全データを求めよ．

学生[学部 = '理工']

**問３** 内定先を決まっている学生の学籍番号を求めよ．

内定['学籍番号']

**問４** 内定先を決まっていない理工学部の学生の学籍番号を求めよ．

学生[学部 = '理工']['学籍番号'] - 内定['学籍番号']

**問５** 理工学部の学生の内定先の法人番号を求めよ．

((学生['学籍番号' = '学籍番号']内定)[学生.学部 = '理工'])[内定.法人番号]

**問６** 法人番号が'0001'の会社の内定を受けた学生の学籍番号と学生名を求めよ．

((学生['学籍番号' = '学籍番号']内定)[内定.法人番号 = '0001'])[学生.学籍番号, 学生.学生名]

## 練習問題

自由に設定したテーマに基づいてリレーショナルデータベースのスキーマを定義し、それを用いてすべての基本的なリレーショナル代数演算を含む例題を作成し、その解答を示しなさい。