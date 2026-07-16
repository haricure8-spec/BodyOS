@echo off
setlocal
title UGLAB_USB_3588_STOP

echo Stopping UGLAB on port 3588...
set "FOUND="
for /f "tokens=5" %%P in ('netstat -ano ^| findstr ":3588" ^| findstr "LISTENING"') do (
  set "FOUND=1"
  taskkill /PID %%P /F >nul 2>nul
)

if defined FOUND (
  echo UGLAB stopped.
) else (
  echo UGLAB was not running.
)

timeout /t 2 >nul
endlocal
