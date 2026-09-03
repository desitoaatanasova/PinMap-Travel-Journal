for ($i=0; $i -lt 60; $i+=2) {
  try {
    $r = Invoke-WebRequest -UseBasicParsing http://localhost:3001/api/health -TimeoutSec 2 -ErrorAction Stop
    if ($r.StatusCode -eq 200) {
      Write-Host "[CHECK] Backend healthy after ${i}s: $($r.Content)"
      break
    }
  } catch {
    Write-Host "[CHECK] Waiting backend... ${i}s"
  }
  Start-Sleep -Seconds 2
}
Write-Host "--- backend log tail ---"
Get-Content 'C:\Users\User\Desktop\Desi\App\backend_server.log' -Tail 20 -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "[BACKEND LOG] $_" }
Get-Content 'C:\Users\User\Desktop\Desi\App\backend_server_err.log' -Tail 20 -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "[BACKEND ERR] $_" }
Write-Host "--- flutter log tail ---"
Get-Content 'C:\Users\User\Desktop\Desi\App\flutter_run.log' -Tail 30 -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "[FLUTTER LOG] $_" }
Get-Content 'C:\Users\User\Desktop\Desi\App\flutter_run_err.log' -Tail 30 -ErrorAction SilentlyContinue | ForEach-Object { Write-Host "[FLUTTER ERR] $_" }
Get-Process node,flutter,dart -ErrorAction SilentlyContinue | Format-Table
