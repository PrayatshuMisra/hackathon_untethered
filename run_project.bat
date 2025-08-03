@echo off
echo Setting up environment for Flutter project...

REM Set up git path
set PATH=C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\bin;%PATH%

REM Set Flutter environment variables
set FLUTTER_ROOT=%~dp0flutter
set PATH=%FLUTTER_ROOT%\bin;%PATH%

REM Verify git is accessible
echo Checking git...
git --version
if %ERRORLEVEL% NEQ 0 (
    echo Error: Git not found in PATH
    pause
    exit /b 1
)

REM Try to run Flutter
echo Running Flutter project...
flutter run -d web-server --web-port 8080

pause 