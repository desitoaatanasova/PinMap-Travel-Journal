$sql = "SELECT place_id, name FROM pinmap.places WHERE name LIKE '%?%' OR name LIKE '%Ã%';"
Set-Content -Path "$env:TEMP\corr.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\corr.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 pinmap 2>&1 | Select-String -NotMatch 'Warning'
