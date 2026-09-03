$sql = "SELECT p.name FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id WHERE c.name='Nuremberg' ORDER BY p.name;"
Set-Content -Path "$env:TEMP\allnbg.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\allnbg.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
