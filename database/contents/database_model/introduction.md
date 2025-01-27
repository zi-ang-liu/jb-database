# データベースとは

## 学習目標

- データと情報の違いを理解する。
- データベースシステムの構成を理解する。
- データモデルの概念を理解する。
- リレーショナルデータベースの特徴を理解する。
- DBMSの主な機能を理解する。
- SQL, NoSQL, DBMS, RDBMSなどの略語を使える。

## 略語

| 略語  | English                               | 日本語                                 |
| ----- | ------------------------------------- | -------------------------------------- |
| DBMS  | Database Management System            | データベース管理システム               |
| RDBMS | Relational Database Management System | リレーショナルデータベース管理システム |
| SQL   | Structured Query Language             |                                        |
| NoSQL | Not Only SQL                          |                                        |
| DDL   | Data Definition Language              | データ定義言語                         |
| DML   | Data Manipulation Language            | データ操作言語                         |
| DCL   | Data Control Language                 | データ制御言語                         |

## データと情報

**データ（Data）** はコンピューターの処理の対象となる事実。状態・条件などを表す数値・文字・記号。

**情報（Information）** はある特定の目的について，適切な判断を下したり，行動の意思決定をするために役立つ資料や知識。

:::{tip} 例1
- データ：(太郎, M, 20)
- 情報：太郎は20歳の男性です。
:::

:::{tip} 例2
- データ：700-8530
- 情報：訪問先は岡山大学です。
:::

### データと情報の違い

- データは数値・文字・記号などで表現したもの。
- 情報はデータが処理され、意味を持たせたもの。
- 情報は**意思決定**に役立つ。

## データベースシステム

**データベース（Database）** はデータの組織的な集合である。

**データベース管理システム（DBMS）** はデータベースを管理し、データに対する操作を提供するソフトウェア。

**データベースシステム（DBS）** はデータベース、DBMS、アプリケーションプログラムの総称。


<!-- \documentclass{beamer}
\usepackage{booktabs}  % For clean table lines
\usepackage{colortbl}
\usepackage{xcolor}
\usepackage{xeCJK}
\usefonttheme{professionalfonts}
\setCJKmainfont{Noto Serif CJK JP}
\setCJKsansfont{Noto Sans CJK JP}
\setCJKmonofont{Noto Sans Mono CJK JP}

% Set themeda
\usetheme{Boadilla} 

% Set itemize and enumerate items
\setbeamertemplate{itemize items}[default]
\setbeamertemplate{enumerate items}[default]
\setbeamertemplate{sections/subsections in toc}[square]

\title{リレーショナルデータベース}
\subtitle{Lecture 1: データベースとは}
\author{劉 子昂}
% \institute[〇〇大学]{〇〇大学〇〇学部〇〇学科}
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
        \item データと情報の違いを理解する。
        \item データベースシステムの構成を理解する。
        \item データモデルの概念を理解する。
        \item リレーショナルデータベースの特徴を理解する。
        \item DBMSの主な機能を理解する。
        \item SQL, NoSQL, DBMS, RDBMSなどの略語を使える。
    \end{enumerate}
\end{frame}

\begin{frame}{目次}
    \tableofcontents
\end{frame}

\section{データベースシステム}

\begin{frame}{データと情報}
    \begin{block}{データ（Data）}
        コンピューターの処理の対象となる事実。状態・条件などを表す数値・文字・記号。
    \end{block}
    \begin{block}{情報（Information）}
        ある特定の目的について，適切な判断を下したり，行動の意思決定をするために役立つ資料や知識。
    \end{block}
    \vspace{1em}
\end{frame}

\begin{frame}{データと情報の違い}
    \begin{exampleblock}{例1}
        \begin{description}
            \item[データ] (太郎, M, 20)
            \item[情報] 太郎は20歳の男性です。
        \end{description}
    \end{exampleblock}
    \begin{exampleblock}{例2}
        \begin{description}
            \item[データ] 700-8530
            \item[情報] 訪問先は岡山大学です。
        \end{description}
    \end{exampleblock}
    \vspace{1em}
    \begin{itemize}
        \item \textbf{データ}は数値・文字・記号などで表現したもの。
        \item \textbf{情報}はデータが処理され、意味を持たせたもの。
        \item 情報は\textbf{意思決定}に役立つ。
    \end{itemize}
\end{frame}

\begin{frame}{データベースシステム}
    \begin{block}{データベース（Database）}
        データの組織的な集合である。
    \end{block}
    \vspace{1em}
    \begin{block}{データベース管理システム（DBMS）}
        データベースを管理し、データに対する操作を提供するソフトウェア。
    \end{block}
    \vspace{1em}
    \begin{block}{データベースシステム（DBS）}
        データベース、DBMS、アプリケーションプログラムの総称。
    \end{block}
\end{frame}

\begin{frame}{データベースシステムの構成}
    \begin{figure}
        \centering
        \includegraphics[width=0.25\textwidth]{figures/dbs.pdf}
        \caption{データベースシステムの構成}
    \end{figure}
\end{frame}

\section{データモデル}

\begin{frame}{データモデル}
    \begin{block}{データモデル（data model）}
        コンピューターで，データベースシステムのデータを構造化するパターン。
    \end{block}

    \vspace{1em}

    \textbf{代表的なデータモデル}
    \begin{itemize}
        \item 階層データモデル
        \item ネットワークデータモデル
        \item \underline{リレーショナルデータモデル}
        \item オブジェクト指向データモデル
        \item XMLデータモデル
    \end{itemize}
\end{frame}

\begin{frame}{データモデルの要素}
    \begin{itemize}
        \item 構造記述：データベースの構成要素の記述
        \item 意味記述：データベースの一貫性制約の記述
        \item 操作記述：データベース操作言語
    \end{itemize}
\end{frame}

\begin{frame}{リレーショナルモデル}
    \begin{block}{リレーショナルモデル（relational model）}
        エドガー・F・コッドが1970年に数学の集合論に基づいて提案したデータモデルで、あらゆるデータが\textbf{テーブル}として表現される。
    \end{block}
    \vspace{1em}
    \textbf{リレーショナルモデルの特徴}
    \begin{itemize}
        \item データモデルが理解しやすい。
        \item 高いデータ独立性の実現。
        \item データ操作の非手続き性。
    \end{itemize}
    ビジネスデータ処理に広く利用されている。
    \vfill
    \href{https://www.example.com}{\beamerbutton{An Example}}
\end{frame}

\section{データベース管理システム}

\begin{frame}{データベース管理システム}
    \begin{block}{データベース管理システム（DBMS）}
        データベースを管理し、データに対する操作を提供するソフトウェア。
    \end{block}
    \vfill
    \textbf{DBMSの主な機能}
    \begin{itemize}
        \item データベース定義機能：スキーマ定義
        \item データベース操作機能：データの追加、削除、更新、検索
        \item データベース制御機能：障害回復、同時実行制御
    \end{itemize}

    \vfill
    \textbf{RDBMS}（リレーショナルデータベース管理システム）は、リレーショナルデータベースを管理するDBMSの一種。
\end{frame}

\begin{frame}{SQLとNoSQL}
    \begin{block}{SQL（Structured Query Language）}
        RDBMSにおいてデータの操作を行うためのドメイン固有言語\footnote{ドメイン固有言語：特定のタスク向けに設計されたコンピュータ言語である。汎用プログラミング言語の対義語。}。
    \end{block}
    \vfill
    \begin{block}{NoSQL（Not Only SQL）}
        RDBMS以外のデータベースを指す用語。非リレーショナルデータベース。
    \end{block}
\end{frame}

\begin{frame}{SQLの機能}
    \vspace{1em}
    \textbf{SQLの主な機能}
    \begin{itemize}
        \item データ定義言語（DDL）：CREATE, ALTER, DROP
        \item データ操作言語（DML）：SELECT, INSERT, UPDATE, DELETE
        \item データ制御言語（DCL）：GRANT, REVOKE
    \end{itemize}
    \vfill
    \begin{exampleblock}{例}
        \texttt{SELECT * FROM employees WHERE age > 30;}
    \end{exampleblock}
\end{frame}

\begin{frame}{主要なDBMS}
    RDBMS（Relational Database Management System）
    \begin{description}
        \item[SQLite] 軽量なRDBMS。
        \item[MySQL] オープンソースで広く利用されているRDBMS。
        \item[PostgreSQL] オープンソースのRDBMS。拡張性が高い。
        \item[Oracle Database] オラクル社が開発した商用RDBMS。
        \item[SQL Server] マイクロソフト社が開発した商用RDBMS。
        \item[その他] DB2, MariaDBなど。
    \end{description}

    \vfill

    NoSQL（Not Only SQL）
    \begin{description}
        \item[MongoDB] 非リレーショナルDBMS。JSON形式でデータを格納。
        \item[Cassandra] 分散型DBMS。大規模なデータを扱う。
        \item[その他] Redis, Neo4jなど。
    \end{description}
\end{frame}



\end{document} -->