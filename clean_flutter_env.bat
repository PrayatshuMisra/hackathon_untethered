@echo off
REM Set minimal PATH with just system paths and Git
set PATH=C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Git\cmd;C:\Program Files\Git\bin

REM Verify Git
echo Verifying Git...
git --version

REM Run Flutter
echo.
echo Running Flutter doctor...
flutter doctor -v

pause
