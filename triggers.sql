-- the purpose of this trigger is to automatically recalculate and update a song's rating when a new review is 
-- inserted into the database. for the complete project we would also need triggers to update the rating when a 
-- review is deleted or updated but for this assignment we just did this one

-- DROP TRIGGER IF EXISTS tr_recalculate_song_rating_ai;

-- DELIMITER //
-- CREATE TRIGGER tr_recalculate_song_rating_ai
-- AFTER INSERT 
-- ON reviews
-- FOR EACH ROW 
-- BEGIN
-- 	UPDATE songs
-- 	SET song_rating = (
-- 		SELECT AVG(rating)
-- 		FROM reviews
-- 		WHERE song_id = NEW.song_id
-- 	)
-- 	WHERE song_id = NEW.song_id;
-- END //
-- DELIMITER ;

-- TEST INSERTING 
-- SELECT * FROM songs;
-- SELECT * FROM reviews;

-- INSERT INTO reviews
-- VALUES (10, 4, 6, 6, "Not timeless and not uplifting", "2025-11-11 22:10:13", "2025-11-11 22:10:13", 6000);

-- SELECT * FROM songs WHERE song_id = 6;

-- recalculate song rating when a review for it is modified
-- DROP TRIGGER IF EXISTS tr_recalculate_song_rating_au;

-- DELIMITER //
-- CREATE TRIGGER tr_recalculate_song_rating_au
-- AFTER UPDATE
-- ON reviews
-- FOR EACH ROW 
-- BEGIN
-- 	UPDATE songs
-- 	SET song_rating = (
-- 		SELECT AVG(rating)
-- 		FROM reviews
-- 		WHERE song_id = NEW.song_id
-- 	)
-- 	WHERE song_id = NEW.song_id;
-- END //
-- DELIMITER ;

-- recalculate song rating when a review for it is deleted
-- DROP TRIGGER IF EXISTS tr_recalculate_song_rating_ad;

-- DELIMITER //
-- CREATE TRIGGER tr_recalculate_song_rating_ad
-- AFTER DELETE
-- ON reviews
-- FOR EACH ROW 
-- BEGIN
-- 	UPDATE songs
-- 	SET song_rating = (
-- 		SELECT AVG(rating)
-- 		FROM reviews
-- 		WHERE song_id = OLD.song_id
-- 	)
-- 	WHERE song_id = OLD.song_id;
-- END //
-- DELIMITER ;

-- ---------------------------------------------------------------

-- TRIGGERS FOR LIKE COUNTS

-- increase number of likes for review when a user likes it
-- DROP TRIGGER IF EXISTS tr_review_likes_ai;
-- DELIMITER //
-- CREATE TRIGGER tr_review_likes_ai
-- AFTER INSERT
-- ON review_likes
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE reviews
--     SET like_count = like_count + 1
--     WHERE review_id = NEW.review_id;
-- END //
-- DELIMITER ;

-- decrease number of likes for review when like is removed
-- DROP TRIGGER IF EXISTS tr_review_likes_ad;
-- DELIMITER //
-- CREATE TRIGGER tr_review_likes_ad
-- AFTER DELETE
-- ON review_likes
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE reviews
--     SET like_count = like_count - 1
--     WHERE review_id = OLD.review_id;
-- END //
-- DELIMITER ;

-- test
-- SELECT * FROM reviews WHERE review_id = 1
-- SELECT * FROM review_likes
-- INSERT INTO review_likes
-- VALUES (3, 1);
-- SELECT * FROM reviews WHERE review_id = 1
-- DELETE FROM review_likes
-- WHERE user_id = 3 AND review_id = 1

-- ----------------------------------------------------------------------------

-- TRIGGERS FOR ARTIST FOLLOWER COUNT

-- this trigger increments follower count after a new follow
-- DROP TRIGGER IF EXISTS tr_artist_follower_count_ai
-- DELIMITER //
-- CREATE TRIGGER tr_artist_follower_count_ai
-- AFTER INSERT
-- ON artist_followers
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE artists
--     SET follower_count = follower_count + 1
--     WHERE artist_id = NEW.artist_id;
-- END //
-- DELIMITER ;

-- this trigger decrements artist follower count after a follow is deleted
-- DROP TRIGGER IF EXISTS tr_artist_follower_count_ad
-- DELIMITER //
-- CREATE TRIGGER tr_artist_follower_count_ad
-- AFTER DELETE
-- ON artist_followers
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE artists
--     SET follower_count = follower_count - 1
--     WHERE artist_id = OLD.artist_id;
-- END //
-- DELIMITER ;

-- test
-- SELECT * FROM artists;
-- SELECT * FROM artist_followers;
-- INSERT INTO artist_followers
-- VALUES(1, 3)
-- SELECT * FROM artists;
-- DELETE FROM artist_followers
-- WHERE user_id = 1 AND artist_id = 3
-- SELECT * FROM artists;

-- ------------------------------------------------

-- TRIGGERS FOR USER FOLLOWER/FOLLOWING

-- this trigger updates a user's follower count and a user's following count after insertion
-- DROP TRIGGER IF EXISTS tr_user_follow_ai
-- DELIMITER //
-- CREATE TRIGGER tr_user_follow_ai
-- AFTER INSERT
-- ON user_follows
-- FOR EACH ROW
-- BEGIN
-- 	-- increment follower count
-- 	UPDATE users
--     SET follower_count = follower_count + 1
--     WHERE user_id = NEW.followed_id;
--     
--     -- increment following count
--     UPDATE users
--     SET following_count = following_count + 1
--     WHERE user_id = NEW.follower_id;
-- END //
-- DELIMITER ;

-- this trigger updates a user's follower count and a user's following count after deletion
-- DROP TRIGGER IF EXISTS tr_user_follow_ad
-- DELIMITER //
-- CREATE TRIGGER tr_user_follow_ad
-- AFTER DELETE
-- ON user_follows
-- FOR EACH ROW
-- BEGIN
-- 	-- decrement follower count
-- 	UPDATE users
--     SET follower_count = follower_count - 1
--     WHERE user_id = OLD.followed_id;
--     
--     -- decrement following count
--     UPDATE users
--     SET following_count = following_count - 1
--     WHERE user_id = OLD.follower_id;
-- END //
-- DELIMITER ;

-- test
-- SELECT * FROM user_follows
-- SELECT * FROM USERS WHERE user_id = 1 OR user_id = 4
-- INSERT INTO user_follows
-- VALUES(1, 4);
-- DELETE FROM user_follows
-- WHERE follower_id = 1 AND followed_id = 4

-- -----------------------------------------------------------------------------------

-- this trigger increments the song count in an album
-- DROP TRIGGER IF EXISTS tr_total_tracks_ai
-- DELIMITER //
-- CREATE TRIGGER tr_total_tracks_ai
-- AFTER INSERT
-- ON songs
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE albums
--     SET total_tracks = total_tracks + 1
--     WHERE album_id = NEW.album_id;
-- END //
-- DELIMITER ;

-- INSERT INTO songs
-- VALUE()

-- this 


--------------------------------------------------------------------------------

-- Triggers for updating album rating

-- DROP TRIGGER IF EXISTS tr_album_rating_ai;
-- DELIMITER //
-- CREATE TRIGGER tr_album_rating_ai
-- AFTER INSERT
-- ON reviews
-- FOR EACH ROW
-- BEGIN
-- UPDATE albums
--      SET album_rating = (
--          SELECT AVG(r.rating)
--          FROM reviews r
--          JOIN songs s ON r.song_id = s.song_id
--          WHERE s.album_id = (SELECT album_id FROM songs WHERE song_id = NEW.song_id)
--      )
--      WHERE album_id = (SELECT album_id FROM songs WHERE song_id = NEW.song_id);
-- END //
-- DELIMITER ;

-- TEST INSERTING
 
-- SELECT * FROM albums;
-- SELECT * FROM songs;
-- SELECT * FROM reviews;

-- INSERT INTO songs (song_name, album_id, song_duration, release_date, play_count, song_rating)
-- VALUES ('Drain You', 1, 221, '1991-09-10', 1500000000, 4.6);

-- INSERT INTO reviews (user_id, song_id, rating, review_text, like_count)
-- VALUES (2, 9, 1, "Not timeless and not uplifting", 3);

-- DROP TRIGGER IF EXISTS tr_album_rating_au;
-- DELIMITER //
-- CREATE TRIGGER tr_album_rating_au
-- AFTER UPDATE
-- ON reviews
-- FOR EACH ROW
-- BEGIN
-- UPDATE albums
--      SET album_rating = (
--          SELECT AVG(r.rating)
--          FROM reviews r
--          JOIN songs s ON r.song_id = s.song_id
--          WHERE s.album_id = (SELECT album_id FROM songs WHERE song_id = NEW.song_id)
--      )
--      WHERE album_id = (SELECT album_id FROM songs WHERE song_id = NEW.song_id);
-- END //
-- DELIMITER ;

-- DROP TRIGGER IF EXISTS tr_album_rating_ad;
-- DELIMITER //
-- CREATE TRIGGER tr_album_rating_ad
-- AFTER DELETE
-- ON reviews
-- FOR EACH ROW
-- BEGIN
-- UPDATE albums
--      SET album_rating = (
--          SELECT AVG(r.rating)
--          FROM reviews r
--          JOIN songs s ON r.song_id = s.song_id
--          WHERE s.album_id = (SELECT album_id FROM songs WHERE song_id = OLD.song_id)
--      )
--      WHERE album_id = (SELECT album_id FROM songs WHERE song_id = OLD.song_id);
-- END //
-- DELIMITER ;