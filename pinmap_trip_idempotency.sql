USE pinmap;
ALTER TABLE trips ADD COLUMN client_id VARCHAR(64) DEFAULT NULL AFTER trip_id;
ALTER TABLE trips ADD UNIQUE KEY uq_trips_user_client (user_id, client_id);
CREATE INDEX idx_trips_client ON trips(client_id);
