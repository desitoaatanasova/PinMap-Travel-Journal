$sql = @"
SHOW VARIABLES LIKE 'character_set%';
SHOW VARIABLES LIKE 'collation%';
SHOW CREATE DATABASE pinmap;
SHOW TABLE STATUS FROM pinmap WHERE Name IN ('places','cities','countries','trip_activities')\G
SHOW FULL COLUMNS FROM pinmap.places WHERE Field IN ('name','short_description');
SHOW FULL COLUMNS FROM pinmap.cities WHERE Field = 'name';
"@
Set-Content -Path "$env:TEMP\check_charset.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\check_charset.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot 2>&1 | Select-String -NotMatch 'Warning'
