$sql = "SELECT c.name, COUNT(p.place_id) as cnt FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id WHERE c.name='Nuremberg' GROUP BY c.name; SELECT p.name FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id WHERE c.name='Nuremberg' LIMIT 10;"
Set-Content -Path "$env:TEMP\nbg.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\nbg.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
