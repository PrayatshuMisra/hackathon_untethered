@echo off
echo === Untethered AI Flutter App Builder and Runner ===
echo.

echo Setting up environment...
set PATH=C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;C:\Windows\System32;C:\Windows;%PATH%
set FLUTTER_ROOT=C:\flutter

echo Navigating to project directory...
cd /d "D:\study\coding_prac\hackathon-ai"

echo.
echo Cleaning previous builds...
C:\flutter\bin\flutter.bat clean

echo.
echo Getting Flutter dependencies...
C:\flutter\bin\flutter.bat pub get

echo.
echo Building for web...
C:\flutter\bin\flutter.bat build web --release

echo.
echo Starting Flutter web server...
echo App will be available at: http://localhost:8080
echo Press Ctrl+C to stop the server
echo.
C:\flutter\bin\flutter.bat run -d web-server --web-port 8080 --release

echo.
echo App session ended.
pause 