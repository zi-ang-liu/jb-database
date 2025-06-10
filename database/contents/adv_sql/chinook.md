# Chinook Database

Chinookは有名なデジタルメディアストアのデータベースで、音楽、アルバム、アーティスト、顧客、請求書などの情報を含んでいます。SQLの学習やデータベースをテストするためのサンプルデータベースとして広く使用されています。

Chinookデータベースは、以下のような特徴を持っています。

- 音楽関係のデータはApple iTunes libraryから取得されています。
- 顧客や請求書のデータは架空のもので、実際の個人情報は含まれていません。
- 販売データは自動生成されたもので、実際の販売データではありません。

## データベースのダウンロードと使用方法
Chinookデータベースは、SQLite形式で提供されています。以下の手順でデータベースをダウンロードし、VSCodeで開くことができます。

1. [chinook.db](./db/chinook.db)をダウンロードします。
2. Visual Studio Codeを開き、SQLite拡張機能をインストールします。
3. VSCodeの作業フォルダーに`chinook.db`ファイルを配置します。
4. VSCodeで`chinook.db`ファイルを右クリックし、「Open Database」を選択します。
5. 左下の「SQLite Explorer」からデータベースを参照できます。

## テーブルの概要

ChinookデータベースのER図は下記サイトで確認できます。

- [SQLite tutorial](https://www.sqlitetutorial.net/sqlite-sample-database/)
- [YugabyteDB](https://docs.yugabyte.com/preview/sample-data/chinook/)
- [github.com/lerocha/chinook-database](https://github.com/lerocha/chinook-database)

Chinookでは、以下のようなテーブルが含まれています。

- 作品
  - `artists`: アーティストのIDと名前が含まれている
  - `albums`: アルバムのID、タイトル、アーティストIDが含まれている
  - `tracks`: トラックのID、名前、アルバムIDなどが含まれている
  - `media_types`: メディアタイプのIDと名前が含まれている．AAC，MPEGなど
  - `genres`: ジャンルのIDと名前が含まれている．Rock，Jazzなど

- プレイリスト
  - `playlist`: プレイリストのIDと名前が含まれている．Music，Movies，90's Musicなど
  - `playlist_track`: プレイリストとトラックの関連情報が含まれている
  
- 顧客と請求書
  - `customers`: 顧客のID、名前、メールアドレス、住所などが含まれている．
  - `invoices`: 請求書のID、顧客ID、請求日、合計金額などが含まれている
  - `invoice_items`: 請求書アイテムのID、請求書ID、トラックID、単価、数量などが含まれている
  - `employees`: 従業員のID、名前、役職などが含まれている．一名の顧客は0または1人の従業員が担当している
