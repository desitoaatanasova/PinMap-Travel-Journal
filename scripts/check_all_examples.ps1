$sql = @"
SELECT p.name FROM pinmap.places p WHERE p.name = 'Schöner Brunnen';
SELECT p.name FROM pinmap.places p WHERE p.name = 'Fürstenzug';
SELECT p.name FROM pinmap.places p WHERE p.name = 'Brühl''s Terrace';
SELECT p.name FROM pinmap.places p WHERE p.name = 'Tiergärtnertorplatz';
SELECT COUNT(*) as total_places FROM pinmap.places;
SELECT COUNT(*) as german_places FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id JOIN pinmap.countries ct ON c.country_id=ct.country_id WHERE ct.name='Germany';
"@
Set-Content -Path "$env:TEMP\all_examples.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\all_examples.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
