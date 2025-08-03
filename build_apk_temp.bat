@echo off
echo Setting up environment for APK build...
set PATH=C:\Program Files\Git\cmd;C:\flutter\bin;%PATH%
set GIT_EXEC_PATH=C:\Program Files\Git\cmd\git.exe

echo Testing git...
"C:\Program Files\Git\cmd\git.exe" --version

echo Building APK...
C:\flutter\bin\flutter.bat build apk --release

echo APK build complete!
echo The APK file should be located at: build\app\outputs\flutter-apk\app-release.apk

pause 