@echo off
echo Setting up environment...
set PATH=C:\Program Files\Git\cmd;C:\flutter\bin;%PATH%
set GIT_EXEC_PATH=C:\Program Files\Git\cmd\git.exe

echo Testing git...
"C:\Program Files\Git\cmd\git.exe" --version

echo Running Flutter app...
C:\flutter\bin\flutter.bat run -d web-server --web-port 8080

pause 