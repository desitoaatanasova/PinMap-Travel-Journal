# PinMap Travel Journal

## Standard Import Pipeline

**ALL future countries, cities, places, names, and descriptions MUST use:**

```
node scripts/import_places.js --source "<source-file>" --country "<country>"
```

Example:
```
node scripts/import_places.js --source "C:\Temp\docx_read\data.xml" --country "Germany"
node scripts/import_places.js --source "C:\Temp\docx_read\data.xml" --country "Japan, South Korea"
```

This is the **ONLY approved** pipeline. It includes:
- explicit UTF-8 read/write (`fs.readFileSync(...,'utf8')` / `writeFileSync(...,'utf8')`)
- `SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci` and `pool charset: utf8mb4`
- pre-import validation (rejects `???` runs and mojibake `Ã/Â/â€™/â€œ/â—`)
- duplicate prevention (`WHERE NOT EXISTS city_id+name`)
- transactional `BEGIN → INSERT → post-import HEX verification → COMMIT/ROLLBACK`

Do NOT use legacy scripts (`generate_sql.js`, `fix_sql.js`, `parse_doc*.js`, `reinsert.ps1`, `source_insert.ps1`) — they are deprecated and fail-fast with a redirect message.

## Validation

- `node scripts/test_import_unicode.js` — end-to-end test for `Schöner Brunnen`…`❤️` 18 strings through file→MySQL→API→Flutter
- `node scripts/test_rollback.js` — confirms corrupted `???` is rejected and no rows remain

## Development Launch

```
.\dev.bat
# or
powershell -ExecutionPolicy Bypass -File dev.ps1
```
Stop: `.\stop-dev.bat` or `powershell -ExecutionPolicy Bypass -File stop-dev.ps1`

Stack: MySQL 3306 (reuse existing), Express `http://localhost:3001` (`GET /api/health`), Flutter `run -d chrome` (hot reload).

## Database

`pinmap` is `utf8mb4_unicode_ci` on all text columns (verified 51 columns). Do not `ALTER/DROP/recreate`.

## Active Scripts

- **Standard:** `scripts/import_places.js`
- **Tests:** `scripts/test_import_unicode.js`, `scripts/test_rollback.js`
- **Repair/verification (when needed):** `check_*.ps1`, `verify_*.ps1`, `backend/repair_39.js`

Legacy import/generation scripts are deprecated and exit with an error directing to the standard command.
