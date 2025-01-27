# 操作記述

## リレーショナル代数

### 和両立

リレーション$R(A_1, A_2, \ldots, A_n)$とリレーション$S(B_1, B_2, \ldots, B_m)$が和両立（union compatible）とは，次の二つの条件を満たすことである．

1. $n = m$．
2. $\text{dom}(A_i) = \text{dom}(B_i)$であり，$1 \leq i \leq n$．

:::{admonition} Example

ある大学の学生データベースには，2024年度入学生のデータを格納するリレーション`学生2024`と，2025年度入学生のデータを格納するリレーション`学生2025`がある．

**学生2024**
| 学籍番号 | 氏名     | 学科       |
| -------- | -------- | ---------- |
| 202401   | 山田太郎 | 情報工学科 |
| 202402   | 田中花子 | 情報工学科 |
| ...      | ...      | ...        |

**学生2025**
| 学籍番号 | 氏名     | 学科       |
| -------- | -------- | ---------- |
| 202501   | 佐藤桃子 | 情報工学科 |
| 202502   | 鈴木一郎 | 情報工学科 |
| ...      | ...      | ...        |

`学生2024`と`学生2025`の次数は共に3であり，それぞれの属性の定義域は共通であるため，これらは和両立である．

:::

:::{admonition} Example

A社とB社の社員を表すリレーション`A社の社員`と`B社の社員`がある．A社の社員が事務部と営業部のどちらかに所属するのに対し，B社の社員が開発部と研究部のどちらかに所属するとする．

- A社の社員(社員番号, 氏名, 部署)
- B社の社員(社員番号, 氏名, 部署)

A社とB社の部署の定義域は異なるため，これらは和両立ではない．

:::

### 和集合演算

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の和集合は，$R \cup S$で書く．その定義は次の通りである．

$$R \cup S = \{t \mid t \in R \text{ or } t \in S\}$$

すなわち，$R$と$S$の和集合は，$R$または$S$に属するタプル全体の集合である．

:::{admonition} Example

ある大学は工学部と理学部を持っており，それぞれの学生を表すリレーション`工学部学生`と`理学部学生`がある．

- 工学部学生(学籍番号, 氏名, 学科)
- 理学部学生(学籍番号, 氏名, 学科)

`工学部学生`と`理学部学生`の和集合は，その大学の全学生を表すリレーションである．

:::

:::{admonition} Example

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

:::


### 差集合演算

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の差集合は，$R - S$で書く．その定義は次の通りである．

$$R - S = \{t \mid t \in R \text{ and } t \notin S\}$$

すなわち，$R$に属し，$S$に属さないタプル全体の集合である．

:::{admonition} Example
`プログラミング`と`データベース`の差集合は，プログラミングの授業を受講するがデータベースの授業を受講していない学生を表すリレーションである．
:::

### 共通集合演算

$R$と$S$を和両立なリレーションとするとき，$R$と$S$の共通集合は，$R \cap S$で書く．その定義は次の通りである．

$$R \cap S = \{t \mid t \in R \text{ and } t \in S\}$$


<!-- \documentclass{beamer}
\usepackage{booktabs}  % For clean table lines
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage{xeCJK}
\usefonttheme{professionalfonts}
\setCJKmainfont{Noto Serif CJK JP}
\setCJKsansfont{Noto Sans CJK JP}
\setCJKmonofont{Noto Sans Mono CJK JP}

% Set theme
\usetheme{Boadilla} 

% Set itemize and enumerate items
\setbeamertemplate{itemize items}[default]
\setbeamertemplate{enumerate items}[default]
\setbeamertemplate{sections/subsections in toc}[square]

\title{リレーショナルデータベース}
\subtitle{Lecture 4: リレーショナルデータモデル（操作記述）}
\author{劉 子昂}

\date{Compile: \today}

\AtBeginSection[]
{
  \begin{frame}
    \frametitle{目次}
    \tableofcontents[currentsection]
  \end{frame}
}

\begin{document}

\frame{\titlepage}

\begin{frame}{はじめに}
    \begin{itemize}
        \item データモデルは構造記述，意味記述，操作記述から構成される．
        \item リレーショナルデータベースのスキーマはデータベースを定める時間的に不変な構造的・意味的記述体系．
        \item 操作記述はデータベースに対する操作を記述する．
        \begin{itemize}
            \item 質問（query）：データベースから情報を取り出す操作．
            \item 更新（update）：データベースの内容を変更する操作．タプルの挿入，削除，修正．
        \end{itemize}
    \end{itemize}
\end{frame}

\begin{frame}{学習目標}
    \begin{enumerate}
        \item 
    \end{enumerate}
\end{frame}

\begin{frame}{目次}
    \tableofcontents
\end{frame}

\section{リレーショナル代数}

\begin{frame}{リレーショナル代数}
    \begin{block}{リレーショナル代数（relational algebra）}
        リレーショナルデータベースのためのデータ操作言語（data manipulation language，DML）．
    \end{block}
    \vfill
    リレーショナル代数は次に示す8個の演算からなる．
    \begin{itemize}
        \item 集合演算：和集合演算，差集合演算，共通集合演算，直積演算
        \item 関係演算：射影演算，選択演算，結合演算，商演算
    \end{itemize}
\end{frame}

\begin{frame}{リレーショナル代数と集合の代数学}

\end{frame}

\subsection{集合演算}

\begin{frame}{和両立}
    \begin{block}{和両立（union compatibility）}
        リレーション$R(A_1, A_2, \ldots, A_n)$とリレーション$S(B_1, B_2, \ldots, B_m)$が和両立とは，次の二つの条件を満たすことである．
        \begin{itemize}
            \item $n = m$（$R$と$S$の次数が等しい）．
            \item 各$i(1 \leq i \leq n)$に対して，$A_i$と$B_i$のドメインが等しい．
        \end{itemize}
    \end{block}
    \vfill
    \begin{exampleblock}{ある大学のテニス部と野球部の部員}
        \begin{itemize}
            \item テニス部（\underline{学生番号}，学生名，学部名）
            \item 野球部（\underline{学生番号}，学生名，学部名）
        \end{itemize}   
    \end{exampleblock}
\end{frame}

\begin{frame}{和集合演算}
    \begin{block}{和集合演算}
        $R$と$S$を和両立なリレーションとするとき，$R$と$S$の和集合は，$R \cup S$で表す．その定義は次の通りである．
        $$R \cup S = \{t \mid t \in R \text{ or } t \in S\}$$
    \end{block}
\end{frame}

\begin{frame}{差集合演算}
    \begin{block}{差集合演算}
        $R$と$S$を和両立なリレーションとするとき，$R$と$S$の差集合は，$R - S$で表す．その定義は次の通りである．
        $$R - S = \{t \mid t \in R \text{ and } t \notin S\}$$
    \end{block}
\end{frame}

\begin{frame}{共通集合演算}
    \begin{block}{共通集合演算}
        $R$と$S$を和両立なリレーションとするとき，$R$と$S$の共通集合は，$R \cap S$で表す．その定義は次の通りである．
        $$R \cap S = \{t \mid t \in R \text{ and } t \in S\}$$
    \end{block}
\end{frame}

\begin{frame}{直積演算}
    \begin{block}{直積演算}
        $R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーションとするとき，$R$と$S$の直積は，$R \times S$で表す．その定義は次の通りである．
        $$R \times S = \{(r, s) \mid r \in R \text{ and } s \in S\}$$
    \end{block}
\end{frame}

\begin{frame}{ドット記法}
    \begin{block}{ドット記法}
        $R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーションとするとき，$R$と$S$の直積$R \times S$の属性名は$R.A_i$と$S.B_i$で表す．
    \end{block}
\end{frame}

\subsection{４つの固有の演算}

\begin{frame}{射影演算}
    \begin{block}{射影演算}
        $R(A_1, A_2, \ldots, A_n)$をリレーション，$R$の全属性集合を$\{A_1, A_2, \ldots, A_n\}$の部分集合を$X=\{A_{i_1}, A_{i_2}, \ldots, A_{i_m}\}$，ここに$1 \leq i_1 < i_2 < \ldots < i_m \leq n$とする．$R$の$X$上の射影を$R[X]$で表す．その定義は次の通りである．
        $$R[X] = \{t[X] \mid t \in R\}$$
    \end{block}
    ここに，$t=(a_1, a_2, \ldots, a_n) \in R$とするとき，$t[X]=(a_{i_1}, a_{i_2}, \ldots, a_{i_m})$である．
\end{frame}

\begin{frame}{選択演算}
    \begin{block}{選択演算}
        $R(A_1, A_2, \ldots, A_n)$をリレーション，$A_i$と$A_j$を$\theta$-比較可能な属性とする．ここに，$\theta$は比較演算子（$=, \neq, <, \leq, >, \geq$）である．$R$の$A_i$と$A_j$上の$\theta$-選択を$R\left[A_i \theta A_j\right]$で表す．その定義は次の通りである．
        $$R\left[A_i \theta A_j\right]= \{t \mid t \in R \text{ and } t[A_i] \theta t[A_j]\}$$
    \end{block}
    ここに，$A_i$と$A_j$が$\theta$-比較可能とは，次の2つの条件を満たすことである．
    \begin{enumerate}
        \item $\text{dom}(A_i) = \text{dom}(A_j)$
        \item $t[A_i] \theta t[A_j]$の真か偽が定義されている
    \end{enumerate}
\end{frame}

\begin{frame}{結合演算}
    \begin{block}{結合演算}
        $R(A_1, A_2, \ldots, A_n)$と$S(B_1, B_2, \ldots, B_m)$をリレーション，$A_i$と$B_j$を$\theta$-比較可能とする．$R$と$S$の$A_i$と$B_j$上の$\theta$-結合を$R \left[A_i \theta B_j\right] S$で表す．その定義は次の通りである．
        $$R \left[A_i \theta B_j\right] S = \left\{(r, s) \mid r \in R \text{ and } s \in S \text{ and } r[A_i] \theta s[B_j]\right\}$$
    \end{block}
\end{frame}

\begin{frame}{商演算}
    \begin{block}{商演算}
        $R(A_1, A_2, \ldots, A_{n-m}, B_1, B_2, \ldots, B_m)$を$n$次，$S(B_1, B_2, \ldots, B_m)$を$m$次（$n \geq m$）のリレーションとする．$R$を$S$で割った商を$R \div S$で表す．その定義は次の通りである．
        $$R \div S = \{t \mid t \in R(A_1, A_2, \ldots, A_{n-m}) \text{ and } \forall u \in S, (t, u) \in R\}$$
    \end{block}
\end{frame}

\section{リレーショナル代数表現}


\section{候補キーと主キー}

\begin{frame}{例}
    \begin{exampleblock}{学生(学生番号, 学生名, 保険者番号)}
        \begin{table}
            \begin{tabular}{ccc}
                \toprule
                学生番号 & 学生名 & 保険者番号 \\
                \midrule
                9375 & 田中太郎 & 38625 \\
                9376 & 山田花子 & 78366 \\
                9377 & 田中太郎 & 58392 \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}
    \begin{exampleblock}{成績(学生番号, 科目, 成績)}
        \begin{table}
            \begin{tabular}{ccc}
                \toprule
                学生番号 & 科目 & 成績 \\
                \midrule
                9375 & 数学 & 90 \\
                9375 & 物理 & 85 \\
                9376 & 数学 & 80 \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}
\end{frame}

\begin{frame}{候補キー}
    リレーションの全属性集合の部分集合がそのリレーションのタプルの一意識別能力を持つ．このような性質を持つ極小組を候補キーという．
    \vfill
    \begin{block}{候補キー（candidate key）}
        リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$に対して，属性集合$K \subseteq \{A_1, A_2, \ldots, A_n\}$が候補キーであるとは，次の2つの条件を満たすことである．
        \begin{enumerate}
            \item $K$が一意識別性を持つ．
            \item $K$のどのような真部分集合$H \subset K$も一意識別性を持たない．
        \end{enumerate}
    \end{block}
\end{frame}

\begin{frame}{主キー}
    \begin{itemize}
        \item 主キー（primary key）はタプルを一意識別するために使用される．
        \item 候補キーが複数存在する場合，その中から一つを選び，主キーとする．
        \item どの候補キーを選ぶかはデータベース設計者の裁量による．
    \end{itemize}
    \vfill
    \begin{block}{キー制約（key constraint）}
        主キーは次の条件を満たさなければならない．
        \begin{enumerate}
            \item 主キーはタプルを一意識別能力を持つこと．
            \item 主キーを構成する属性は空（NULL）をとらないこと．
        \end{enumerate}
    \end{block}
\end{frame}

\begin{frame}{主キー}
    一般に，リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$の属性集合${A_{k1}, A_{k2}, \ldots, A_{km}}$が主キーであるとき，
    
    $$\boldsymbol{R}(\dots, \underline{A_{k1}}, \dots, \underline{A_{k2}}, \ldots, \underline{A_{km}}, \dots)$$
    
    と表記する．

    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}，社員名，部署番号）
            \item 部署（\underline{部署番号}，部署名，所在地）
        \end{itemize}
    \end{exampleblock}
\end{frame}

\begin{frame}{問題}
    \begin{enumerate}
        \item 学生（学生番号，学生名，保険者番号）の候補キーと主キーは何か？
        \item 成績（学生番号，科目，成績）の候補キーと主キーは何か？
    \end{enumerate}
\end{frame}

\begin{frame}{解答}

    候補キー
    \begin{enumerate}
        \item 学生（学生番号，学生名，保険者番号）：\\$\{\text{学生番号}\}$，$\{\text{保険者番号}\}$
        \item 成績（学生番号，科目，成績）：\\$\{\text{学生番号, 科目}\}$
    \end{enumerate}

    \vfill
    主キー
    \begin{enumerate}
        \item 学生（\underline{学生番号}，学生名，保険者番号）
        \item 成績（\underline{学生番号}，\underline{科目}，成績）
    \end{enumerate}
      
\end{frame}

\section{外部キー}

\begin{frame}{外部キー}
    \begin{exampleblock}{社員（\underline{社員番号}，社員名，所属）}
        \begin{table}
            \begin{tabular}{ccc}
                \toprule
                社員番号 & 社員名 & 所属 \\
                \midrule
                9375 & 田中太郎 & 1 \\
                9376 & 山田花子 & 2 \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}

    \begin{exampleblock}{部門（\underline{部門番号}，部門名，部門長）}
        \begin{table}
            \begin{tabular}{ccc}
                \toprule
                部門番号 & 部門名 & 部門長 \\
                \midrule
                1 & データベース部 & 9375 \\
                2 & システム部 & 9376 \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}
\end{frame}

\begin{frame}{外部キー}
    \begin{block}{外部キー（foreign key）}
        $\boldsymbol{R}$と$\boldsymbol{S}$をリレーションスキーマとするとき，$\boldsymbol{R}$の属性集合$F$が$\boldsymbol{S}$の外部キーであるとは，$\boldsymbol{S}$の主キーを$K$とするとき，$\boldsymbol{R}$の任意のインスタンス$R$に対して，$\boldsymbol{S}$のインスタンス$S$が存在し，次が成り立つときである．

        $$\forall t \in R, \exists u \in S \text{ such that } t[F] = u[K] \text{ or } t[F] = \text{NULL}$$
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}，社員名，所属）
            \item 部門（\underline{部門番号}，部門名，部門長）
        \end{itemize}
    \end{exampleblock}
\end{frame}

\section{検査制約，表明，トリガ}

\begin{frame}{検査制約}
    \begin{block}{検査制約（check constraint）}
        リレーションの属性値が特定の条件を満たすことを保証する制約．
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        学生（\underline{学生番号}，学生名，年齢，性別）
    \end{exampleblock}
    \begin{itemize}
        \item 年齢は10歳以上でなければならない．
        \item 性別は"男性"，"女性"，"その他"のいずれかでなければならない．
        \item \dots
    \end{itemize}
\end{frame}

\begin{frame}{表明}
    \begin{block}{表明（assertion）}
        複数のリレーションにまたがる制約を表現するための制約．
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}，社員名，所属，給与）
            \item 部門（\underline{部門番号}，部門名，部門長，予算）
        \end{itemize}
    \end{exampleblock}
    \begin{itemize}
        \item 社員の給与は部門の予算を超えてはならない．
    \end{itemize}
\end{frame}

\begin{frame}{トリガ}
    \begin{block}{トリガ（trigger）}
        あるリレーションが変更されたときに，他のリレーションにも自動的に更新を行うための制約．
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 学生（\underline{学生番号}，学生名，所属）
            \item 学部（\underline{学部番号}，学部名，学部長，学生数）
        \end{itemize}
    \end{exampleblock}
    \begin{itemize}
        \item １名の新入生の挿入により，学部の学生数を自動的に１増やす．
    \end{itemize}
\end{frame}

\section{リレーショナルデータベーススキーマ}

\begin{frame}{リレーショナルデータベーススキーマ}
    \begin{block}{リレーショナルデータベーススキーマ\\（relational database schema）}
        データベースを定める時間的に不変な構造的・意味的記述体系．\\
        リレーショナルデータベースのスキーマは次に示すような要素から成り立つ．
        \begin{itemize}
            \item 構造記述：データベーススキーマ名，ドメイン定義，リレーションスキーマ定義
            \item 意味記述：主キー，外部キー，検査制約，表明定義，トリガ定義，権限定義
        \end{itemize}
    \end{block}
\end{frame}

\end{document} -->