$ErrorActionPreference = "Continue"
$AppRoot = $PSScriptRoot
$BackendDir = Join-Path $AppRoot "backend"
$FlutterDir = Join-Path $AppRoot "travel_journal_app"
$FlutterBin = "C:\Users\User\dev\flutter\bin\flutter.bat"
$BackendPort = 3001
$BackendHealthUrl = "http://localhost:$BackendPort/api/health"
$LogDir = $AppRoot
$BackendLog = Join-Path $LogDir "backend_server.log"
$BackendErrLog = Join-Path $LogDir "backend_server_err.log"
$FlutterLog = Join-Path $LogDir "flutter_run.log"
$FlutterErrLog = Join-Path $LogDir "flutter_run_err.log"
$BackendPidFile = Join-Path $LogDir ".backend.pid"
$FlutterPidFile = Join-Path $LogDir ".flutter.pid"

function L($tag, $msg) { Write-Host "[$tag] $msg" -ForegroundColor Cyan }
function LE($tag, $msg) { Write-Host "[$tag] $msg" -ForegroundColor Red }
function LI($tag, $msg) { Write-Host "[$tag] $msg" }

if (-not (Test-Path $FlutterBin)) {
  $alt = Join-Path $env:FLUTTER_HOME "bin\flutter.bat"
  if (Test-Path $alt) { $FlutterBin = $alt }
}
if (-not (Test-Path $FlutterBin)) {
  $found = Get-Command flutter -ErrorAction SilentlyContinue
  if ($found) { $FlutterBin = $found.Source }
}
if (-not (Test-Path $FlutterBin) -and -not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  if (Test-Path "C:\Users\User\dev\flutter\bin\flutter.bat") { $FlutterBin = "C:\Users\User\dev\flutter\bin\flutter.bat" }
}

L "LAUNCH" "PinMap dev launcher"
L "LAUNCH" "App root: $AppRoot"
L "LAUNCH" "Flutter: $FlutterBin"
L "LAUNCH" "Backend health: $BackendHealthUrl"

L "MYSQL" "Checking MySQL on localhost:3306 ..."
$mysqlOk = $false
try {
  $tcp = Test-NetConnection -ComputerName 127.0.0.1 -Port 3306 -WarningAction SilentlyContinue
  $mysqlOk = $tcp.TcpTestSucceeded
} catch { $mysqlOk = $false }

if ($mysqlOk) {
  LI "MYSQL" "MySQL is reachable on port 3306 (reusing existing instance)."
} else {
  L "MYSQL" "MySQL not reachable. Trying to start system service..."
  $services = @("MySQL80","MySQL","mysql","MySQL57","MySQL84")
  $started = $false
  foreach ($svc in $services) {
    $s = Get-Service -Name $svc -ErrorAction SilentlyContinue
    if ($s) {
      LI "MYSQL" "Found service $svc (status: $($s.Status)). Starting if needed..."
      try {
        if ($s.Status -ne "Running") { Start-Service -Name $svc -ErrorAction Stop; LI "MYSQL" "Service $svc started." }
        $started = $true
        break
      } catch { LE "MYSQL" "Failed to start ${svc}: $_" }
    }
  }
  if (-not $started) {
    LE "MYSQL" "No MySQL service found or could not start. Checking mysqld process..."
    $mysqld = Get-Process mysqld -ErrorAction SilentlyContinue
    if ($mysqld) { LI "MYSQL" "mysqld process found (PID $($mysqld.Id)). Waiting for port 3306..." }
    else {
      LE "MYSQL" "MySQL is not reachable and no service/process found."
      LE "MYSQL" "Please start MySQL manually (e.g. MySQL Installer, XAMPP, or 'net start MySQL80') then re-run this script."
      exit 1
    }
  }
  L "MYSQL" "Waiting for MySQL to become reachable (no timeout)..."
  while ($true) {
    try {
      $tcp = Test-NetConnection -ComputerName 127.0.0.1 -Port 3306 -WarningAction SilentlyContinue
      if ($tcp.TcpTestSucceeded) { LI "MYSQL" "MySQL is now reachable."; break }
    } catch {}
    LI "MYSQL" "Still waiting for MySQL on 3306..."
    Start-Sleep -Seconds 2
  }
}

function Test-BackendHealth {
  try {
    $r = Invoke-WebRequest -Uri $BackendHealthUrl -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
    return $r.StatusCode -eq 200
  } catch { return $false }
}

L "BACKEND" "Checking if backend is already running..."
$backendHealthy = Test-BackendHealth
$backendProcess = $null

if ($backendHealthy) {
  LI "BACKEND" "Backend already healthy at $BackendHealthUrl (reusing existing instance)."
} else {
  $portInUse = $false
  try { $c = Test-NetConnection -ComputerName 127.0.0.1 -Port $BackendPort -WarningAction SilentlyContinue; $portInUse = $c.TcpTestSucceeded } catch {}
  if ($portInUse) {
    LE "BACKEND" "Port $BackendPort is occupied but health check failed."
    LE "BACKEND" "Another process may be using the port. Check with: netstat -ano | findstr :$BackendPort"
    LE "BACKEND" "Stop the conflicting process or free the port, then re-run."
    exit 1
  }

  if (-not (Test-Path (Join-Path $BackendDir "server.js"))) { LE "BACKEND" "Backend server.js not found in $BackendDir"; exit 1 }
  if (-not (Test-Path (Join-Path $BackendDir "package.json"))) { LE "BACKEND" "Backend package.json not found in $BackendDir"; exit 1 }

  L "BACKEND" "Starting Express backend (node server.js) ..."
  if (Test-Path $BackendLog) { Remove-Item $BackendLog -Force -ErrorAction SilentlyContinue }
  if (Test-Path $BackendErrLog) { Remove-Item $BackendErrLog -Force -ErrorAction SilentlyContinue }

  $backendArgs = "server.js"
  $backendProcess = Start-Process -FilePath "node" -ArgumentList $backendArgs -WorkingDirectory $BackendDir -RedirectStandardOutput $BackendLog -RedirectStandardError $BackendErrLog -WindowStyle Hidden -PassThru
  if ($backendProcess) {
    $backendProcess.Id | Out-File $BackendPidFile -Force
    LI "BACKEND" "Backend PID $($backendProcess.Id) started. Logs: $BackendLog"
  } else {
    LE "BACKEND" "Failed to start backend process."
    exit 1
  }

  L "BACKEND" "Waiting for backend to become healthy at $BackendHealthUrl (no timeout)..."
  $dots = 0
  while ($true) {
    if (Test-BackendHealth) { LI "BACKEND" "Backend is healthy!"; break }
    if ($backendProcess -and $backendProcess.HasExited) {
      LE "BACKEND" "Backend process exited unexpectedly (exit code $($backendProcess.ExitCode))."
      LE "BACKEND" "Check logs: $BackendLog and $BackendErrLog"
      if (Test-Path $BackendErrLog) { Get-Content $BackendErrLog -Tail 50 | ForEach-Object { LE "BACKEND" $_ } }
      if (Test-Path $BackendLog) { Get-Content $BackendLog -Tail 50 | ForEach-Object { LI "BACKEND" $_ } }
      exit 1
    }
    $dots = ($dots + 1) % 4
    $indicator = "." * $dots
    Write-Host "[BACKEND] Waiting for health check$indicator   `r" -NoNewline
    Start-Sleep -Seconds 1
  }
  Write-Host ""
}

L "BACKEND" "Backend verified at $BackendHealthUrl"

if (-not (Test-Path (Join-Path $FlutterDir "pubspec.yaml"))) { LE "FLUTTER" "pubspec.yaml not found in $FlutterDir"; exit 1 }

$flutterAlreadyRunning = $false
try {
  $flutterProcs = Get-Process -Name "flutter" -ErrorAction SilentlyContinue
  if ($flutterProcs) {
    LI "FLUTTER" "Existing flutter process detected. Will still launch flutter run (reuse if healthy)."
  }
} catch {}

L "FLUTTER" "Starting Flutter web in Chrome (hot reload enabled)..."
L "FLUTTER" "Command: $FlutterBin run -d chrome --web-port 0"
L "FLUTTER" "This may take a minute on first run. No timeout - waiting as long as needed."
L "FLUTTER" "Logs: $FlutterLog"

if (Test-Path $FlutterLog) { Remove-Item $FlutterLog -Force -ErrorAction SilentlyContinue }
if (Test-Path $FlutterErrLog) { Remove-Item $FlutterErrLog -Force -ErrorAction SilentlyContinue }

$flutterArgs = "run -d chrome"
$flutterProcess = Start-Process -FilePath $FlutterBin -ArgumentList $flutterArgs -WorkingDirectory $FlutterDir -RedirectStandardOutput $FlutterLog -RedirectStandardError $FlutterErrLog -WindowStyle Hidden -PassThru
if ($flutterProcess) {
  $flutterProcess.Id | Out-File $FlutterPidFile -Force
  LI "FLUTTER" "Flutter PID $($flutterProcess.Id) started."
} else {
  LE "FLUTTER" "Failed to start Flutter process."
  exit 1
}

L "FLUTTER" "Waiting for Flutter to compile and open Chrome (no timeout)..."
L "FLUTTER" "Watching log for success signal..."

$flutterReady = $false
$startTime = Get-Date
while ($true) {
  if ($flutterProcess.HasExited) {
    LE "FLUTTER" "Flutter process exited unexpectedly (code $($flutterProcess.ExitCode))."
    if (Test-Path $FlutterErrLog) { Get-Content $FlutterErrLog -Tail 80 | ForEach-Object { LE "FLUTTER" $_ } }
    if (Test-Path $FlutterLog) { Get-Content $FlutterLog -Tail 80 | ForEach-Object { LI "FLUTTER" $_ } }
    LE "FLUTTER" "Chrome could not be launched or Flutter build failed. See logs above."
    exit 1
  }
  if (Test-Path $FlutterLog) {
    $content = Get-Content $FlutterLog -Raw -ErrorAction SilentlyContinue
    if ($content -and ($content -match "Flutter run key commands" -or $content -match "lib/main" -or $content -match "Serving.*web" -or $content -match "Debug service listening" -or $content -match "localhost:")) {
      $flutterReady = $true
      break
    }
  }
  $elapsed = [int]((Get-Date) - $startTime).TotalSeconds
  Write-Host "[FLUTTER] Compiling... ${elapsed}s elapsed (still waiting, no timeout)   `r" -NoNewline
  Start-Sleep -Seconds 2
  if ($elapsed -gt 0 -and ($elapsed % 30 -eq 0)) {
    Write-Host ""
    LI "FLUTTER" "Still compiling after ${elapsed}s. This is normal on first run."
    if (Test-Path $FlutterLog) { Get-Content $FlutterLog -Tail 5 | ForEach-Object { LI "FLUTTER" $_ } }
  }
}
Write-Host ""
LI "FLUTTER" "Flutter is running!"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Application ready!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
LI "LAUNCH" "MySQL   : localhost:3306 (running)"
LI "LAUNCH" "Backend : http://localhost:$BackendPort  (health: $BackendHealthUrl)"
LI "LAUNCH" "Frontend: Flutter web opening in Chrome (check Chrome window)"
LI "LAUNCH" "Logs    :"
LI "LAUNCH" "  Backend stdout : $BackendLog"
LI "LAUNCH" "  Backend stderr : $BackendErrLog"
LI "LAUNCH" "  Flutter stdout : $FlutterLog"
LI "LAUNCH" "  Flutter stderr : $FlutterErrLog"
Write-Host ""
LI "LAUNCH" "Keep this window open. Press Ctrl+C to view stop instructions (processes keep running)."
LI "LAUNCH" "To stop:  powershell -ExecutionPolicy Bypass -File `"$AppRoot\stop-dev.ps1`""
LI "LAUNCH" "   or:    .\stop-dev.ps1"
Write-Host ""

L "LAUNCH" "Tailing logs (Ctrl+C to stop tailing, app keeps running)..."
Write-Host ""

$lastBackendLines = 0
$lastFlutterLines = 0
try {
  while ($true) {
    if (Test-Path $BackendLog) {
      $lines = (Get-Content $BackendLog -ErrorAction SilentlyContinue)
      if ($lines -and $lines.Count -gt $lastBackendLines) {
        $new = $lines | Select-Object -Skip $lastBackendLines
        foreach ($l in $new) { if ($l.Trim() -ne "") { Write-Host "[BACKEND] $l" } }
        $lastBackendLines = $lines.Count
      }
    }
    if (Test-Path $FlutterLog) {
      $lines = (Get-Content $FlutterLog -ErrorAction SilentlyContinue)
      if ($lines -and $lines.Count -gt $lastFlutterLines) {
        $new = $lines | Select-Object -Skip $lastFlutterLines
        foreach ($l in $new) { if ($l.Trim() -ne "") { Write-Host "[FLUTTER] $l" } }
        $lastFlutterLines = $lines.Count
      }
    }
    if ($backendProcess -and $backendProcess.HasExited) {
      LE "BACKEND" "Backend process died! Exit code $($backendProcess.ExitCode)"
      LE "BACKEND" "Restart with: powershell -ExecutionPolicy Bypass -File `"$AppRoot\dev.ps1`""
    }
    if ($flutterProcess -and $flutterProcess.HasExited) {
      LE "FLUTTER" "Flutter process died! Exit code $($flutterProcess.ExitCode)"
    }
    Start-Sleep -Milliseconds 500
  }
} finally {
  Write-Host ""
  L "LAUNCH" "Log tail stopped. Application is STILL RUNNING in background."
  L "LAUNCH" "Backend PID: $($backendProcess.Id)  Flutter PID: $($flutterProcess.Id)"
  L "LAUNCH" "To stop all: powershell -ExecutionPolicy Bypass -File `"$AppRoot\stop-dev.ps1`""
}
