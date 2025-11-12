-- the purpose of this trigger is to automatically recalculate and update a song's rating when a new review is 
-- inserted into the database. for the complete project we would also need triggers to update the rating when a 
-- review is deleted or updated.

use musicbase_db;

DROP TRIGGER IF EXISTS tr_recalculate_song_rating;

DELIMITER //
CREATE TRIGGER tr_recalculate_song_rating
AFTER INSERT 
ON reviews
FOR EACH ROW 
BEGIN
	UPDATE songs
	SET song_rating = (
		SELECT AVG(rating)
		FROM reviews
		WHERE song_id = NEW.song_id
	)
	WHERE song_id = NEW.song_id;
END //
DELIMITER ;

SELECT * FROM songs;
SELECT * FROM reviews;

INSERT INTO reviews
VALUES (10, 4, 6, 1, "Not timeless and not uplifting", "2025-11-11 22:10:13", "2025-11-11 22:10:13", 6000);

SELECT * FROM songs WHERE song_id = 6;
