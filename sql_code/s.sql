SELECT * FROM customers
ORDER BY FirstName ASC;

SELECT * FROM employees
ORDER BY BirthDate DESC;

SELECT AlbumId, COUNT(*) AS TrackCount
FROM tracks
GROUP BY AlbumId
ORDER BY TrackCount ASC;

SELECT ArtistId, COUNT(*) AS AlbumCount
FROM albums
GROUP BY ArtistId
HAVING COUNT(*) >= 5
ORDER BY AlbumCount DESC;