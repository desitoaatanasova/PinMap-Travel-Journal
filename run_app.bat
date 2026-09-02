@echo off
REM Legacy launcher - now delegates to the full stack dev launcher.
REM Use dev.bat for the complete MySQL + Backend + Flutter flow.
powershell -ExecutionPolicy Bypass -File "%~dp0dev.ps1" %*
