@echo off
set PATH=C:\Program Files\Git\bin;%PATH%
echo Current PATH:
echo %PATH%
echo.
echo Git version:
git --version
echo.
flutter doctor -v
