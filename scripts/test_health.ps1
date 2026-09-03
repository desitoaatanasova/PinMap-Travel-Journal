Measure-Command {
  try { Invoke-WebRequest -Uri http://localhost:3001/api/health -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop | Out-Null; Write-Host "success" }
  catch { Write-Host "failed $_" }
} | Select-Object TotalSeconds | Format-List
Write-Host "done"
