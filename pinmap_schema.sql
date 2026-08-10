-- PinMap Database Schema
-- Run this FIRST before any seed data

CREATE DATABASE IF NOT EXISTS pinmap CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE pinmap;

-- ===== USERS =====
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  first_name VARCHAR(50) DEFAULT NULL,
  last_name VARCHAR(50) DEFAULT NULL,
  bio TEXT DEFAULT NULL,
  profile_picture VARCHAR(500) DEFAULT NULL,
  profile_status ENUM('public', 'private') DEFAULT 'public',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ===== COUNTRIES =====
CREATE TABLE IF NOT EXISTS countries (
  country_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  continent VARCHAR(50) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  flag_image VARCHAR(500) DEFAULT NULL,
  primary_color VARCHAR(7) DEFAULT NULL,
  secondary_color VARCHAR(7) DEFAULT NULL
) ENGINE=InnoDB;

-- ===== CITIES =====
CREATE TABLE IF NOT EXISTS cities (
  city_id INT AUTO_INCREMENT PRIMARY KEY,
  country_id INT NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT DEFAULT NULL,
  latitude DECIMAL(10, 7) DEFAULT NULL,
  longitude DECIMAL(10, 7) DEFAULT NULL,
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== PLACE CATEGORIES =====
CREATE TABLE IF NOT EXISTS place_categories (
  category_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  icon VARCHAR(50) DEFAULT NULL,
  marker_color VARCHAR(7) DEFAULT NULL
) ENGINE=InnoDB;

-- ===== PLACES =====
CREATE TABLE IF NOT EXISTS places (
  place_id INT AUTO_INCREMENT PRIMARY KEY,
  city_id INT NOT NULL,
  category_id INT DEFAULT NULL,
  name VARCHAR(200) NOT NULL,
  short_description TEXT DEFAULT NULL,
  full_description TEXT DEFAULT NULL,
  address VARCHAR(300) DEFAULT NULL,
  latitude DECIMAL(10, 7) DEFAULT NULL,
  longitude DECIMAL(10, 7) DEFAULT NULL,
  website VARCHAR(500) DEFAULT NULL,
  opening_hours VARCHAR(200) DEFAULT NULL,
  image_cover VARCHAR(500) DEFAULT '',
  FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES place_categories(category_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ===== PLACE PHOTOS =====
CREATE TABLE IF NOT EXISTS place_photos (
  photo_id INT AUTO_INCREMENT PRIMARY KEY,
  place_id INT NOT NULL,
  image_url VARCHAR(500) NOT NULL,
  FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== TRIPS =====
CREATE TABLE IF NOT EXISTS trips (
  trip_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  country_id INT DEFAULT NULL,
  start_date DATE DEFAULT NULL,
  end_date DATE DEFAULT NULL,
  trip_type VARCHAR(50) DEFAULT NULL,
  travel_style VARCHAR(50) DEFAULT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ===== TRIP DAYS =====
CREATE TABLE IF NOT EXISTS trip_days (
  day_id INT AUTO_INCREMENT PRIMARY KEY,
  trip_id INT NOT NULL,
  day_number INT NOT NULL,
  date DATE DEFAULT NULL,
  FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== TRIP ACTIVITIES =====
CREATE TABLE IF NOT EXISTS trip_activities (
  activity_id INT AUTO_INCREMENT PRIMARY KEY,
  day_id INT NOT NULL,
  place_id INT DEFAULT NULL,
  time_slot ENUM('Morning', 'Afternoon', 'Evening') DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  FOREIGN KEY (day_id) REFERENCES trip_days(day_id) ON DELETE CASCADE,
  FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ===== JOURNALS =====
CREATE TABLE IF NOT EXISTS journals (
  journal_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  country_id INT DEFAULT NULL,
  cover_image VARCHAR(500) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- ===== JOURNAL PAGES =====
CREATE TABLE IF NOT EXISTS journal_pages (
  page_id INT AUTO_INCREMENT PRIMARY KEY,
  journal_id INT NOT NULL,
  page_number INT NOT NULL,
  background_color VARCHAR(7) DEFAULT NULL,
  FOREIGN KEY (journal_id) REFERENCES journals(journal_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== JOURNAL ELEMENTS =====
CREATE TABLE IF NOT EXISTS journal_elements (
  element_id INT AUTO_INCREMENT PRIMARY KEY,
  page_id INT NOT NULL,
  element_type ENUM('text','image','sticker','ticket') NOT NULL,
  content TEXT DEFAULT NULL,
  image_url VARCHAR(500) DEFAULT NULL,
  x_position INT DEFAULT 0,
  y_position INT DEFAULT 0,
  width INT DEFAULT 200,
  height INT DEFAULT 100,
  scale DOUBLE DEFAULT 1,
  rotation DOUBLE DEFAULT 0,
  z_index INT NOT NULL DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (page_id) REFERENCES journal_pages(page_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== TICKET SCANS =====
CREATE TABLE IF NOT EXISTS ticket_scans (
  ticket_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  journal_id INT NOT NULL,
  page_id INT DEFAULT NULL,
  original_image_url VARCHAR(500) DEFAULT NULL,
  processed_image_url VARCHAR(500) DEFAULT NULL,
  background_removed TINYINT(1) DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (journal_id) REFERENCES journals(journal_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== WISHLIST =====
CREATE TABLE IF NOT EXISTS wishlist (
  wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  place_id INT DEFAULT NULL,
  country_id INT DEFAULT NULL,
  added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE,
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== VISITED PLACES =====
CREATE TABLE IF NOT EXISTS visited_places (
  user_id INT NOT NULL,
  place_id INT NOT NULL,
  visit_date DATE DEFAULT NULL,
  notes TEXT DEFAULT NULL,
  PRIMARY KEY (user_id, place_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== RATINGS =====
CREATE TABLE IF NOT EXISTS ratings (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  place_id INT NOT NULL,
  rating TINYINT UNSIGNED DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (place_id) REFERENCES places(place_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== FOLLOWERS =====
CREATE TABLE IF NOT EXISTS followers (
  follower_user_id INT NOT NULL,
  followed_user_id INT NOT NULL,
  PRIMARY KEY (follower_user_id, followed_user_id),
  FOREIGN KEY (follower_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (followed_user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== USER PHOTOS =====
CREATE TABLE IF NOT EXISTS user_photos (
  photo_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  image_url VARCHAR(500) NOT NULL,
  uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== INDEXES =====
CREATE INDEX idx_cities_country ON cities(country_id);
CREATE INDEX idx_places_city ON places(city_id);
CREATE INDEX idx_places_category ON places(category_id);
CREATE INDEX idx_place_photos_place ON place_photos(place_id);
CREATE INDEX idx_trips_user ON trips(user_id);
CREATE INDEX idx_trip_days_trip ON trip_days(trip_id);
CREATE INDEX idx_trip_activities_day ON trip_activities(day_id);
CREATE INDEX idx_journals_user ON journals(user_id);
CREATE INDEX idx_journal_pages_journal ON journal_pages(journal_id);
CREATE INDEX idx_journal_elements_page ON journal_elements(page_id);
CREATE INDEX idx_wishlist_user ON wishlist(user_id);
CREATE INDEX idx_visited_places_user ON visited_places(user_id);
CREATE INDEX idx_ratings_user ON ratings(user_id);
CREATE INDEX idx_user_photos_user ON user_photos(user_id);

-- ===== SEED DATA: Place Categories (required before places) =====
INSERT INTO place_categories (name, icon, marker_color) VALUES
('Historical Sights', 'landmark', '#E74C3C'),
('For the Art Lovers', 'palette', '#8E44AD'),
('Atmosphere & experience', 'heart', '#2ECC71'),
('Hidden Gems', 'star', '#F39C12'),
('Close by', 'map-pin', '#3498DB');
