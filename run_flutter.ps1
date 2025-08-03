# Set up environment
$env:PATH = "C:\Program Files\Git\mingw64\bin;C:\Program Files\Git\bin;" + $env:PATH
$env:GIT_EXEC_PATH = "C:\Program Files\Git\mingw64\bin\git.exe"

# Verify git is accessible
Write-Host "Git version:"
git --version

# Try to run Flutter with explicit git path
Write-Host "Running Flutter..."
$env:GIT_EXEC_PATH = "C:\Program Files\Git\mingw64\bin\git.exe"
.\flutter\bin\flutter.bat run

# Keep window open
Read-Host "Press Enter to continue" 