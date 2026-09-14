@echo off
set DB_HOST=localhost
set DB_PORT=3306
set DB_USER=root
set DB_PASSWORD=root
set DB_NAME=pinmap
set DB_CHARSET=utf8mb4
node scripts\test_import_unicode.js