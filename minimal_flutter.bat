@echo off
setlocal

REM Set minimal PATH
set PATH=C:\Windows\System32;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\bin;C:\flutter\bin

echo === Environment ===
echo PATH: %PATH%
echo.

echo === Git Check ===
where git
if errorlevel 1 (
    echo ERROR: Git not found in PATH
    exit /b 1
)

echo.
echo === Flutter Check ===
where flutter
if errorlevel 1 (
    echo ERROR: Flutter not found in PATH
    exit /b 1
)

echo.
echo === Running Flutter Doctor ===
C:\flutter\bin\flutter.bat doctor -v

if errorlevel 1 (
    echo.
    echo === Error Details ===
    echo Last Error Level: %ERRORLEVEL%
    echo.
    echo Git Version:
    git --version
    echo.
    echo Flutter Version:
    C:\flutter\bin\flutter.bat --version
)

pause
