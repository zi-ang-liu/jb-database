# SQL実習

SQLの書き方を身につけるため、[Chinookデータベース](chinook.md)を使用し、SQLの総合演習を行う。

## SQL文20問

### tracksテーブル

```{mermaid}
---
title: tracks entity
---
erDiagram 
   tracks {
      integer TrackId PK
      nvarchar Name
      integer AlbumId
      integer MediaTypeId
      integer GenreId
      nvarchar Composer
      integer Milliseconds
      numeric UnitPrice
   }
```

1. `TrackId`、`Name`を取得するSQL文を書け。
2. `TrackId`、`Name`、`AlbumId`を取得し、`AlbumId`で昇順に並べ替えるSQL文を書け。
3. `TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。ただし、`AlbumId`が`1`のものだけを対象とする。
4. `TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。ただし、以下の条件を満たすものとする。
   - `AlbumId`が`1`のもの
   - `Milliseconds`が`200000`以上のもの
5. `Name`、`AlbumId`、`Composer`を取得するSQL文を書け。ただし、`Composer`の名前に`"Steve"`が含まれるものだけを対象とする。
6. `TrackId`、`Name`、`MediaTypeId`を取得するSQL文を書け。ただし、`MediaTypeId`が`1`または`2`のものだけを対象とする。（`IN`句を使用すること）
7. それぞれの`AlbumId`ごとに、トラックの数をカウントし、`AlbumId`、トラック数を取得するSQL文を書け。結果は`AlbumId`で昇順に並べ替えること。
8. `tracks`テーブルから、`TrackId`、`Name`、`GenreId`を取得するSQL文を書け。ただし、`GenreId`が`1`、`2`、`3`以外のものだけを対象とする。（`NOT IN`句を使用すること）
9. 「Wild」で始まるトラック名を持つトラックの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。
10. 「Honey」を含むトラック名を持つトラックの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。

### invoicesテーブル

```{mermaid}
---
title: invoices entity
---
erDiagram
   invoices {
      integer InvoiceId PK
      integer CustomerId
      datetime InvoiceDate
      nvarchar BillingAddress
      nvarchar BillingCity
      nvarchar BillingState
      nvarchar BillingCountry
      nvarchar BillingPostalCode
      numeric Total
   }
```


1. `BillingAddress`、`BillingCity`を取得するSQL文を書け。ただし、`BillingCity`が`"Chicago"`または`"New York"`のものだけを対象とする。
2. `BillingAddress`、`BillingCity`を取得するSQL文を書け。ただし、以下の条件を満たすものとする。
   - `BillingCity`が`"Chicago"`または`"New York"`のもの
   - `Total`が`10.00`以上のもの
3. `InvoiceId`、`BillingAddress`、`Total`を取得するSQL文を書け。ただし、`Total`が`14.00`以上かつ`18.00`以下のものだけを対象とする。(`Between`句を使用すること)
4. `BillingCountry`を取得するSQL文を書け。ただし、重複を除外すること。

### tracks, albums, artistsテーブル

```{mermaid}
erDiagram
   direction TB
   tracks }o--o{ albums : contains
   tracks {
      integer TrackId PK
      nvarchar Name
      integer AlbumId FK
      integer MediaTypeId
      integer GenreId
      nvarchar Composer
      integer Milliseconds
      numeric UnitPrice
   }
   albums }o--|| artists : creats
   albums {
      integer AlbumId PK
      nvarchar Title
      integer ArtistId FK
   }
   artists {
      integer ArtistId PK
      nvarchar Name
   }
```

1. `ArtistId`が`1`のアーティストが作ったアルバムの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。Hint: 副問合せ、`IN`句を使用すること。
2. `tracks`と`albums`テーブルを結合し、`tracks.TrackId`、`tracks.Name`、`albums.Title`を取得するSQL文を書け。
3. `tracks.TrackId`、`tracks.Name`、`albums.Title`，`artists.Name`を取得するSQL文を書け。（`JOIN`句を使用すること）
4. それぞれの`AlbumId`ごとに、トラックの数をカウントし、`albums.Title`、トラック数を取得するSQL文を書け。結果は`albums.Title`で昇順に並べ替えること。Hint: `JOIN`句を使用すること。
5. 上の問題の結果は，トラック数が`15`以上のものだけを対象とするSQL文を書け。Hint: `HAVING`句を使用すること。
6. アルバム名が`"Let There Be Rock"`のアルバムに含まれるトラックの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。Hint: 副問合せを使用すること。