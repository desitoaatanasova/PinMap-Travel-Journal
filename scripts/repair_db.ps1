$sql = @"
USE pinmap;
DELETE p FROM places p JOIN cities c ON p.city_id=c.city_id JOIN countries ct ON c.country_id=ct.country_id WHERE ct.name IN ('Germany','Switzerland') AND p.name LIKE '%?%';
SELECT ROW_COUNT() as deleted_corrupted;
"@
Set-Content -Path "$env:TEMP\repair1.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\repair1.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
Write-Host "deleted ? rows"

$sql2 = @"
USE pinmap;
SELECT place_id, name FROM places WHERE name LIKE '%?%' LIMIT 10;
"@
Set-Content -Path "$env:TEMP\repair2.sql" -Value $sql2 -Encoding utf8
Get-Content "$env:TEMP\repair2.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
