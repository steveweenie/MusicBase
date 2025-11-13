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