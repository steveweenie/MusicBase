-- A report query using a JOIN to report on an aggregate value with a GROUP BY clause.
-- Get all artists and their average rating with review counts
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



-- A query with a subquery.
-- Songs with above average global rating
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



-- A query to create a view and another query to demonstrate its use.
-- Creating a view for artists
CREATE OR REPLACE View v_artists_summary AS
SELECT a.artist_id, a.artist_name, a.country, COUNT(DISTINCT s.song_id) AS total_songs, ROUND(AVG(s.song_rating), 2) AS avg_rating, SUM(s.play_count) AS total_plays
FROM artists a
JOIN song_artists sa ON a.artist_id = sa.artist_id
JOIN songs s ON sa.song_id = s.song_id
GROUP BY a.artist_id, a.artist_name, a.country;

-- Find top 5 artists rating
SELECT *
FROM v_artists_summary
WHERE total_songs > 0
ORDER BY avg_rating DESC, total_plays DESC
LIMIT 5;



-- A trigger that updates or inserts data based on an insert.
-- Insert a new review (using user_id 21, which hasn't reviewed song with id 7 yet)
INSERT INTO reviews (user_id, song_id, rating, review_text) 
VALUES (21, 7, 1, "I'm 3 years old and I hate this song!"); 


-- Demonstrate Trigger Functionality (tr_recalculate_song_rating)

-- Show original rating for Song ID 6 ('Hey Jude')
SELECT song_name, song_rating AS original_rating FROM songs WHERE song_id = 6;

-- Insert a new review (using user_id 9, which hasn't reviewed song 6 yet)
INSERT INTO reviews (user_id, song_id, rating, review_text) 
VALUES (9, 6, 1, 'My least favorite Beatles song LOL xD!'); 

-- Show the new, recalculated rating for Song ID 6
SELECT song_name, song_rating AS new_rating FROM songs WHERE song_id = 6;
