# Set up environment for Flutter project
Write-Host "Setting up environment for Flutter project..." -ForegroundColor Green

# Set up Git path properly
$env:PATH = "C:\Program Files\Git\bin;C:\Program Files\Git\cmd;C:\flutter\bin;" + $env:PATH

# Set Flutter environment variables
$env:FLUTTER_ROOT = "C:\flutter"

# Verify git is accessible
Write-Host "Checking git..." -ForegroundColor Yellow
try {
    $gitVersion = & "C:\Program Files\Git\bin\git.exe" --version
    Write-Host "Git version: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: Git not found" -ForegroundColor Red
    exit 1
}

# Try to run Flutter
Write-Host "Running Flutter project..." -ForegroundColor Yellow
try {
    & "C:\flutter\bin\flutter.bat" run -d web-server --web-port 8080
} catch {
    Write-Host "Error running Flutter: $_" -ForegroundColor Red
    exit 1
} 