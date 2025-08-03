@echo off
echo === Preparing Untethered AI for Mobile Deployment ===
echo.

echo Setting up environment...
set PATH=C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;C:\Windows\System32;C:\Windows;%PATH%
set FLUTTER_ROOT=C:\flutter

echo Building Flutter web app...
C:\flutter\bin\flutter.bat build web --release

echo.
echo Creating deployment package...
if not exist "deployment" mkdir deployment
xcopy "build\web\*" "deployment\" /E /I /Y

echo.
echo Creating README for deployment...
echo # Untethered AI - Mobile App > deployment\README.md
echo. >> deployment\README.md
echo ## How to Deploy >> deployment\README.md
echo. >> deployment\README.md
echo ### Option 1: Netlify (Easiest) >> deployment\README.md
echo 1. Go to https://netlify.com >> deployment\README.md
echo 2. Drag and drop the deployment folder >> deployment\README.md
echo 3. Get your mobile URL instantly >> deployment\README.md
echo. >> deployment\README.md
echo ### Option 2: Vercel >> deployment\README.md
echo 1. Go to https://vercel.com >> deployment\README.md
echo 2. Import the deployment folder >> deployment\README.md
echo 3. Deploy with one click >> deployment\README.md
echo. >> deployment\README.md
echo ### Option 3: GitHub Pages >> deployment\README.md
echo 1. Upload to GitHub repository >> deployment\README.md
echo 2. Enable GitHub Pages in settings >> deployment\README.md
echo 3. Access via username.github.io/repo-name >> deployment\README.md

echo.
echo ========================================
echo DEPLOYMENT READY!
echo ========================================
echo.
echo Your app is ready for deployment in the 'deployment' folder.
echo.
echo Quick deployment options:
echo 1. Netlify: Drag 'deployment' folder to netlify.com
echo 2. Vercel: Import 'deployment' folder to vercel.com
echo 3. GitHub Pages: Upload to GitHub repository
echo.
echo After deployment, access the URL on your phone and add to home screen!
echo.
pause 