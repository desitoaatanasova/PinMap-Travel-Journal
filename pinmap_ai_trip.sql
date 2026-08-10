-- PinMap AI trip planner schema additions
-- Add number_of_days to trips (for AI-generated plans)
ALTER TABLE trips ADD COLUMN number_of_days INT UNSIGNED DEFAULT NULL AFTER travel_style;

-- Add order_index to trip_activities (AI plans order places within a time slot)
ALTER TABLE trip_activities ADD COLUMN order_index INT UNSIGNED DEFAULT 0 AFTER place_id;
