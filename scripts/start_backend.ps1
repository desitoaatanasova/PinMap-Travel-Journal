$BackendDir = "C:\Users\User\Desktop\Desi\App\backend"
$Log = "C:\Users\User\Desktop\Desi\App\backend_server.log"
$ErrLog = "C:\Users\User\Desktop\Desi\App\backend_server_err.log"
if (Test-Path $Log) { Remove-Item $Log -Force }
if (Test-Path $ErrLog) { Remove-Item $ErrLog -Force }
$p = Start-Process -FilePath "node" -ArgumentList "--watch server.js" -WorkingDirectory $BackendDir -RedirectStandardOutput $Log -RedirectStandardError $ErrLog -WindowStyle Hidden -PassThru
$p.Id | Out-File "C:\Users\User\Desktop\Desi\App\.backend.pid" -Force
Write-Host "Backend PID $($p.Id)"
Start-Sleep -Seconds 3
Get-Content $Log -Tail 20 | ForEach-Object { Write-Host "[LOG] $_" }
Test-NetConnection 127.0.0.1 -Port 3001 | Select-Object TcpTestSucceeded
try { Invoke-WebRequest -UseBasicParsing http://localhost:3001/api/health -TimeoutSec 5 | Select-Object StatusCode, Content } catch { Write-Host "health failed $_" }
