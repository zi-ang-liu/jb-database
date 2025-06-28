# SQL実習

SQLの書き方を身につけるため、[Chinookデータベース](chinook.md)を使用し、SQLの総合演習を行う。

## 問題

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

1. `tracks`テーブルから、`TrackId`、`Name`を取得するSQL文を書け。
2. `tracks`テーブルから、`TrackId`、`Name`、`AlbumId`を取得し、`AlbumId`で昇順に並べ替えるSQL文を書け。
3. `tracks`テーブルから、`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。ただし、`AlbumId`が`1`のものだけを対象とする。
4. `tracks`テーブルから、`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。ただし、以下の条件を満たすものとする。
   - `AlbumId`が`1`のもの
   - `Milliseconds`が`200000`以上のもの
5. `tracks`テーブルから、`Name`、`AlbumId`、`Composer`を取得するSQL文を書け。ただし、`Composer`の名前に`"Steve"`が含まれるものだけを対象とする。
6. `tracks`テーブルから、`TrackId`、`Name`、`MediaTypeId`を取得するSQL文を書け。ただし、`MediaTypeId`が`1`または`2`のものだけを対象とする。（`IN`句を使用すること）

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

6. `invoices`テーブルから、`BillingAddress`、`BillingCity`を取得するSQL文を書け。ただし、`BillingCity`が`"Chicago"`または`"New York"`のものだけを対象とする。
7. `invoices`テーブルから、`BillingAddress`、`BillingCity`を取得するSQL文を書け。ただし、以下の条件を満たすものとする。
   - `BillingCity`が`"Chicago"`または`"New York"`のもの
   - `Total`が`10.00`以上のもの
8. `invoices`テーブルから、`InvoiceId`、`BillingAddress`、`Total`を取得するSQL文を書け。ただし、`Total`が`14.00`以上かつ`18.00`以下のものだけを対象とする。(`Between`句を使用すること)

### 結合

```{mermaid}
erDiagram
   tracks }|--o{ albums : contains
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
   albums }|--|| artists : creats
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

<!-- ```{mermaid}
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
``` -->
9.  `albums`テーブルから、すべての列を取得するSQL文を書け。
10. `albums`テーブルから、すべての列を取得するSQL文を書け。ただし、`ArtistId`が`1`のものだけを対象とする。
11. `ArtistId`が`1`のアーティストがリリースしたアルバムの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。Hint: 副問合せ、`IN`句を使用すること。
12. `tracks`テーブルから、`TrackId`、`Name`、`GenreId`を取得するSQL文を書け。ただし、`GenreId`が`1`、`2`、`3`以外のものだけを対象とする。（`NOT IN`句を使用すること）
13. `tracks`と`albums`テーブルを結合し、`tracks.TrackId`、`tracks.Name`、`albums.Title`を取得するSQL文を書け。