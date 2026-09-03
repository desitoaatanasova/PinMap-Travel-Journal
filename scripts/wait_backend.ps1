for ($i=0; $i -lt 30; $i++) {
  try {
    $r = Invoke-WebRequest -UseBasicParsing http://localhost:3001/api/health -TimeoutSec 2 -ErrorAction Stop
    if ($r.StatusCode -eq 200) { Write-Host "Backend healthy"; break }
  } catch { Write-Host "waiting $i" }
  Start-Sleep -Seconds 2
}
# test places API with auth needed? Let's test unauthenticated health and try to get places via direct DB query
# Instead test via direct mysql with correct charset
$sql = "SELECT p.name FROM pinmap.places p JOIN pinmap.cities c ON p.city_id=c.city_id WHERE c.name='Nuremberg' ORDER BY p.name LIMIT 5;"
Set-Content -Path "$env:TEMP\test.sql" -Value $sql -Encoding utf8
Get-Content "$env:TEMP\test.sql" | & 'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe' -u root -proot --default-character-set=utf8mb4 2>&1 | Select-String -NotMatch 'Warning'
