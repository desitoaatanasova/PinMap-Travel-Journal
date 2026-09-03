Write-Error 'DEPRECATED: reinsert.ps1 is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"'; exit 1
Get-Content -Encoding utf8 'C:\Users\User\Desktop\Desi\App\pinmap_germany_switzerland.sql' | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
Write-Host "reinsert done"
$sql = "SELECT COUNT(*) as cnt FROM pinmap.places WHERE name LIKE '%Schöner%' OR name LIKE '%Brühl%' OR name LIKE '%Fürstenzug%'; SELECT place_id, name FROM pinmap.places WHERE name LIKE '%Schöner%' LIMIT 5;"
Set-Content -Path "$env:TEMP\verify.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\verify.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
