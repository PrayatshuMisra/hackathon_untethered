@echo off
setlocal enabledelayedexpansion

REM Set a clean PATH with only what we need
set PATH=C:\Windows\System32;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\bin;C:\flutter\bin

REM Verify Git is accessible
echo Verifying Git...
where git
if errorlevel 1 (
    echo Error: Git not found in PATH
    echo Current PATH: %PATH%
    pause
    exit /b 1
)

REM Run Flutter with debug logging
echo.
echo Running Flutter doctor...
set FLUTTER_VERBOSE_LOGGING=true
set VERBOSE_SCRIPT_LOGGING=true

C:\flutter\bin\flutter.bat doctor -v 2>&1 | findstr /v "^\s*$"

if errorlevel 1 (
    echo.
    echo === Error Details ===
    echo Last Error Level: !errorlevel!
    echo.
    echo Git Version:
    git --version
    echo.
    echo Flutter Version:
    C:\flutter\bin\flutter.bat --version
)

pause
