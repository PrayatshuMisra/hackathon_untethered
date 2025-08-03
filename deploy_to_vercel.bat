@echo off
echo === Deploying Untethered AI to Vercel ===
echo.

echo Setting up environment...
set PATH=C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;C:\Windows\System32;C:\Windows;%PATH%
set FLUTTER_ROOT=C:\flutter

echo Building Flutter web app...
C:\flutter\bin\flutter.bat build web --release

echo.
echo Creating Vercel configuration...
echo { > vercel.json
echo   "version": 2, >> vercel.json
echo   "builds": [ >> vercel.json
echo     { >> vercel.json
echo       "src": "build/web/**", >> vercel.json
echo       "use": "@vercel/static" >> vercel.json
echo     } >> vercel.json
echo   ], >> vercel.json
echo   "routes": [ >> vercel.json
echo     { >> vercel.json
echo       "src": "/(.*)", >> vercel.json
echo       "dest": "/build/web/$1" >> vercel.json
echo     } >> vercel.json
echo   ] >> vercel.json
echo } >> vercel.json

echo.
echo Installing Vercel CLI...
npm install -g vercel

echo.
echo Deploying to Vercel...
vercel --prod

echo.
echo Deployment complete! Your app is now available on mobile!
echo.
pause 