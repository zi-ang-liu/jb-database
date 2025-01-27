# 構造記述

## 学習目標

- リレーションの概念を理解する。
- 直積、濃度、次数の概念を理解し、計算できる。
- リレーションスキーマとインスタンスの違いを理解する。
- 第1正規形の概念を理解し、非第1正規形リレーションを正規化できる。

## リレーション

### ドメイン
**ドメイン**（domain、定義域）は属性の取り得る値の集合である。一般に$D$で表す。

:::{admonition} 例
- 年齢：$D_1 = \{0, 1, 2, \ldots, 120\}$。
- 性別：$D_2 = \{\text{"M"}, \text{"F"}, \text{"NULL"}\}$。
- 人名：$D_3 = \{x \mid x \text{ は人名}\}$。
:::

**直積**（Cartesian product）は集合$A$と$B$の直積であり、$A \times B = \{(a, b) \mid a \in A, b \in B\}$である。直積の要素は**タプル**（tuple、組）と呼ばれる。

:::{admonition} 例

$A = \{1, 2, 3\}$, $B = \{3, 4\}$のとき、$A$と$B$の直積は次のようになる。

$$A \times B = \{(1, 3), (1, 4), (2, 3), (2, 4), (3, 3), (3, 4)\}$$
:::

### リレーションの定義

**リレーション**（relation）は$D_1, D_2, \ldots, D_n$をドメインとするとき、$D_1, D_2, \ldots, D_n$上のリレーション$R$とは$D_1 \times D_2 \times \ldots \times D_n$の任意の有限部分集合として定義する。

:::{admonition} 例

$D_1 = \{1, 2, 3\}$, $D_2 = \{a, b\}$のとき、リレーション$R$の例は次のようになる。

$$R = \{(1, a), (2, b), (3, a)\}$$

:::

:::{admonition} 例

$D_1 = \{"Tom", "Mary"\}$, $D_2 = \{1, 2, \ldots, 120\}$のとき、リレーション$R$の例は次のようになる。

$$R = \{("Tom", 20), ("Mary", 30), ("Tom", 40)\}$$
:::

#### 濃度と次数

**濃度**（cardinality）はリレーションのタプルの数をリレーションの濃度という。**次数**（degree）はリレーションが定義されるドメインの数をリレーションの次数という。

:::{admonition} 例

$R = \{(1, a), (2, b), (3, a)\}$の濃度は3、次数は2である。
:::

### テーブル



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
\subtitle{Lecture 2: リレーショナルデータモデル（構造記述）}
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

\begin{frame}{予備知識}
    \begin{itemize}
        \item 集合（set）
        \item 直積（Cartesian product）
        \item 冪集合（power set）
    \end{itemize}
\end{frame}

\begin{frame}{学習目標}
    \begin{enumerate}
        \item リレーションの概念を理解する。
        \item 直積、濃度、次数の概念を理解し、計算できる。
        \item リレーションスキーマとインスタンスの違いを理解する。
        \item 第1正規形の概念を理解し、非第1正規形リレーションを正規化できる。
    \end{enumerate}
\end{frame}

\begin{frame}{目次}
    \tableofcontents
\end{frame}

\section{リレーション}

\begin{frame}{ドメイン}
    \begin{block}{ドメイン（domain、定義域）}
        属性の取り得る値の集合。一般に$D$で表す。
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{description}
            \item[年齢] $\{0, 1, 2, \ldots, 120\}$
            \item[性別] $\{\text{"M"}, \text{"F"}, \text{NULL}\}$
            \item[人名] $\{x \mid x \text{ は人名}\}$
        \end{description}
    \end{exampleblock}
\end{frame}

\begin{frame}{直積}
    \begin{block}{直積（Cartesian product）}
        集合$A$と$B$の直積は、$A \times B = \{(a, b) \mid a \in A, b \in B\}$である。直積の要素はタップル（tuple、組）と呼ばれる。
    \end{block}
    \vfill
    \begin{exampleblock}{$A = \{1, 2, 3\}$, $B = \{3, 4\}$}
        $A \times B = \{(1, 3), (1, 4), (2, 3), (2, 4), (3, 3), (3, 4)\}$
    \end{exampleblock}
    \begin{exampleblock}{$A = \{1, 2\}$, $B = \{a, b, c\}, C = \{3, 4\}$}
        $A \times B \times C = \{(1, a, 3), (1, a, 4), (1, b, 3), (1, b, 4), (1, c, 3), \ldots\}$
    \end{exampleblock}
\end{frame}

\begin{frame}{リレーション}
    \begin{block}{リレーション（relation）}
        $D_1, D_2, \ldots, D_n$をドメインとするとき、$D_1, D_2, \ldots, D_n$上のリレーション$R$とは$D_1 \times D_2 \times \ldots \times D_n$の任意の有限部分集合として定義する。
    \end{block}
    \vfill
    \begin{exampleblock}{$D_1 = \{1, 2, 3\}$, $D_2 = \{a, b\}$}
        $R = \{(1, a), (2, b), (3, a)\}$
    \end{exampleblock}
    \begin{exampleblock}{$D_1 = \{"Tom", "Mary"\}$, $D_2 = \{1, 2, \ldots, 120\}$}
        $R = \{("Tom", 20), ("Mary", 30), ("Tom", 40)\}$
    \end{exampleblock}
\end{frame}

\begin{frame}{リレーション：濃度と次数}
    \begin{block}{濃度（cardinality）}
        リレーションのタップルの数をリレーションの濃度という。
    \end{block}
    \begin{block}{次数（degree）}
        リレーションが定義されるドメインの数をリレーションの次数という。
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        $R = \{(1, a), (2, b), (3, a)\}$の濃度は3、次数は2である。
    \end{exampleblock}
\end{frame}

\begin{frame}{テーブル}
    リレーションを\textbf{テーブル}（table）として表すことができる。
    \begin{itemize}
        \item テーブルの行はリレーションのタップルに対応する。\\順序はない（集合の定義を思い出そう）。
        \item テーブルの列はリレーションのドメインに対応する。
    \end{itemize}
    \vfill
    \begin{exampleblock}{$D_1 = \{"Tom", "Mary"\}$, $D_2 = \{0, 1, 2, \ldots\}$}
        $R = \{("Tom", 25), ("Mary", 30)\}$
    \end{exampleblock}
    \begin{table}
        \begin{tabular}{cc}
            \toprule
            Tom & 25 \\
            Mary & 30 \\
            \bottomrule
        \end{tabular}
    \end{table}
    TomとMaryの年齢？給与？
\end{frame}

\section{リレーションスキーマとインスタンス}

\begin{frame}{属性名とリレーション名}
    \textbf{属性名}（attribute name）：テーブルの列の名前。

    \textbf{リレーション名}（relation name）：テーブルの名前。
    \vfill
    \begin{exampleblock}{$D_1=\{x \mid x \text{は人名}\}$, $D_2=\{0, 1, 2, \ldots\}$}
        \begin{description}
            \item[リレーション名] EMPLOYEE
            \item[属性名] NAME, AGE
        \end{description}
        \begin{table}
            \begin{tabular}{cc}
                \toprule
                NAME & AGE \\
                \midrule
                Tom & 25 \\
                Mary & 30 \\
                \bottomrule
            \end{tabular}
            \caption{EMPLOYEE}
        \end{table}
    \end{exampleblock}
\end{frame}

\begin{frame}{リレーションの定義}
    \begin{block}{ドメイン関数（domain function）}
        $A_i$を属性名、$D_i$をドメイン、$i=1, 2, \ldots, n$とすると、$\text{dom}: A_i \to D_i$をドメイン関数という。
    \end{block}
    % \begin{exampleblock}{$A_1$を名前、$A_2$を年齢、$D_1$を$\{x \mid x \text{は人名}\}$、$D_2$を$\{0, 1, 2, \ldots\}$}
    %     $\text{dom}(A_1) = D_1$, $\text{dom}(A_2) = D_2$
    % \end{exampleblock}
    \vfill
    \begin{block}{リレーション}
        リレーション$R$は$\text{dom}(A_1) \times \text{dom}(A_2) \times \ldots \times \text{dom}(A_n)$の有限部分集合である。
    \end{block} 
\end{frame}

\begin{frame}{リレーションスキーマとインスタンス}
    \begin{block}{リレーションスキーマ（relation schema）}
        $\boldsymbol{R}$をリレーション名、$A_1, A_2, \ldots, A_n$を属性名、$\text{dom}$をドメイン関数とするとき、リレーションスキーマは$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$である。
    \end{block}
    \begin{block}{インスタンス（instance）}
        $R \subseteq \text{dom}(A_1) \times \text{dom}(A_2) \times \ldots \times \text{dom}(A_n)$を$\boldsymbol{R}$のインスタンスという。
    \end{block}
    \vfill
    \begin{itemize}
        \item リレーションスキーマはリレーションの構造を記述する。
        \item インスタンスはリレーションの具体的な値を記述する。
    \end{itemize}
\end{frame} 

\section{第1正規形}

\begin{frame}{第1正規形の定義}
    \begin{block}{第1正規形（1NF, first normal form）}
        リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$が第1正規形であるとは、任意のドメインがシンプル\footnote{シンプル：ドメインの元が原子的（atomic）、即ち分解不可能（nondecomposable）な値であること。}であることをいう。
    \end{block}
\end{frame}

\begin{frame}{非第1正規形}
    入れ子型リレーション：ドメインを複数のドメインの直積として定義する。
    \begin{exampleblock}{$\text{dom}(\text{学生名}) = \text{dom}(\text{姓}) \times \text{dom}(\text{名})$}
        \begin{table}
            \begin{tabular}{ccc}
                \toprule
                学生番号 & 学生名 & \dots \\
                \midrule
                9375 & (田中, 太郎) & \dots \\
                9376 & (山田, 花子) & \dots \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}
\end{frame}

\begin{frame}{非第1正規形}

    冪集合（power set）として定義されるドメイン。
    \begin{exampleblock}{$\text{dom}(\text{科目}) = \mathcal{P}(\text{dom}(\text{科目名}))$}
        \begin{table}
            \begin{tabular}{cc}
                \toprule
                学生番号 & 科目 \\
                \midrule
                9375 & \{数学, 物理, 化学\} \\
                9376 & \{英語, 数学\} \\
                \bottomrule
            \end{tabular}
        \end{table}
    \end{exampleblock}

    \vfill
    $A$を集合とするとき、$A$の冪集合$\mathcal{P}(A)$は$A$の部分集合全体の集合である。\\
    If $A = \{a, b\}$, then $\mathcal{P}(A) = \{\emptyset, \{a\}, \{b\}, \{a, b\}\}$.

\end{frame}

\begin{frame}{非第1正規形リレーションの正規化}
    \begin{table}
        \begin{tabular}{ccc}
            \toprule
            学生番号 & 学生名 & \dots \\
            \midrule
            9375 & (田中, 太郎) & \dots \\
            9376 & (山田, 花子) & \dots \\
            \bottomrule
        \end{tabular}
    \end{table}
    \vfill

    \begin{table}
        \begin{tabular}{cccc}
            \toprule
            学生番号 & 姓 & 名 & \dots \\
            \midrule
            9375 & 田中 & 太郎 & \dots \\
            9376 & 山田 & 花子 & \dots \\
            \bottomrule
        \end{tabular}
    \end{table}
\end{frame}

\begin{frame}{非第1正規形リレーションの正規化}
    \begin{table}
        \begin{tabular}{cc}
            \toprule
            学生番号 & 科目 \\
            \midrule
            9375 & \{数学, 物理, 化学\} \\
            9376 & \{英語, 数学\} \\
            \bottomrule
        \end{tabular}
    \end{table}

    \vfill

    \begin{table}
        \begin{tabular}{cc}
            \toprule
            学生番号 & 科目 \\
            \midrule
            9375 & 数学 \\
            9375 & 物理 \\
            9375 & 化学 \\
            9376 & 英語 \\
            9376 & 数学 \\
            \bottomrule
        \end{tabular}
    \end{table}
\end{frame}

\end{document} -->