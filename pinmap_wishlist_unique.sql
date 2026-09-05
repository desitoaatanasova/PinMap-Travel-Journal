USE pinmap;
-- Idempotency for wishlist: one entry per user per place/country. MySQL allows multiple NULLs in UNIQUE, so separate uniques work.
ALTER TABLE wishlist ADD UNIQUE KEY uq_wishlist_user_place (user_id, place_id);
ALTER TABLE wishlist ADD UNIQUE KEY uq_wishlist_user_country (user_id, country_id);
