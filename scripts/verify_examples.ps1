$sql = @"
SELECT name FROM pinmap.places WHERE name IN ('Schöner Brunnen','Tiergärtnertorplatz','Fürstenzug','Brühl''s Terrace','Königssee') OR name LIKE '%Schöner%' OR name LIKE '%Fürst%' OR name LIKE '%Brühl%';
SELECT '---' as sep;
SELECT name, HEX(name) FROM pinmap.places WHERE name = 'Schöner Brunnen';
SELECT name, HEX(name) FROM pinmap.places WHERE name = 'Fürstenzug';
"@
Set-Content -Path "$env:TEMP\ex.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\ex.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 pinmap 2>&1 | Select-String -NotMatch 'Warning'
