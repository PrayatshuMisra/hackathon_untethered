# Set up environment for APK build
$env:PATH = "C:\Program Files\Git\cmd;C:\flutter\bin;" + $env:PATH
$env:GIT_EXEC_PATH = "C:\Program Files\Git\cmd\git.exe"

Write-Host "Testing git..." -ForegroundColor Green
& "C:\Program Files\Git\cmd\git.exe" --version

Write-Host "Building APK..." -ForegroundColor Green
& "C:\flutter\bin\flutter.bat" build apk --release

Write-Host "APK build complete!" -ForegroundColor Green
Write-Host "The APK file should be located at: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Yellow 