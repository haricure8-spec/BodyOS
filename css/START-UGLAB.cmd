@echo off
setlocal
title UGLAB_USB_3588
cd /d "%~dp0"

echo ========================================
echo UGLAB USB 3588 START
echo ========================================
echo.

where node >nul 2>nul
if errorlevel 1 (
  echo ERROR: Node.js was not found.
  echo Install Node.js, then run this file again.
  echo.
  pause
  exit /b 1
)

if not exist "server.js" (
  echo ERROR: server.js was not found.
  echo Run this file inside the UGLAB folder.
  echo.
  pause
  exit /b 1
)

if not exist "node_modules\qrcode" (
  echo ERROR: node_modules is incomplete.
  echo Re-extract the ZIP file and try again.
  echo.
  pause
  exit /b 1
)

if not exist "UGLAB_DATA" mkdir "UGLAB_DATA"
if not exist "UGLAB_DATA\Backup" mkdir "UGLAB_DATA\Backup"

set PORT=3588
set BODYOS_DATA_DIR=%~dp0UGLAB_DATA

start "" cmd /c "ping 127.0.0.1 -n 3 >nul & start http://localhost:3588/"

echo Server: http://localhost:3588/
echo Data:   %BODYOS_DATA_DIR%
echo.
echo Keep this window open while using UGLAB.
echo Close UGLAB with STOP-UGLAB.cmd before removing the USB drive.
echo.

node server.js

echo.
echo UGLAB stopped or failed to start.
pause
endlocal
