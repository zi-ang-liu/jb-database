# 構造記述

```{epigraph}
千里之行，始于足下．

-- 老子
```

## 学習目標

- リレーションの概念を理解する．
- 直積，濃度，次数の概念を理解し，計算できる．
- リレーションスキーマとインスタンスの違いを理解する．
- 第1正規形の概念を理解し，非第1正規形リレーションを正規化できる．

## データモデルの要素

- 構造記述：データベースの構成要素の記述
- 意味記述：データベースの一貫性制約の記述
- 操作記述：データベース操作言語

> A data model is a combination of at least three components:
> 1. A collection of data structure types (the database building, blocks);
> 2. A collection of operators or rules of inference, which can be applied to any valid instances of the data types listed in (1), to retrieve, derive, or modify data from any parts of those structures in any combinations desired;
> 3. A collection of general integrity rules, which implicitly or explicitly define the set of consistent database states or changes of state or both--these rules are general in the sense that they apply to any database using this model (incidentally, they may sometimes be expressed as insert-update-delete rules).   
> 
> E. F. Codd. 1982. Relational database: a practical foundation for productivity. Commun. ACM 25, 2 (Feb 1982), 109–117. https://doi.org/10.1145/358396.358400

## リレーションとは

### ドメイン

````{prf:definition}
:label: definition-domain
:nonumber:

**ドメイン**（domain，定義域）は属性の取り得る値の集合である．一般に$D$で表す．
````

````{prf:example}
:label: example-domain
:nonumber:

- 年齢：$D_1 = \{0, 1, 2, \ldots, 120\}$．
- 性別：$D_2 = \{\text{"M"}, \text{"F"}, \text{"NULL"}\}$．
- 人名：$D_3 = \{x \mid x \text{ は人名}\}$．
````

### 直積
````{prf:definition}
:label: definition-cartesian-product
:nonumber:

**直積**（Cartesian product）は集合$A$と$B$の直積であり，$A \times B = \{(a, b) \mid a \in A, b \in B\}$である．直積の要素は**タプル**（tuple，組）と呼ばれる．
````

````{prf:example}
:nonumber:

$A = \{1, 2, 3\}$, $B = \{3, 4\}$のとき，$A$と$B$の直積は次のようになる．

$$A \times B = \{(1, 3), (1, 4), (2, 3), (2, 4), (3, 3), (3, 4)\}$$
````

### リレーション

````{prf:definition}
:nonumber:

**リレーション**（relation）は$D_1, D_2, \ldots, D_n$をドメインとするとき，$D_1, D_2, \ldots, D_n$上のリレーション$R$とは$D_1 \times D_2 \times \ldots \times D_n$の任意の有限部分集合として定義する．
````

````{prf:example}
:nonumber:
$D_1 = \{1, 2, 3\}$, $D_2 = \{a, b\}$のとき，リレーション$R$の例は次のようになる．

$$R = \{(1, a), (2, b), (3, a)\}$$
````

````{prf:example}
:nonumber:

$D_1 = \{\text{"Tom"}, \text{"Mary"}\}$, $D_2 = \{1, 2, \ldots, 120\}$のとき，リレーション$R$の例は次のようになる．

$$R = \{(\text{"Tom"}, 20), (\text{"Mary"}, 30), (\text{"Tom"}, 40)\}$$
````

### 濃度と次数

````{prf:definition}
:nonumber:

**濃度**（cardinality）はリレーションのタプルの数をリレーションの濃度という．**次数**（degree）はリレーションが定義されるドメインの数をリレーションの次数という．
````

````{prf:example}
:nonumber:

$R = \{(1, a), (2, b), (3, a)\}$の濃度は3，次数は2である．
````

### テーブルとリレーション

リレーションを**テーブル**（table）として表すことができる．テーブルの行はリレーションのタプルであり，テーブルの列はリレーションのドメインに対応する．

````{prf:example}
:nonumber:

ドメイン$D_1 = \{\text{"Tom"}, \text{"Mary"}\}$, $D_2 = \{0, 1, 2, \ldots\}$のリレーション$R\{(\text{"Tom"}, 25), (\text{"Mary"}, 30)\}$をテーブルで表すと次のようになる．

|      |     |
| ---- | --- |
| Tom  | 25  |
| Mary | 30  |

- $D_2$を年齢のドメインとするとき，TomとMaryの年齢はそれぞれ25歳と30歳である．
````

## リレーションスキーマとインスタンス

**属性名**（attribute name）はテーブルの列の名前であり，**リレーション名**（relation name）はテーブルの名前である．

````{prf:definition}
:nonumber:
$A_i$を属性名，$D_i$をドメイン，$i=1, 2, \ldots, n$とするとき，$\text{dom}: A_i \to D_i$を**ドメイン関数**（domain function）という．
````

````{prf:example}
:nonumber:
$D_1=\{x \mid x \text{は人名}\}$, $D_2=\{0, 1, 2, \ldots\}$のリレーション$R\{(\text{"Tom"}, 25), (\text{"Mary"}, 30)\}$を考える．

リレーション名は社員であり，属性名は名前と年齢である．テーブルで表すと次のようになる．

| 名前 | 年齢 |
| ---- | ---- |
| Tom  | 25   |
| Mary | 30   |

年齢と名前のドメイン関数はそれぞれ次のようになる．

$$\text{dom}(\text{名前}) = D_1 = \{x \mid x \text{は人名}\}$$
$$\text{dom}(\text{年齢}) = D_2 = \{0, 1, 2, \ldots\}$$

````

### ドメイン関数を用いたリレーションの定義

````{prf:definition}
:nonumber:
リレーション$R$は$\text{dom}(A_1) \times \text{dom}(A_2) \times \ldots \times \text{dom}(A_n)$の有限部分集合である．
````

### リレーションスキーマとインスタンス

````{prf:definition}
:nonumber:

$\boldsymbol{R}$をリレーション名，$A_1, A_2, \ldots, A_n$を属性名，$\text{dom}$をドメイン関数とするとき，**リレーションスキーマ**（relation schema）は$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$で表す．このとき，$R \subseteq \text{dom}(A_1) \times \text{dom}(A_2) \times \ldots \times \text{dom}(A_n)$を$\boldsymbol{R}$の**インスタンス**（instance）という．
````

:::{note}
- リレーションスキーマはリレーションの構造を記述する．時間的に変化しない．
- インスタンスはリレーションの具体的な値を記述する．時間的に変化する．
:::

## 第1正規形

````{prf:definition}
:label: definition-1NF
:nonumber:
リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$が**第1正規形**（1NF, first normal form）であるとは，任意のドメインが**シンプル**であることをいう．

シンプルはドメインの元が**原子的**（atomic），即ち**分解不可能**（nondecomposable）な値であることを指す．
````

### 非第1正規形

ドメインを複数のドメインの直積として定義する入れ子型リレーションは非第1正規形である．   

````{prf:example}
:nonumber:

$\text{dom}(\text{学生名}) = \text{dom}(\text{姓}) \times \text{dom}(\text{名})$のとき，次のリレーションは非第1正規形である．

| 学生番号 | 学生名       | ... |
| -------- | ------------ | --- |
| 9375     | (田中, 太郎) | ... |
| 9376     | (山田, 花子) | ... |
| ...      | ...          | ... |

この非第1正規形リレーションを正規化すると次のようになる．

| 学生番号 | 姓   | 名   | ... |
| -------- | ---- | ---- | --- |
| 9375     | 田中 | 太郎 | ... |
| 9376     | 山田 | 花子 | ... |
| ...      | ...  | ...  | ... |
````

べき集合（power set）として定義されるドメインも非第1正規形である．

````{prf:example}
:nonumber:

$\text{dom}(\text{科目}) = \mathcal{P}(\text{dom}(\text{科目名}))$のとき，次のリレーションは非第1正規形である．

| 学生番号 | 科目                   |
| -------- | ---------------------- |
| 9375     | $\{数学, 物理, 化学\}$ |
| 9376     | $\{英語, 数学\}$       |
| ...      | ...                    |

この非第1正規形リレーションを正規化すると次のようになる．

| 学生番号 | 科目 |
| -------- | ---- |
| 9375     | 数学 |
| 9375     | 物理 |
| 9375     | 化学 |
| 9376     | 英語 |
| 9376     | 数学 |
| ...      | ...  |
````

## 練習問題

### 問題1：非第1正規形からの正規化

以下のようなリレーションがある：

| 注文ID | 顧客名 | 商品一覧                   |
| ------ | ------ | -------------------------- |
| 1001   | 佐藤   | {りんご, バナナ, オレンジ} |
| 1002   | 鈴木   | {バナナ, パイナップル}     |

1. 上記リレーションが **非第1正規形** である理由を説明せよ。
2. このリレーションを **第1正規形** に正規化せよ。
3. 正規化後のリレーションに対し、リレーションスキーマを明記し、そのインスタンスをテーブル形式で記述せよ。

---

### 問題2：リレーションスキーマとインスタンス

リレーションスキーマ $\boldsymbol{R}(A_1, A_2, A_3, A_4)$ について、各属性は以下のように定義される。

- $A_1$：学籍番号
- $A_2$：氏名
- $A_3$：年齢
- $A_4$：所属（学部名）

以下の問いに答えよ。

1. $\boldsymbol{R}$ の具体的なインスタンスを **3件分**、テーブル形式で作成せよ。
2. そのインスタンスをリレーション $R$ として **集合表記** で表せ。
3. $R$ の **濃度** と **次数** を求めよ。
4. $\text{dom}(A_4)$（所属）の **ドメイン** を定義せよ。