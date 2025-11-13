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

SELECT * FROM artists WHERE artist_id = 1;

CALL p_show_followers_group(1);