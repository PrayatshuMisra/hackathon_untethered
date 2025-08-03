@echo off
setlocal enabledelayedexpansion

REM Set minimal PATH with Git and Flutter
set PATH=C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Git\cmd;C:\Program Files\Git\bin;C:\flutter\bin

echo === Environment ===
where git
echo.
where flutter

echo.
echo === Running Flutter with logging ===
set FLUTTER_VERBOSE_LOGGING=true
set VERBOSE_SCRIPT_LOGGING=true

flutter doctor -v 2>&1 | findstr /v "^\s*$"

if errorlevel 1 (
    echo.
    echo === Error Details ===
    echo Last Error Level: !errorlevel!
    echo.
    echo PATH: %PATH%
    echo.
    echo Git Version:
    git --version
    echo.
    echo Flutter Version:
    flutter --version
)

pause
