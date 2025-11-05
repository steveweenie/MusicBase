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
    follower_count INT DEFAULT 0,
    -- Removed 'genre' as it's better linked to songs/albums
    );

-- Albums Table 
CREATE TABLE albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(100) NOT NULL,
    release_date DATE,
    label VARCHAR(100),
    total_tracks INT DEFAULT 0,
    album_rating FLOAT DEFAULT 0,
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
    FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL,
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
('stevecoder', 'meepis@gmail.com', 'hashed_password_4', 500, 600);

-- ARTISTS
INSERT INTO artists (artist_name, country, monthly_listeners, follower_count)
VALUES
('Nirvana', 'USA', 80000000, 25000000),
('Twenty One Pilots', 'USA', 60000000, 20000000),
('February', 'USA', 90000000, 30000000),
('Dax', 'USA', 70000000, 22000000),
('A New Day', 'USA', 100000000, 40000000),
('Beatles', 'UK', 120000000, 50000000),
('Smiths', 'UK', 110000000, 45000000),
('King Crimson', 'UK', 50000000, 15000000);

-- ALBUMS
INSERT INTO albums (album_name, release_date, label, total_tracks, album_rating)
VALUES
('Nevermind', 1, '1991-09-24', 'DGC Records', 12, 4.9),
('Blurryface', 2, '2015-05-29', 'Fueled by Ramen', 14, 4.7),
('February', 3, '2020-05-15', 'Hehe Records', 10, 4.5),
('JOKER', 4, '2018-10-31', 'Top Dawg Entertainment', 14, 4.6),
('So Close to Perfection...', 5, '2025-09-12', 'Independent', 11, 4.8),
('Abbey Road', 6, '1968-08-26', 'Apple Records', 17, 5.0),
('The Queen Is Dead', 7, '1986-01-20', 'Rough Trade Records', 10, 4.9),
('In the Court of the Crimson King', 8, '1969-10-10', 'Island Records', 5, 4.7);

-- ALBUM_ARTISTS (Linking albums to artists)
INSERT INTO album_artists (album_id, artist_id)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8);

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
('21st Century Schizoid Man', 8, 405, '1969-10-10', 300000000, 4.4);


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
(8, 8);

-- GENRES
INSERT INTO genres (genre_name)
VALUES ('Rock'), ('Pop'), ('Emo'), ('Rap'), ('Metalcore'), ('Progressive Rock'), ('Alternative Rock');

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
(8, 6); -- 21st Century Schizoid Man -> Progressive Rock

-- REVIEWS
INSERT INTO reviews (user_id, song_id, rating, review_text, like_count)
VALUES
(1, 1, 5, 'An absolute classic that defined a generation.', 1200),
(2, 2, 4, 'A catchy tune with relatable lyrics.', 950),
(3, 3, 4, 'Emotional and powerful performance.', 800),
(4, 4, 1, 'Good beat but lyrics could be better.', 600),
(1, 5, 5, 'A masterpiece in modern metalcore.', 1100),
(2, 6, 5, 'Timeless and uplifting.', 1500),
(3, 7, 4, 'Melancholic yet beautiful.', 700),
(4, 8, 4, 'Innovative and ahead of its time.', 500);

--USER_FOLLOWS
INSERT INTO user_follows (follower_id, followed_id)
VALUES
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 4),
(3, 1),
(4, 1),
(4, 2);

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
(4, 8);

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
(4, 8);