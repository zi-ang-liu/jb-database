SELECT albums.AlbumId, albums.Title, COUNT(tracks.TrackId) AS TrackCount
FROM tracks
JOIN albums ON tracks.AlbumId = albums.AlbumId
GROUP BY albums.AlbumId
ORDER BY TrackCount ASC;