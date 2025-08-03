@echo off
setlocal enabledelayedexpansion

REM Set a clean PATH with only what we need
set PATH=C:\Windows\System32;C:\Windows\System32\WindowsPowerShell\v1.0;C:\Program Files\Git\bin;C:\flutter\bin

echo Building APK for Untethered AI...
echo.

echo Step 1: Cleaning previous builds...
C:\flutter\bin\flutter.bat clean

echo.
echo Step 2: Getting dependencies...
C:\flutter\bin\flutter.bat pub get

echo.
echo Step 3: Building APK...
C:\flutter\bin\flutter.bat build apk --release

echo.
echo APK build complete!
echo The APK file should be located at: build\app\outputs\flutter-apk\app-release.apk
echo.
echo You can now install this APK on your Android phone for hackathon submission!

pause 