@echo off
REM Set minimal but complete PATH
set PATH=C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Git\cmd;C:\Program Files\Git\bin;C:\flutter\bin

echo === Environment ===
echo Current PATH:
echo %PATH%
echo.
echo Git version:
git --version
echo.
echo Flutter version:
flutter --version
echo.
echo Running Flutter doctor:
flutter doctor -v

pause
