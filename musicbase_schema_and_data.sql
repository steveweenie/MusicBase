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
    genre VARCHAR(50)
);

-- Albums Table 
CREATE TABLE albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(100) NOT NULL,
    artist_id INT,
    release_date DATE,
    label VARCHAR(100),
    total_tracks INT DEFAULT 0,
    album_rating FLOAT DEFAULT 0,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE SET NULL
);

-- Songs Table
CREATE TABLE songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    song_name VARCHAR(100) NOT NULL,
    album_id INT,
    artist_id INT,
    song_duration INT NOT NULL,
    release_date DATE,
    play_count INT DEFAULT 0,
    song_rating FLOAT DEFAULT 0,
    FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE SET NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE SET NULL
);

-- Song Artists Junction Table
CREATE TABLE song_artists (
    song_id INT,
    artist_id INT,
    PRIMARY KEY (song_id, artist_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

-- Reviews Table
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    song_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(song_id) ON DELETE CASCADE
);

-- User Follows Table
CREATE TABLE user_follows (
    follower_id INT,
    followed_id INT,
    PRIMARY KEY (follower_id, followed_id),
    FOREIGN KEY (follower_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (followed_id) REFERENCES users(user_id) ON DELETE CASCADE
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


