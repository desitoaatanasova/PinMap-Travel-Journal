-- PinMap updates v2
-- Visited cities/countries, ratings for countries, stable element keys, user settings.
-- Idempotent: safe to run multiple times. Matches the live (unsigned) schema.

USE pinmap;

-- ===== VISITED CITIES =====
CREATE TABLE IF NOT EXISTS visited_cities (
  user_id int unsigned NOT NULL,
  city_id smallint unsigned NOT NULL,
  visit_date date DEFAULT NULL,
  notes text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (user_id, city_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===== VISITED COUNTRIES =====
CREATE TABLE IF NOT EXISTS visited_countries (
  user_id int unsigned NOT NULL,
  country_id smallint unsigned NOT NULL,
  visit_date date DEFAULT NULL,
  notes text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (user_id, country_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_visited_cities_user ON visited_cities(user_id);
CREATE INDEX idx_visited_countries_user ON visited_countries(user_id);

-- ===== RATINGS: support countries + unique per user =====
SET @has_ratings_country := (SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'ratings' AND column_name = 'country_id');
SET @sql := IF(@has_ratings_country = 0,
  'ALTER TABLE ratings ADD COLUMN country_id smallint unsigned DEFAULT NULL AFTER place_id',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_place_nullable := (SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'ratings' AND column_name = 'place_id'
    AND is_nullable = 'YES');
SET @sql := IF(@has_place_nullable = 0,
  'ALTER TABLE ratings MODIFY place_id int unsigned NULL',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_uniq_country := (SELECT COUNT(*) FROM information_schema.statistics
  WHERE table_schema = DATABASE() AND table_name = 'ratings' AND index_name = 'uq_ratings_user_country');
SET @sql := IF(@has_uniq_country = 0,
  'ALTER TABLE ratings ADD UNIQUE KEY uq_ratings_user_country (user_id, country_id)', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_ratings_country_fk := (SELECT COUNT(*) FROM information_schema.table_constraints
  WHERE table_schema = DATABASE() AND table_name = 'ratings' AND constraint_name = 'fk_ratings_country');
SET @sql := IF(@has_ratings_country_fk = 0,
  'ALTER TABLE ratings ADD CONSTRAINT fk_ratings_country FOREIGN KEY (country_id) REFERENCES countries(country_id) ON DELETE CASCADE',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ===== JOURNAL ELEMENTS: stable client element key =====
SET @has_element_key := (SELECT COUNT(*) FROM information_schema.columns
  WHERE table_schema = DATABASE() AND table_name = 'journal_elements' AND column_name = 'element_key');
SET @sql := IF(@has_element_key = 0,
  'ALTER TABLE journal_elements ADD COLUMN element_key varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL',
  'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @has_el_key_idx := (SELECT COUNT(*) FROM information_schema.statistics
  WHERE table_schema = DATABASE() AND table_name = 'journal_elements' AND index_name = 'idx_journal_elements_key');
SET @sql := IF(@has_el_key_idx = 0,
  'ALTER TABLE journal_elements ADD INDEX idx_journal_elements_key (element_key)', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ===== USER SETTINGS =====
CREATE TABLE IF NOT EXISTS user_settings (
  user_id int unsigned NOT NULL,
  notifications_enabled tinyint(1) NOT NULL DEFAULT 1,
  offline_mode_enabled tinyint(1) NOT NULL DEFAULT 0,
  language varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'English',
  updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
