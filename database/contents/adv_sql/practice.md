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
8. `TrackId`、`Name`、`GenreId`を取得するSQL文を書け。ただし、`GenreId`が`1`、`2`、`3`以外のものだけを対象とする。（`NOT IN`句を使用すること）
9. 「Wild」で始まるトラック名を持つトラックの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。
10. 「Honey」を含むトラック名を持つトラックの`TrackId`、`Name`、`AlbumId`を取得するSQL文を書け。

```sql
-- 1. 解答例: TrackId、Nameを取得するSQL文
SELECT TrackId, Name 
FROM tracks;

-- 2. 解答例: TrackId、Name、AlbumIdを取得し、AlbumIdで昇順に並べ替えるSQL文
SELECT TrackId, Name, AlbumId 
FROM tracks 
ORDER BY AlbumId ASC;

-- 3. 解答例: TrackId、Name、AlbumIdを取得するSQL文。ただし、AlbumIdが1のものだけを対象とする。
SELECT TrackId, Name, AlbumId 
FROM tracks 
WHERE AlbumId = 1;

-- 4. 解答例: TrackId、Name、AlbumIdを取得するSQL文。ただし、以下の条件を満たすものとする。
-- - AlbumIdが1のもの
-- - Millisecondsが200000以上のもの
SELECT TrackId, Name, AlbumId 
FROM tracks
WHERE AlbumId = 1 AND Milliseconds >= 200000;

-- 5. 解答例: Name、AlbumId、Composerを取得するSQL文。ただし、Composerの名前に"Steve"が含まれるものだけを対象とする。
SELECT Name, AlbumId, Composer 
FROM tracks
WHERE Composer LIKE '%Steve%';

-- 6. 解答例: TrackId、Name、MediaTypeIdを取得するSQL文。ただし、MediaTypeIdが1または2のものだけを対象とする。
SELECT TrackId, Name, MediaTypeId 
FROM tracks
WHERE MediaTypeId IN (1, 2);

-- 7. 解答例: それぞれのAlbumIdごとに、トラックの数をカウントし、AlbumId、トラック数を取得するSQL文。結果はAlbumIdで昇順に並べ替えること。
SELECT AlbumId, COUNT(TrackId) AS TrackCount
FROM tracks
GROUP BY AlbumId
ORDER BY AlbumId ASC;

-- 8. 解答例: TrackId、Name、GenreIdを取得するSQL文。ただし、GenreIdが1、2、3以外のものだけを対象とする。
SELECT TrackId, Name, GenreId 
FROM tracks
WHERE GenreId NOT IN (1, 2, 3);

-- 9. 解答例: 「Wild」で始まるトラック名を持つトラックのTrackId、Name、AlbumIdを取得するSQL文。
SELECT TrackId, Name, AlbumId 
FROM tracks
WHERE Name LIKE 'Wild%';

-- 10. 解答例: 「Honey」を含むトラック名を持つトラックのTrackId、Name、AlbumIdを取得するSQL文。
SELECT TrackId, Name, AlbumId 
FROM tracks
WHERE Name LIKE '%Honey%';
```



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


```sql
-- 1. 解答例: BillingAddress、BillingCityを取得するSQL文。ただし、BillingCityが"Chicago"または"New York"のものだけを対象とする。
SELECT BillingAddress, BillingCity 
FROM invoices
WHERE BillingCity IN ('Chicago', 'New York');

-- 2. 解答例: BillingAddress、BillingCityを取得するSQL文。ただし、以下の条件を満たすものとする。
-- - BillingCityが"Chicago"または"New York"のもの
-- - Totalが10.00以上のもの
SELECT BillingAddress, BillingCity 
FROM invoices
WHERE BillingCity IN ('Chicago', 'New York') AND Total >= 10.00;

-- 3. 解答例: InvoiceId、BillingAddress、Totalを取得するSQL文。ただし、Totalが14.00以上かつ18.00以下のものだけを対象とする。
SELECT InvoiceId, BillingAddress, Total 
FROM invoices
WHERE Total BETWEEN 14.00 AND 18.00;

-- 4. 解答例: BillingCountryを取得するSQL文。ただし、重複を除外すること。
SELECT DISTINCT BillingCountry 
FROM invoices;
```

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

```sql
-- 1. 解答例: ArtistIdが1のアーティストが作ったアルバムのTrackId、Name、AlbumIdを取得するSQL文。
SELECT TrackId, Name, AlbumId 
FROM tracks
WHERE AlbumId IN (
   SELECT AlbumId 
   FROM albums 
   WHERE ArtistId = 1
   );

-- 2. 解答例: tracksとalbumsテーブルを結合し、tracks.TrackId、tracks.Name、albums.Titleを取得するSQL文。
SELECT tracks.TrackId, tracks.Name, albums.Title 
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId;

-- 3. 解答例: tracks.TrackId、tracks.Name、albums.Title，artists.Nameを取得するSQL文。（JOIN句を使用すること）
SELECT tracks.TrackId, tracks.Name, albums.Title, artists.Name
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN artists ON albums.ArtistId = artists.ArtistId;

-- 4. 解答例: それぞれのAlbumIdごとに、トラックの数をカウントし、albums.Title、トラック数を取得するSQL文。結果はalbums.Titleで昇順に並べ替えること。
SELECT albums.Title, COUNT(tracks.TrackId) AS TrackCount
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.Title
ORDER BY albums.Title ASC;

-- 5. 解答例: 上の問題の結果は，トラック数が15以上のものだけを対象とするSQL文。
SELECT albums.Title, COUNT(tracks.TrackId) AS TrackCount
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.Title
HAVING COUNT(tracks.TrackId) >= 15
ORDER BY albums.Title ASC;

-- 6. 解答例: アルバム名が"Let There Be Rock"のアルバムに含まれるトラックのTrackId、Name、AlbumIdを取得するSQL文。
SELECT TrackId, Name, AlbumId 
FROM tracks
WHERE AlbumId IN (
   SELECT AlbumId 
   FROM albums 
   WHERE Title = 'Let There Be Rock'
   );
```