cmd /c start "" powershell -ExecutionPolicy Bypass -File "C:\Users\User\Desktop\Desi\App\dev.ps1"
Write-Host "Launched via cmd start"
Start-Sleep -Seconds 5
Get-Process powershell -ErrorAction SilentlyContinue | Select-Object Id,ProcessName | Format-Table
Get-Process node -ErrorAction SilentlyContinue | Select-Object Id,ProcessName | Format-Table
