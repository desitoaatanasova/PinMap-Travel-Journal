# AGENTS — PinMap Import & Encoding Rules

## ONLY Approved Import

```
node scripts/import_places.js --source "<source-file>" --country "<country>"
```

This applies to ALL future countries, cities, places, names, descriptions. No alternative encoding workflows per country.

## Deprecated (fail-fast)

- `scripts/generate_sql.js`
- `scripts/fix_sql.js`
- `scripts/parse_doc.js`, `scripts/parse_doc2.js`
- `scripts/reinsert.ps1`, `scripts/source_insert.ps1`

These exit with `DEPRECATED: use import_places.js` and are retained for historical reference only.

## Kept Runnable

- `scripts/import_places.js`
- `scripts/test_import_unicode.js`
- `scripts/test_rollback.js`
- `scripts/check_*.ps1`, `verify_*.ps1`, `backend/repair_39.js` (repair/verification when needed)

## Pipeline Guarantees

- UTF-8 explicitly on read/write, SQL `utf8` file, MySQL `utf8mb4` (`SET NAMES`, pool `charset:utf8mb4`)
- No dependency on `cp850/cp1252/latin1` system encoding
- Pre-import: rejects `???` runs (not single `?`) and mojibake `Ã/Â/â€™/â€œ/â—`
- Transaction: `BEGIN → INSERT → post HEX check → COMMIT` else `ROLLBACK`
- Idempotent: `WHERE NOT EXISTS (city_id+name)` prevents duplicates; parsed 156 → 0 inserted if exists

## Validation

Run after implementation:
```
node scripts/test_import_unicode.js  # 18 strings Schöner … ❤️ must pass all stages
node scripts/test_rollback.js        # corrupted must not persist
```

Fail = import stops before commit, error reports `source/country/city/place/field/pattern`.

## DB

`pinmap` `utf8mb4_unicode_ci` verified; 39 corrupted `short_description` repaired from canonical `pinmap_germany_switzerland.sql` (now correct `E28099`/`C3A9`). No structure changes.

## Launch

`dev.bat` reuses MySQL, waits `GET /api/health`, then `flutter run -d chrome` (no timeout, tail forever). Stop `stop-dev.bat`.
