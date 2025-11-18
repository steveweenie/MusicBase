-- the purpose of this procedure is to identify the popularity level of an artist since sometimes people
-- care about that because it makes them feel special. this procedure identifies if an artist is 
-- underground, rising, or mainstream based on their followers count.

DROP PROCEDURE IF EXISTS p_show_followers_group;

DELIMITER //
CREATE PROCEDURE p_show_followers_group(IN artist_id_param INT)
BEGIN
	DECLARE v_artist_followers DECIMAL(10, 2);
    
    SELECT follower_count
    INTO   v_artist_followers
    FROM   artists
    WHERE  artist_id = artist_id_param;
        
    CASE
		WHEN v_artist_followers >= 30000000 THEN SELECT 'Mainstream';
		WHEN v_artist_followers < 30000000 AND v_artist_followers > 20000000 THEN SELECT 'Rising';
		WHEN v_artist_followers <= 20000000 THEN SELECT 'Underground';
    END CASE;
END //
DELIMITER ;

-- SELECT * FROM artists WHERE artist_id = 1;

-- CALL p_show_followers_group(1);

DROP PROCEDURE IF EXISTS p_song_by_genre;

DELIMITER //
CREATE PROCEDURE p_song_by_genre(IN genre_name_param VARCHAR(100))
BEGIN
    SELECT s.song_name, s.song_duration, s.release_date
    FROM songs s
    JOIN song_genres sg ON s.song_id = sg.song_id
    JOIN genres g ON sg.genre_id = g.genre_id
    WHERE g.genre_name = genre_name_param;
END //
DELIMITER ;

-- CALL p_song_by_genre('Rock');

DELIMITER //
CREATE PROCEDURE p_album_by_genre(IN genre_name_param VARCHAR(100))
BEGIN
    SELECT DISTINCT a.album_name, a.release_date, a.label
    FROM albums a
    JOIN songs s ON a.album_id = s.album_id
    JOIN song_genres sg ON s.song_id = sg.song_id
    JOIN genres g ON sg.genre_id = g.genre_id
    WHERE g.genre_name = genre_name_param;
END //
DELIMITER ;

-- CALL p_album_by_genre('Rock');

DROP PROCEDURE IF EXISTS p_artist_information;

DELIMITER //

CREATE PROCEDURE p_artist_information(IN p_artist_id INT)
BEGIN
	
    /* Artist Information */
    SELECT a.artist_id, a.artist_name, a.country, a.monthly_listeners, a.follower_count
    FROM artists a
    WHERE a.artist_id = p_artist_id;

    SELECT ar.artist_id, ar.artist_name,
        al.album_id, al.album_name, al.release_date AS album_release_date, al.label,
        s.song_id, s.song_name, s.song_duration, s.song_rating, s.play_count, s.release_date AS song_release_date
	
    /* Artist Discograpghy */
    FROM artists ar
    JOIN album_artists aa ON ar.artist_id = aa.artist_id
    JOIN albums al ON aa.album_id = al.album_id
    JOIN songs s ON s.album_id = al.album_id
    WHERE ar.artist_id = p_artist_id
    ORDER BY al.release_date, s.release_date;

	/* Artist Ratings */
	SELECT truncate(AVG(s.song_rating), 2) AS avg_song_rating, SUM(s.play_count) AS total_artist_plays, COUNT(s.song_id) AS total_songs
    FROM songs s
    JOIN song_artists sa ON s.song_id = sa.song_id
    WHERE sa.artist_id = p_artist_id;
    
END //
DELIMITER ;

/* -- extra info to insert to show a bigger discography 
INSERT INTO albums (album_name, release_date, label, total_tracks, album_rating)
VALUES
('Clancy','2025-09-24', 'Fueled By Ramen', 10, 4.6);

INSERT INTO album_artists (album_id, artist_id)
VALUES (9, 2);

INSERT INTO songs (song_name, album_id, song_duration, release_date, play_count, song_rating)
VALUES('Ride', 2, 252, 2015-05-29', 14000000, 4.9), ('Next Semester', 9, 400, '2025-09-24', 17000000, 4.7);

CALL p_artist_information(2);
*/

DROP PROCEDURE IF EXISTS p_song_information;

DELIMITER //

CREATE PROCEDURE p_song_information(IN p_song_id INT)
BEGIN
    -- song information
    SELECT s.song_id, s.song_name, s.song_duration, s.play_count, s.song_rating, s.release_date, al.album_name, al.release_date AS album_release, al.label
    FROM songs s
    LEFT JOIN albums al ON s.album_id = al.album_id
    WHERE s.song_id = p_song_id;

    -- artists for the song
    SELECT ar.artist_id, ar.artist_name, ar.country, ar.monthly_listeners
    FROM artists ar
    JOIN song_artists sa ON ar.artist_id = sa.artist_id
    WHERE sa.song_id = p_song_id;

    -- generes for the song
    SELECT g.genre_name
    FROM genres g
    JOIN song_genres sg ON g.genre_id = sg.genre_id
    WHERE sg.song_id = p_song_id;

    -- rating based on reviews
    SELECT COUNT(*) AS number_of_reviews, AVG(rating) AS avg_review_rating, SUM(like_count) AS total_review_likes
    FROM reviews
    WHERE song_id = p_song_id;

END //

DELIMITER ;

-- CALL p_song_information(6);
