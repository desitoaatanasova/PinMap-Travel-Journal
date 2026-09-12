-- Journal visibility for POST to Profile (Issue #9 Phase 4)
-- Minimal: adds visibility with safe default 'private'
USE pinmap;

SET @has_col := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'journals' AND COLUMN_NAME = 'visibility'
);
SET @ddl := IF(@has_col = 0,
  'ALTER TABLE journals ADD COLUMN visibility ENUM(''private'',''public'') NOT NULL DEFAULT ''private'' AFTER cover_image',
  'SELECT 1'
);
PREPARE s FROM @ddl; EXECUTE s; DEALLOCATE PREPARE s;

SET @has_idx := (
  SELECT COUNT(*) FROM information_schema.STATISTICS
  WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'journals' AND INDEX_NAME = 'idx_journals_user_visibility'
);
SET @idx_ddl := IF(@has_idx = 0,
  'CREATE INDEX idx_journals_user_visibility ON journals(user_id, visibility)',
  'SELECT 1'
);
PREPARE s2 FROM @idx_ddl; EXECUTE s2; DEALLOCATE PREPARE s2;
