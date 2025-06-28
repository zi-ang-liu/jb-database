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

SELECT albums.Title, COUNT(tracks.TrackId) AS TrackCount
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.Title
ORDER BY TrackCount ASC;

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