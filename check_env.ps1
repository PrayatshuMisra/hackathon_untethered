Write-Host "=== Environment Information ==="
Write-Host "Current Directory: $(Get-Location)"
Write-Host "Git Version: $(git --version 2>&1)"
Write-Host "Flutter Version: $(flutter --version 2>&1)"
Write-Host "System PATH:"
$env:Path -split ';' | Where-Object { $_ -ne '' } | ForEach-Object { Write-Host "  $_" }
Write-Host "============================"
