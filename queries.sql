CREATE DATABASE IF NOT EXISTS musicbase_db;
USE musicbase_db;

-- Query 1: Read Top 5 Artists by Monthly Listeners
SELECT artist_name, monthly_listeners
FROM artists
ORDER BY monthly_listeners DESC
LIMIT 5;

-- Query 2: Create new artist, album, and song
INSERT INTO artists (artist_name, country, monthly_listeners, follower_count, genre)
VALUES ('Of Montreal', 'America', 544000, 365000, 'Alternative/Indie');

INSERT INTO albums (album_name, artist_id, release_date, label, total_tracks, album_rating)
VALUES ('Skeletal Lamping', 1, '2008-10-21', 'Polyvinyl Record Co.', 15, 4.5);

INSERT INTO songs (song_name, album_id, artist_id, song_duration, release_date, play_count, song_rating)
VALUES ('Gallery Piece', 1, 1, 225, '2008-10-21', 14000000, 4.9),
       ('Wraith Pinned to the Mist and Other Games', 1, 1, 300, '2008-10-21', 43000000, 4.7);

-- Query 3: Read user with the highest follower count
SELECT * FROM users
WHERE follower_count = (SELECT MAX(follower_count) FROM users);

--Query 4: Update play count for a specific song
UPDATE songs
SET play_count = play_count + 1000
WHERE song_id = 1;

--Query 5: Delete a song by song_id
DELETE FROM songs
WHERE song_id = 2;