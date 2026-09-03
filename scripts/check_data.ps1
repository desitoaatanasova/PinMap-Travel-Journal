$sql = @"
SELECT place_id, name, HEX(name) as hexname FROM pinmap.places WHERE name LIKE '%Sch%' OR name LIKE '%Tierg%' OR name LIKE '%Fürst%' OR name LIKE '%Brühl%' OR name LIKE '%Ã%' LIMIT 20;
SELECT place_id, name FROM pinmap.places WHERE name LIKE '%Sch%ner%' OR name LIKE '%Br%hl%' LIMIT 10;
SELECT city_id, name, HEX(name) FROM pinmap.cities WHERE name LIKE '%Ã%' OR name LIKE '%ü%' LIMIT 10;
"@
Set-Content -Path "$env:TEMP\check_data.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\check_data.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
