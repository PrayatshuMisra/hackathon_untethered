# Comprehensive Flutter App Builder and Runner
Write-Host "=== Untethered AI Flutter App Builder and Runner ===" -ForegroundColor Cyan

# Set up environment
Write-Host "Setting up environment..." -ForegroundColor Green
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;C:\Windows\System32;C:\Windows;" + $env:PATH
$env:FLUTTER_ROOT = "C:\flutter"

# Navigate to project directory
Write-Host "Navigating to project directory..." -ForegroundColor Yellow
Set-Location "D:\study\coding_prac\hackathon-ai"

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
& "C:\flutter\bin\flutter.bat" clean

# Get dependencies
Write-Host "Getting Flutter dependencies..." -ForegroundColor Yellow
& "C:\flutter\bin\flutter.bat" pub get

# Build for web
Write-Host "Building for web..." -ForegroundColor Yellow
& "C:\flutter\bin\flutter.bat" build web --release

# Check if build was successful
if (Test-Path "build\web") {
    Write-Host "Build output found in build\web" -ForegroundColor Green
} else {
    Write-Host "Build output not found" -ForegroundColor Red
    exit 1
}

# Start the web server
Write-Host "Starting Flutter web server..." -ForegroundColor Green
Write-Host "App will be available at: http://localhost:8080" -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow

# Run Flutter directly
& "C:\flutter\bin\flutter.bat" run -d web-server --web-port 8080 --release

Write-Host "App session ended." -ForegroundColor Green 