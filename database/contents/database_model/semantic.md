# 意味記述

## 学習目標
- 意味記述とは何かを理解する。
- 主キー、候補キー、外部キーの違いを理解する。簡単なデータベースにおいて、それらを特定することができる。
- 検査制約、表明、トリガの概念を理解する。
- リレーショナルデータベーススキーマの構成要素を理解する。

## 候補キーと主キー

### 候補キー

リレーションの全属性集合の部分集合がそのリレーションのタプルの一意識別能力を持つ．このような性質を持つ極小組を**候補キー**（candidate key）という。

リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$に対して、属性集合$K \subseteq \{A_1, A_2, \ldots, A_n\}$が候補キーであるとは、次の2つの条件を満たすことである。

1. $K$が一意識別性を持つ。
2. $K$のどのような真部分集合$H \subset K$も一意識別性を持たない。

### 主キー

主キー（primary key）はタプルを一意識別するために使用される。候補キーが複数存在する場合、その中から一つを選び、主キーとする。どの候補キーを選ぶかはデータベース設計者の裁量による。

主キーは次の条件を満たさなければならない。

1. 主キーはタプルを一意識別能力を持つこと。
2. 主キーを構成する属性は空（NULL）をとらないこと。

この制約を**キー制約**（key constraint）という。

一般に、リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$の属性集合${A_{k1}, A_{k2}, \ldots, A_{km}}$が主キーであるとき、

$$\boldsymbol{R}(\dots, \underline{A_{k1}}, \dots, \underline{A_{k2}}, \ldots, \underline{A_{km}}, \dots)$$

と表記する。

:::{admonition} 例

- 社員（<u>社員番号</u>、社員名、部署番号）


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
\subtitle{Lecture 3: リレーショナルデータモデル（意味記述）}
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

\begin{frame}{学習目標}
    \begin{enumerate}
        \item 意味記述とは何かを理解する。
        \item 主キー、候補キー、外部キーの違いを理解する。簡単なデータベースにおいて、それらを特定することができる。
        \item 検査制約、表明、トリガの概念を理解する。
        \item リレーショナルデータベーススキーマの構成要素を理解する。
    \end{enumerate}
\end{frame}

\begin{frame}{意味記述}
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 学生（学生番号, 学生名, 入学年度, 学部）
            \item 成績（学生番号, 科目番号, 成績）
            \item 科目（科目番号, 科目名, 単位数, 担当教員）
        \end{itemize}
    \end{exampleblock}
    \vfill
    \begin{itemize}
        \item 成績は存在しない学生番号や科目番号を持つことはできない。
        \item 成績は100を超えることはできない。
        \item 科目の担当教員は大学の教員でなければならない。
        \item 在学年限を超える学生は存在しない。
        \item 学部は大学の学部でなければならない。
    \end{itemize}
\end{frame}

\begin{frame}{一貫性制約}
    \begin{block}{一貫性制約（integrity constraint）}
        データベースを実社会を正しく反映し、データベースの一貫性を保つための制約。
    \end{block}
    \vfill
    \begin{itemize}
        \item キー制約（key constraint）
        \item 外部キー制約（foreign key constraint）
        \item 検査制約（check constraint）
        \item 表明（assertion）
        \item トリガ（trigger）
    \end{itemize}
\end{frame}

\begin{frame}{目次}
    \tableofcontents
\end{frame}

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
        リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$に対して、属性集合$K \subseteq \{A_1, A_2, \ldots, A_n\}$が候補キーであるとは、次の2つの条件を満たすことである。
        \begin{enumerate}
            \item $K$が一意識別性を持つ。
            \item $K$のどのような真部分集合$H \subset K$も一意識別性を持たない。
        \end{enumerate}
    \end{block}
\end{frame}

\begin{frame}{主キー}
    \begin{itemize}
        \item 主キー（primary key）はタプルを一意識別するために使用される。
        \item 候補キーが複数存在する場合、その中から一つを選び、主キーとする。
        \item どの候補キーを選ぶかはデータベース設計者の裁量による。
    \end{itemize}
    \vfill
    \begin{block}{キー制約（key constraint）}
        主キーは次の条件を満たさなければならない。
        \begin{enumerate}
            \item 主キーはタプルを一意識別能力を持つこと。
            \item 主キーを構成する属性は空（NULL）をとらないこと。
        \end{enumerate}
    \end{block}
\end{frame}

\begin{frame}{主キー}
    一般に、リレーションスキーマ$\boldsymbol{R}(A_1, A_2, \ldots, A_n)$の属性集合${A_{k1}, A_{k2}, \ldots, A_{km}}$が主キーであるとき、
    
    $$\boldsymbol{R}(\dots, \underline{A_{k1}}, \dots, \underline{A_{k2}}, \ldots, \underline{A_{km}}, \dots)$$
    
    と表記する。

    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}、社員名、部署番号）
            \item 部署（\underline{部署番号}、部署名、所在地）
        \end{itemize}
    \end{exampleblock}
\end{frame}

\begin{frame}{問題}
    \begin{enumerate}
        \item 学生（学生番号、学生名、保険者番号）の候補キーと主キーは何か？
        \item 成績（学生番号、科目、成績）の候補キーと主キーは何か？
    \end{enumerate}
\end{frame}

\begin{frame}{解答}

    候補キー
    \begin{enumerate}
        \item 学生（学生番号、学生名、保険者番号）：\\$\{\text{学生番号}\}$、$\{\text{保険者番号}\}$
        \item 成績（学生番号、科目、成績）：\\$\{\text{学生番号, 科目}\}$
    \end{enumerate}

    \vfill
    主キー
    \begin{enumerate}
        \item 学生（\underline{学生番号}、学生名、保険者番号）
        \item 成績（\underline{学生番号}、\underline{科目}、成績）
    \end{enumerate}
      
\end{frame}

\section{外部キー}

\begin{frame}{外部キー}
    \begin{exampleblock}{社員（\underline{社員番号}、社員名、所属）}
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

    \begin{exampleblock}{部門（\underline{部門番号}、部門名、部門長）}
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
        $\boldsymbol{R}$と$\boldsymbol{S}$をリレーションスキーマとするとき、$\boldsymbol{R}$の属性集合$F$が$\boldsymbol{S}$の外部キーであるとは、$\boldsymbol{S}$の主キーを$K$とするとき、$\boldsymbol{R}$の任意のインスタンス$R$に対して、$\boldsymbol{S}$のインスタンス$S$が存在し、次が成り立つときである。

        $$\forall t \in R, \exists u \in S \text{ such that } t[F] = u[K] \text{ or } t[F] = \text{NULL}$$
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}、社員名、所属）
            \item 部門（\underline{部門番号}、部門名、部門長）
        \end{itemize}
    \end{exampleblock}
\end{frame}

\section{検査制約、表明、トリガ}

\begin{frame}{検査制約}
    \begin{block}{検査制約（check constraint）}
        リレーションの属性値が特定の条件を満たすことを保証する制約。
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        学生（\underline{学生番号}、学生名、年齢、性別）
    \end{exampleblock}
    \begin{itemize}
        \item 年齢は10歳以上でなければならない。
        \item 性別は"男性"、"女性"、"その他"のいずれかでなければならない。
        \item \dots
    \end{itemize}
\end{frame}

\begin{frame}{表明}
    \begin{block}{表明（assertion）}
        複数のリレーションにまたがる制約を表現するための制約。
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 社員（\underline{社員番号}、社員名、所属、給与）
            \item 部門（\underline{部門番号}、部門名、部門長、予算）
        \end{itemize}
    \end{exampleblock}
    \begin{itemize}
        \item 社員の給与は部門の予算を超えてはならない。
    \end{itemize}
\end{frame}

\begin{frame}{トリガ}
    \begin{block}{トリガ（trigger）}
        あるリレーションが変更されたときに、他のリレーションにも自動的に更新を行うための制約。
    \end{block}
    \vfill
    \begin{exampleblock}{例}
        \begin{itemize}
            \item 学生（\underline{学生番号}、学生名、所属）
            \item 学部（\underline{学部番号}、学部名、学部長、学生数）
        \end{itemize}
    \end{exampleblock}
    \begin{itemize}
        \item １名の新入生の挿入により、学部の学生数を自動的に１増やす。
    \end{itemize}
\end{frame}

\section{リレーショナルデータベーススキーマ}

\begin{frame}{リレーショナルデータベーススキーマ}
    \begin{block}{リレーショナルデータベーススキーマ\\（relational database schema）}
        データベースを定める時間的に不変な構造的・意味的記述体系。\\
        リレーショナルデータベースのスキーマは次に示すような要素から成り立つ。
        \begin{itemize}
            \item 構造記述：データベーススキーマ名、ドメイン定義、リレーションスキーマ定義
            \item 意味記述：主キー、外部キー、検査制約、表明定義、トリガ定義、権限定義
        \end{itemize}
    \end{block}
\end{frame}

\end{document} -->