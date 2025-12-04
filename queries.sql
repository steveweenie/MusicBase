CREATE DATABASE IF NOT EXISTS musicbase_db;
USE musicbase_db;

-- Query 1: Read Top 5 Artists by Monthly Listeners
SELECT artist_name, monthly_listeners
FROM artists
ORDER BY monthly_listeners DESC
LIMIT 5;


-- Query 2: Create new artist, album, and song 
INSERT INTO artists (artist_name, country, monthly_listeners, follower_count) -- no genre's in artists => removed genre
VALUES ('Of Montreal', 'America', 544000, 365000);

INSERT INTO albums (album_name, release_date, label, total_tracks, album_rating) -- no album id
VALUES ('Skeletal Lamping', '2008-10-21', 'Polyvinyl Record Co.', 15, 4.5);

INSERT INTO songs (song_name, album_id, song_duration, release_date, play_count, song_rating) -- no artist id
VALUES ('Gallery Piece', 9, 225, '2008-10-21', 14000000, 4.9),
       ('Wraith Pinned to the Mist and Other Games', 9, 300, '2008-10-21', 43000000, 4.7);

-- Query 3: Read user with the highest follower count
SELECT * FROM users
WHERE follower_count = (SELECT MAX(follower_count) FROM users);

-- Query 4: Update play count for a specific song
UPDATE songs
SET play_count = play_count + 1000
WHERE song_id = 1;

-- Query 5: Delete a song by song_id
DELETE FROM songs
WHERE song_id = 10;

-- Query 6: lists all songs, the albums they are in, and the artists name
SELECT s.song_name, a.album_name, ar.artist_name
FROM songs s
JOIN albums a ON s.album_id = a.album_id
JOIN song_artists sa ON s.song_id = sa.song_id
JOIN artists ar ON sa.artist_id = ar.artist_id;

-- Query 7: all reviews with the reviewers name, song name, and their rating
SELECT u.username, s.song_name, r.rating, r.review_text, r.like_count
FROM reviews r
JOIN users u ON r.user_id = u.user_id
JOIN songs s ON r.song_id = s.song_id;

-- Query 8: songs and their genre's
SELECT s.song_name, GROUP_CONCAT(g.genre_name SEPARATOR ', ') AS genres
FROM songs s
JOIN song_genres sg ON s.song_id = sg.song_id
JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY s.song_name;

-- Query 9: all users and all the artists they follow
SELECT u.username AS follower, ar.artist_name AS followed_artist
FROM artist_followers af
JOIN users u ON af.user_id = u.user_id
JOIN artists ar ON af.artist_id = ar.artist_id;

-- Query 10: average rating of all songs
SELECT ar.artist_name, ROUND(AVG(r.rating), 2) AS avg_rating
FROM reviews r
JOIN songs s ON r.song_id = s.song_id
JOIN song_artists sa ON s.song_id = sa.song_id
JOIN artists ar ON sa.artist_id = ar.artist_id
GROUP BY ar.artist_name;

-- Query 11: top 5 most played songs
SELECT s.song_name, ar.artist_name, a.album_name, s.play_count
FROM songs s
JOIN song_artists sa ON s.song_id = sa.song_id
JOIN artists ar ON sa.artist_id = ar.artist_id
JOIN albums a ON s.album_id = a.album_id
ORDER BY s.play_count DESC
LIMIT 5;

-- Query 12: All information about A new day, including their albums, songs, and genres
SELECT a.artist_id, a.artist_name, a.country, a.monthly_listeners, a.follower_count, al.album_id, al.album_name, al.release_date AS album_release, al.label AS album_label, al.total_tracks, al.album_rating, s.song_id, s.song_name, s.song_duration, s.release_date AS song_release, s.play_count, s.song_rating, g.genre_name

FROM artists a
LEFT JOIN album_artists aa ON a.artist_id = aa.artist_id
LEFT JOIN albums al ON aa.album_id = al.album_id
LEFT JOIN songs s ON s.album_id = al.album_id
LEFT JOIN song_genres sg ON sg.song_id = s.song_id
LEFT JOIN genres g ON g.genre_id = sg.genre_id

WHERE a.artist_name = 'A New Day'
ORDER BY al.album_id, s.song_id;

-- Query 13: Get all artists and their average rating with review counts
SELECT 
    a.artist_name,
    COUNT(DISTINCT r.review_id) AS total_reviews,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM artists a
JOIN song_artists sa ON sa.artist_id = a.artist_id
JOIN songs s ON sa.song_id = s.song_id
JOIN reviews r ON s.song_id = r.song_id
GROUP BY a.artist_name
HAVING COUNT(s.song_id) > 0
ORDER BY avg_rating;

-- Query 14: Songs with above average global ratings
SELECT 
    s.song_name,
    ar.artist_name,
    s.song_rating
FROM songs s
JOIN song_artists sa ON s.song_id = sa.song_id
JOIN artists ar ON sa.artist_id = ar.artist_id
WHERE s.song_rating > (
    SELECT AVG(song_rating) 
    FROM songs 
    WHERE song_rating > 0
)
ORDER BY s.song_rating DESC;

-- Query 15: Creating a view for artists
CREATE OR REPLACE View v_artists_summary AS
SELECT a.artist_id, a.artist_name, a.country, COUNT(DISTINCT s.song_id) AS total_songs, ROUND(AVG(s.song_rating), 2) AS avg_rating, SUM(s.play_count) AS total_plays
FROM artists a
JOIN song_artists sa ON a.artist_id = sa.artist_id
JOIN songs s ON sa.song_id = s.song_id
GROUP BY a.artist_id, a.artist_name, a.country;

-- Query 16: Find top 5 artists rating
SELECT *
FROM v_artists_summary
WHERE total_songs > 0
ORDER BY avg_rating DESC, total_plays DESC
LIMIT 5;

-- Query 17: Find top 5 most played artists 
SELECT *
FROM v_artists_summary
WHERE total_songs > 0
ORDER BY total_plays DESC
LIMIT 5;

-- Query 18: Creating a view for songs and thier genres
CREATE OR REPLACE VIEW v_song_genres AS
SELECT s.song_id, s.song_name, s.album_id, GROUP_CONCAT(g.genre_name ORDER BY g.genre_name SEPARATOR ', ') AS genres
FROM songs s
LEFT JOIN song_genres sg ON s.song_id = sg.song_id
LEFT JOIN genres g ON sg.genre_id = g.genre_id
GROUP BY s.song_id, s.song_name, s.album_id;

-- Query 19: Find songs based on thier genre using the Song Genres View
SELECT song_id, song_name, genres
FROM v_song_genres
WHERE genres LIKE '%Rock%';