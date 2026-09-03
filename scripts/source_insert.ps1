Write-Error 'DEPRECATED: source_insert.ps1 is retired. Use: node scripts/import_places.js --source "<source-file>" --country "<country>"'; exit 1
$sql = "source C:/Users/User/Desktop/Desi/App/pinmap_germany_switzerland.sql"
Set-Content -Path "$env:TEMP\source.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\source.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 pinmap 2>&1 | Select-String -NotMatch 'Warning'
Write-Host "source done"
$sql2 = "SELECT p.name FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id WHERE c.name='Nuremberg' ORDER BY p.name;"
Set-Content -Path "$env:TEMP\verify2.sql" -Value $sql2 -Encoding utf8
Get-Content "$env:TEMP\verify2.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
