# Debug script to check environment and permissions

Write-Host "=== Environment Information ===" -ForegroundColor Cyan
Write-Host "Current Directory: $(Get-Location)"
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"

# Check Git
Write-Host "`n=== Git Information ===" -ForegroundColor Cyan
$gitPath = (Get-Command git -ErrorAction SilentlyContinue).Source
if ($gitPath) {
    Write-Host "Git Path: $gitPath"
    Write-Host "Git Version: $(git --version)"
    
    # Check Git permissions
    $gitAcl = Get-Acl $gitPath -ErrorAction SilentlyContinue
    if ($gitAcl) {
        Write-Host "Git Permissions: $($gitAcl.Access | Format-Table -AutoSize | Out-String)"
    }
} else {
    Write-Host "Git not found in PATH" -ForegroundColor Red
}

# Check Flutter
Write-Host "`n=== Flutter Information ===" -ForegroundColor Cyan
$flutterPath = "C:\flutter\bin\flutter.bat"
if (Test-Path $flutterPath) {
    Write-Host "Flutter Path: $flutterPath"
    
    # Try to run Flutter with full path
    Write-Host "`nTrying to run Flutter directly..."
    & $flutterPath --version
    
    # Check Flutter doctor with full path
    Write-Host "`nRunning Flutter doctor with full path..."
    & $flutterPath doctor -v
} else {
    Write-Host "Flutter not found at: $flutterPath" -ForegroundColor Red
}

# Check environment variables
Write-Host "`n=== Environment Variables ===" -ForegroundColor Cyan
Write-Host "PATH: $($env:PATH -replace ';', "`n  ")"

# Check for running processes that might interfere
Write-Host "`n=== Running Processes ===" -ForegroundColor Cyan
Get-Process | Where-Object { $_.Name -match 'git|flutter|dart' } | Select-Object Name, Path | Format-Table -AutoSize

Write-Host "`nDebug information collection complete." -ForegroundColor Green
