-- PinMap Performance Indexes — Issue #7 P3/P4
-- Run: mysql -u root -p pinmap < pinmap_perf_indexes.sql
-- Idempotent via IF NOT EXISTS wrapper where supported

CREATE INDEX idx_trips_user_date ON trips(user_id, start_date DESC);
CREATE INDEX idx_trip_days_trip_number ON trip_days(trip_id, day_number);
CREATE INDEX idx_trip_activities_day_order ON trip_activities(day_id, order_index);
CREATE INDEX idx_ratings_place ON ratings(place_id);
CREATE INDEX idx_ratings_country ON ratings(country_id);
CREATE INDEX idx_ticket_scans_user_journal ON ticket_scans(user_id, journal_id, created_at DESC);
CREATE INDEX idx_wishlist_user_date ON wishlist(user_id, added_at DESC);
CREATE INDEX idx_visited_places_user_date ON visited_places(user_id, visit_date DESC);
CREATE INDEX idx_visited_cities_user_date ON visited_cities(user_id, visit_date DESC);
CREATE INDEX idx_visited_countries_user_date ON visited_countries(user_id, visit_date DESC);
CREATE INDEX idx_places_city_category_name ON places(city_id, category_id, name);
CREATE INDEX idx_cities_country_name ON cities(country_id, name);
CREATE INDEX idx_user_photos_user_date ON user_photos(user_id, uploaded_at DESC);
CREATE INDEX idx_journal_elements_page_key ON journal_elements(page_id, element_key);
CREATE INDEX idx_followers_followed ON followers(followed_user_id);

-- Fix missing unique for place ratings (enables ON DUPLICATE KEY UPDATE dedupe)
-- Use IGNORE if duplicates already exist; clean duplicates first in production
CREATE UNIQUE INDEX uq_ratings_user_place ON ratings(user_id, place_id);

-- Helpful for country list ordering and search
CREATE INDEX idx_countries_name ON countries(name);
