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
-- VALUES (10, 4, 6, 1, "Not timeless and not uplifting", "2025-11-11 22:10:13", "2025-11-11 22:10:13", 6000);

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

-- TRIGGERS FOR _____

