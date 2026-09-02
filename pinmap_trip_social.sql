-- PinMap Trip Planning + Social migration
-- Adds: trip cities, arrival/departure city, trip participants, profile photo upload support

USE pinmap;

-- ===== TRIPS: arrival / departure cities =====
ALTER TABLE trips
  ADD COLUMN arrival_city VARCHAR(100) DEFAULT NULL AFTER number_of_days,
  ADD COLUMN departure_city VARCHAR(100) DEFAULT NULL AFTER arrival_city;

-- ===== TRIP CITIES (selected cities to visit) =====
CREATE TABLE IF NOT EXISTS trip_cities (
  trip_id INT UNSIGNED NOT NULL,
  city_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (trip_id, city_id),
  FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE,
  FOREIGN KEY (city_id) REFERENCES cities(city_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===== TRIP PARTICIPANTS (group vacations) =====
CREATE TABLE IF NOT EXISTS trip_participants (
  trip_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (trip_id, user_id),
  FOREIGN KEY (trip_id) REFERENCES trips(trip_id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE INDEX idx_trip_cities_city ON trip_cities(city_id);
CREATE INDEX idx_trip_participants_user ON trip_participants(user_id);
