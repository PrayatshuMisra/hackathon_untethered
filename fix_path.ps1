# Script to clean and rebuild PATH for Flutter

# Get current PATH from the registry
$userPath = [System.Environment]::GetEnvironmentVariable('Path', 'User')
$systemPath = [System.Environment]::GetEnvironmentVariable('Path', 'Machine')

# Clean up the PATH by removing duplicates and empty entries
$cleanPath = ($userPath, $systemPath) -join ';' -split ';' | 
    Where-Object { $_ -ne '' } | 
    Select-Object -Unique | 
    Where-Object { Test-Path $_ }

# Add Git to PATH if not already present
$gitPath = "C:\Program Files\Git\bin"
if ($cleanPath -notcontains $gitPath) {
    $cleanPath = @($gitPath) + $cleanPath
}

# Convert back to semicolon-separated string
$newPath = $cleanPath -join ';'

# Set the new PATH for current session
$env:Path = $newPath

# Save to user environment variables
[System.Environment]::SetEnvironmentVariable('Path', $newPath, 'User')

# Verify
Write-Host "Updated PATH:"
$env:Path -split ';' | Where-Object { $_ -ne '' } | ForEach-Object { Write-Host "  $_" }

Write-Host "`nVerifying Git access:"
git --version

Write-Host "`nTrying Flutter doctor:"
flutter doctor -v
