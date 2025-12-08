DROP DATABASE IF EXISTS musicbase_db;
CREATE DATABASE musicbase_db;
USE musicbase_db;

-- Users Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    following_count INT DEFAULT 0,
    follower_count INT DEFAULT 0,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Artists Table
CREATE TABLE artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    monthly_listeners INT DEFAULT 0,
    follower_count INT DEFAULT 0
    -- Removed 'genre' as it's better linked to songs/albums
);

-- Albums Table 
CREATE TABLE albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(100) NOT NULL,
    release_date DATE,
    label VARCHAR(100),
    total_tracks INT DEFAULT 0,
    album_rating FLOAT DEFAULT 0
    -- Removed artist id because album can have multiple artists
);

-- Album Artists Junction Table
CREATE TABLE album_artists (
    album_id INT,
    artist_id INT,
    PRIMARY KEY (album_id, artist_id),
    FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

-- Songs Table
CREATE TABLE songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    album_id INT,
    song_duration INT NOT NULL,
    release_date DATE,
    play_count INT DEFAULT 0,
    song_rating FLOAT DEFAULT 0,
    FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL
    -- Removed artist id because it will be handled by song artists
);

-- Song Artists Junction Table
CREATE TABLE song_artists (
    song_id INT,
    artist_id INT,
    PRIMARY KEY (song_id, artist_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

-- genres Table
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

-- Song Genres Table
CREATE TABLE song_genres (
    song_id INT,
    genre_id INT,
    PRIMARY KEY (song_id, genre_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE
);

-- Reviews Table
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    song_id INT,
    rating INT CHECK (rating >= 0 AND rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_song (user_id, song_id)
);

-- User Follows Table
CREATE TABLE user_follows (
    follower_id INT,
    followed_id INT,
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (followed_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CHECK (follower_id != followed_id)
);

-- Artist Followers Table
CREATE TABLE artist_followers (
    user_id INT,
    artist_id INT,
    PRIMARY KEY (user_id, artist_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

-- Review Likes Table
CREATE TABLE review_likes (
    user_id INT,
    review_id INT,
    PRIMARY KEY (user_id, review_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (review_id) REFERENCES reviews(review_id) ON DELETE CASCADE
);


-- USERS
INSERT INTO users (username, email, password_hash, following_count, follower_count)
VALUES
('ceedot', 'chock@gmail.com', 'hashed_password_1', 150, 200),
('devilain05', 'lainswag@yahoo.com', 'hashed_password_2', 300, 450),
('sirnarly07', 'oombakhta@aol.com', 'hashed_password_3', 120, 180),
('stevecoder', 'meepis@gmail.com', 'hashed_password_4', 500, 600),
('silvesbro', 'samsilvestro@gmail.com', 'hashed_password_5', 200, 250),
('bestprofessor', 'hendalkitawi@gmail.com', 'hashed_password_6', 350, 400),
('champagnepapi', 'aubreygraham@gmail.com', 'hashed_password_7', 1000, 2000),
('your_grandma', 'your_grandma@gmail.com', 'hashed_password_8', 500, 1000),
('totallyoriginalusername', 'totallyoriginalusername@gmail.com', 'hashed_password_9', 100, 150),
('andytran910', 'andytran910@gmail.com', 'hashed_password_10', 250, 300),
('triple6babeslayer', 'triple6babeslayer@gmail.com', 'hashed_password_11', 200, 250),
('wonderland_queen', 'wonderland_queen@gmail.com', 'hashed_password_12', 150, 200),
('tyse_', 'tyse_@gmail.com', 'hashed_password_13', 100, 150),
('musiclover99', 'musiclover99@gmail.com', 'hashed_password_14', 100, 150),
('boog2u', 'boog2u@gmail.com', 'hashed_password_15', 100, 150),
('adrian.fitzmaurice', 'adrian.fitzmaurice@gmail.com', 'hashed_password_16', 100, 150),
('jaborgus', 'jaborgus@gmail.com', 'hashed_password_17', 100, 150),
('chopsawwy', 'chopsawwy@gmail.com', 'hashed_password_18', 100, 150),
('s1anide', 's1anide@gmail.com', 'hashed_password_19', 100, 150),
('poisoninmyveins', 'poisoninmyveins@gmail.com', 'hashed_password_20', 100, 150),
('the_real_deal', 'the_real_deal@gmail.com', 'hashed_password_21', 100, 150),
('eggbaconsausagelol', 'eggbaconsausagelol@gmail.com', 'hashed_password_22', 100, 150),
('nathan.lozano', 'nathan.lozano@gmail.com', 'hashed_password_23', 100, 150),
('usedwipes', 'usedwipes@gmail.com', 'hashed_password_24', 100, 150);


-- ARTISTS
INSERT INTO artists (artist_name, country, monthly_listeners, follower_count)
VALUES
('Nirvana', 'USA', 80000000, 7),
('Twenty One Pilots', 'USA', 60000000, 5),
('February', 'USA', 90000000, 3),
('Dax', 'USA', 70000000, 4),
('A New Day', 'USA', 100000000, 6),
('Beatles', 'UK', 120000000, 3),
('Smiths', 'UK', 110000000, 7),
('King Crimson', 'UK', 50000000, 4),
('Imagine Dragons', 'USA', 95000000, 8),
('Billie Eilish', 'USA', 85000000, 3),
('Metallica', 'USA', 75000000, 5),
('Linkin Park', 'USA', 65000000, 2),
('Adele', 'UK', 105000000, 5),
('Coldplay', 'UK', 115000000, 7),
('Eminem', 'USA', 130000000, 2),
('Rihanna', 'Barbados', 125000000, 15),
('Drake', 'Canada', 140000000, 16),
('Taylor Swift', 'USA', 135000000, 21),
('Bruno Mars', 'USA', 145000000, 12),
('Kendrick Lamar', 'USA', 155000000, 11),
('The Weeknd', 'Canada', 160000000, 18),
('Dua Lipa', 'UK', 170000000, 21),
('Post Malone', 'USA', 180000000, 21),
('Ariana Grande', 'USA', 190000000, 14),
('Ed Sheeran', 'UK', 200000000, 12);

-- ALBUMS
INSERT INTO albums (album_name, release_date, label, total_tracks, album_rating)
VALUES
('Nevermind','1991-09-24', 'DGC Records', 12, 4.9),
('Blurryface', '2015-05-29', 'Fueled by Ramen', 14, 4.7),
('February', '2020-05-15', 'Hehe Records', 10, 4.5),
('JOKER', '2018-10-31', 'Top Dawg Entertainment', 14, 4.6),
('So Close to Perfection...', '2025-09-12', 'Independent', 11, 4.8),
('Abbey Road', '1968-08-26', 'Apple Records', 17, 5.0),
('The Queen Is Dead', '1986-01-20', 'Rough Trade Records', 10, 4.9),
('In the Court of the Crimson King', '1969-10-10', 'Island Records', 5, 4.7),
('Origins', '2018-11-09', 'Interscope Records', 12, 4.4),
('When We All Fall Asleep, Where Do We Go?', '2019-03-29', 'Darkroom/Interscope Records', 14, 4.6),
('Master of Puppets', '1986-03-03', 'Elektra Records', 8, 4.8),
('Hybrid Theory', '2000-10-24', 'Warner Bros. Records', 12, 4.7),
('25', '2015-11-20', 'XL Recordings', 11, 4.9),
('A Head Full of Dreams', '2015-12-04', 'Parlophone', 11, 4.8),
('The Marshall Mathers LP', '2000-05-23', 'Aftermath/Interscope Records', 18, 4.7),
('Anti', '2016-01-28', 'Roc Nation', 13, 4.9),
('Scorpion', '2018-06-29', 'Young Money/Cash Money/Republic Records', 25, 4.6),
('1989', '2014-10-27', 'Big Machine Records', 13, 4.8),
('24K Magic', '2016-11-18', 'Atlantic Records', 9, 4.7),
('DAMN.', '2017-04-14', 'Top Dawg Entertainment/Aftermath/Interscope Records', 14, 4.8),
('After Hours', '2020-03-20', 'XO/Republic Records', 14, 4.7),
('Future Nostalgia', '2020-03-27', 'Warner Records', 11, 4.6),
('Hollywoods Bleeding', '2019-09-06', 'Republic Records', 17, 4.5),
('Thank U Next', '2019-02-08', 'Republic Records', 12, 4.6),
('Divide', '2017-03-03', 'Asylum/Atlantic Records', 16, 4.8);

-- ALBUM_ARTISTS (Linking albums to artists)
INSERT INTO album_artists (album_id, artist_id)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15), (16, 16), (17, 17), (18, 18), (19, 19), (20, 20), (21, 21), (22, 22), (23, 23), (24, 24), (25, 25);

-- SONGS
INSERT INTO songs (song_name, album_id, song_duration, release_date, play_count, song_rating)
VALUES
('Smells Like Teen Spirit', 1, 301, '1991-09-10', 1500000000, 4.8),
('Stressed Out', 2, 202, '2015-04-28', 1200000000, 4.5),
('No Way...', 3, 250, '2020-02-14', 800000000, 4.2),
('JOKER', 4, 230, '2018-10-31', 600000000, 4.0),
('Three Part Harmony', 5, 320, '2025-09-12', 900000000, 4.7),
('Hey Jude', 6, 431, '1968-08-26', 2000000000, 4.9),
('There Is a Light That Never Goes Out', 7, 285, '1986-01-20', 400000000, 4.6),
('21st Century Schizoid Man', 8, 405, '1969-10-10', 300000000, 4.4),
('Natural', 9, 187, '2018-11-09', 700000000, 4.3),
('Bad Guy', 10, 194, '2019-03-29', 1100000000, 4.5),
('Master of Puppets', 11, 515, '1986-03-03', 500000000, 4.8),
('In the End', 12, 216, '2000-10-24', 1300000000, 4.7),
('Hello', 13, 295, '2015-11-20', 1400000000, 4.9),
('Adventure of a Lifetime', 14, 263, '2015-12-04', 800000000, 4.6),
('The Real Slim Shady', 15, 284, '2000-05-23', 1200000000, 4.5),
('Work', 16, 208, '2016-01-28', 1500000000, 4.8),
('God''s Plan', 17, 198, '2018-06-29', 1600000000, 4.4),
('Blank Space', 18, 231, '2014-10-27', 1300000000, 4.7),
('24K Magic', 19, 230, '2016-11-18', 900000000, 4.5),
('HUMBLE.', 20, 177, '2017-04-14', 1400000000, 4.6),
('Blinding Lights', 21, 200, '2020-03-20', 1700000000, 4.7),
('Don''t Start Now', 22, 183, '2020-03-27', 1000000000, 4.5),
('Circles', 23, 215, '2019-09-06', 1100000000, 4.4),
('7 rings', 24, 178, '2019-02-08', 1200000000, 4.6),
('Shape of You', 25, 233, '2017-03-03', 1800000000, 4.8);

-- SONG_ARTISTS
INSERT INTO song_artists (song_id, artist_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 18),
(19, 19),
(20, 20),
(21, 21),
(22, 22),
(23, 23),
(24, 24),
(25, 25);

-- GENRES
INSERT INTO genres (genre_name)
VALUES ('Rock'), ('Pop'), ('Emo'), ('Rap'), ('Metalcore'), ('Progressive Rock'), ('Alternative Rock'), ('Indie Rock'), ('Hip Hop'), ('R&B'), ('Electronic'), ('Country'), ('Jazz'), ('Classical'), ('Reggae'), ('Funk'), ('Disco'), ('Punk Rock'), ('Soul'), ('Blues'), ('Folk'), ('Dream Pop'), ('Post Punk'), ('House'), ('Trap');

-- SONG_GENRES (Linking songs to genres)
INSERT INTO song_genres (song_id, genre_id)
VALUES
(1, 1), (1, 7), -- Smells Like Teen Spirit -> Rock, Alternative Rock
(2, 2), -- Stressed Out -> Pop
(3, 3), -- No Way... -> Emo
(4, 4), -- JOKER -> Rap
(5, 5), -- Three Part Harmony -> Metalcore
(6, 1), -- Hey Jude -> Rock
(7, 1), (7, 7), -- There Is a Light... -> Rock, Alternative Rock
(8, 6), -- 21st Century Schizoid Man -> Progressive Rock
(9, 2), -- Natural -> Pop
(10, 2), -- Bad Guy -> Pop
(11, 1), (11, 5), -- Master of Puppets -> Rock, Metalcore
(12, 1), (12, 7), -- In the End -> Rock, Alternative Rock
(13, 2), -- Hello -> Pop
(14, 2), -- Adventure of a Lifetime -> Pop
(15, 4), -- The Real Slim Shady -> Rap
(16, 10), -- Work -> R&B
(17, 4), -- God's Plan -> Rap
(18, 2), -- Blank Space -> Pop
(19, 17), -- 24K Magic -> Disco
(20, 4), -- HUMBLE. -> Rap
(21, 2), -- Blinding Lights -> Pop
(22, 2), -- Don't Start Now -> Pop
(23, 2), -- Circles -> Pop
(24, 2), -- 7 rings -> Pop
(25, 2); -- Shape of You -> Pop

-- REVIEWS
INSERT INTO reviews (user_id, song_id, rating, review_text, like_count)
VALUES
(1, 1, 5, 'An absolute classic that defined a generation.', 0),
(2, 2, 4, 'A catchy tune with relatable lyrics.', 0),
(3, 3, 4, 'Emotional and powerful performance.', 0),
(4, 4, 1, 'Good beat but lyrics could be better.', 0),
(1, 5, 5, 'A masterpiece in modern metalcore.', 0),
(2, 6, 5, 'Timeless and uplifting.', 0),
(3, 7, 4, 'Melancholic yet beautiful.', 0),
(4, 8, 4, 'Innovative and ahead of its time.', 0),
(1, 9, 3, 'Decent pop song, nothing special.', 0),
(2, 10, 4, 'Unique sound and style.', 0),
(3, 11, 5, 'One of the best metal songs ever.', 0),
(4, 12, 4, 'Great energy and emotion.', 0),
(1, 13, 5, 'A vocal performance like no other.', 0),
(2, 14, 4, 'Feel-good track with a great vibe.', 0),
(3, 15, 2, 'Not my style, but well-produced.', 0),
(4, 16, 5, 'Infectious rhythm and catchy chorus.', 0),
(1, 17, 4, 'Solid rap track with a good message.', 0),
(2, 18, 5, 'Perfect pop song with great hooks.', 0),
(3, 19, 4, 'Funky and fun to listen to.', 0),
(4, 20, 5, 'Powerful lyrics and delivery.', 0),
(1, 21, 5, 'An instant classic with a retro vibe.', 0),
(2, 22, 4, 'Dance-worthy and energetic.', 0),
(3, 23, 3, 'Good but overplayed on the radio.', 0),
(4, 24, 4, 'Catchy and trendy.', 0),
(1, 25, 5, 'One of the best pop songs of the decade.', 0);

-- USER_FOLLOWS
INSERT INTO user_follows (follower_id, followed_id)
VALUES
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 4),
(3, 1),
(4, 1),
(4, 2),
(5, 6),
(5, 7),
(6, 7),
(6, 8),
(7, 8),
(7, 5),
(8, 5),
(8, 6),
(21, 1),
(21, 2),
(21, 3),
(21, 4),
(21, 5),
(21, 6),
(21, 7),
(21, 8),
(21, 9),
(21, 10);


-- ARTIST_FOLLOWERS
INSERT INTO artist_followers (user_id, artist_id)
VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(5, 9),
(5, 10),
(6, 11),
(6, 12),
(7, 13),
(7, 14),
(8, 15),
(8, 16),
(10, 4),
(11, 4),
(12, 4),
(13, 4),
(14, 4),
(15, 4),
(16, 4),
(17, 4),
(18, 4);

-- REVIEW_LIKES
INSERT INTO review_likes (user_id, review_id)
VALUES
(1, 2),
(1, 3),
(2, 1),
(2, 4),
(3, 5),
(3, 6),
(4, 7),
(4, 8),
(1, 9),
(1, 10),
(2, 11),
(2, 12),
(3, 13),
(3, 14),
(4, 15),
(4, 16),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(10, 6),
(10, 7),
(10, 8),
(10, 9),
(10, 11);