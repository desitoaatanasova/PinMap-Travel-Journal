$AppRoot = $PSScriptRoot
$BackendPidFile = Join-Path $AppRoot ".backend.pid"
$FlutterPidFile = Join-Path $AppRoot ".flutter.pid"

function L($tag,$msg){ Write-Host "[$tag] $msg" -ForegroundColor Cyan }
function LE($tag,$msg){ Write-Host "[$tag] $msg" -ForegroundColor Red }

L "STOP" "Stopping PinMap dev processes..."

$stopped = 0

foreach ($pf in @($BackendPidFile, $FlutterPidFile)) {
  if (Test-Path $pf) {
    $pidVal = (Get-Content $pf -Raw -ErrorAction SilentlyContinue).Trim()
    if ($pidVal -match "^\d+$") {
      $proc = Get-Process -Id $pidVal -ErrorAction SilentlyContinue
      if ($proc) {
        L "STOP" "Stopping PID $pidVal ($($proc.ProcessName)) from $pf"
        try {
          Stop-Process -Id $pidVal -Force -ErrorAction Stop
          $stopped++
          L "STOP" "Stopped PID $pidVal"
        } catch { LE "STOP" "Failed to stop PID ${pidVal}: $_" }
        Start-Sleep -Milliseconds 500
        $tree = Get-CimInstance Win32_Process -Filter "ParentProcessId=$pidVal" -ErrorAction SilentlyContinue
        foreach ($child in $tree) {
          try { Stop-Process -Id $child.ProcessId -Force -ErrorAction SilentlyContinue; L "STOP" "Stopped child PID $($child.ProcessId) ($($child.Name))" } catch {}
        }
      } else { L "STOP" "PID $pidVal from $pf already exited." }
    }
    Remove-Item $pf -Force -ErrorAction SilentlyContinue
  }
}

$nodes = Get-CimInstance Win32_Process -Filter "Name='node.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*server.js*" -and $_.CommandLine -like "*backend*" }
foreach ($n in $nodes) {
  L "STOP" "Found backend node PID $($n.ProcessId): $($n.CommandLine)"
  try { Stop-Process -Id $n.ProcessId -Force -ErrorAction SilentlyContinue; L "STOP" "Stopped node PID $($n.ProcessId)"; $stopped++ } catch {}
}

$flutters = Get-Process -Name "flutter" -ErrorAction SilentlyContinue
foreach ($f in $flutters) { L "STOP" "Found flutter PID $($f.Id) - stopping"; try { Stop-Process -Id $f.Id -Force -ErrorAction SilentlyContinue; $stopped++ } catch {} }

$darts = Get-CimInstance Win32_Process -Filter "Name='dart.exe'" -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -like "*flutter*" }
foreach ($d in $darts) { L "STOP" "Found dart/flutter PID $($d.ProcessId)"; try { Stop-Process -Id $d.ProcessId -Force -ErrorAction SilentlyContinue; $stopped++ } catch {} }

if ($stopped -eq 0) { L "STOP" "No dev processes found to stop. (Backend may already be stopped, check port 3001 with: netstat -ano | findstr :3001)" }
else { L "STOP" "Stopped $stopped process(es)." }
L "STOP" "MySQL was left running (as required - data preserved). Stop it manually via Services if needed."
L "STOP" "Done."
