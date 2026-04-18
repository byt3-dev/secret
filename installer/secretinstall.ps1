# ================================
# Secret Installer for Windows
# ================================

$ErrorActionPreference = "Stop"

Write-Host "Installing Secret..." -ForegroundColor Cyan

# 1. Choose a safe tools directory
$toolsDir = "$env:LOCALAPPDATA\Programs\Secret"
$exePath = Join-Path $toolsDir "secret.exe"

# Create directory if missing
if (!(Test-Path $toolsDir)) {
    Write-Host "Creating tools directory at $toolsDir"
    New-Item -ItemType Directory -Path $toolsDir | Out-Null
}

# 2. Download the latest release from GitHub
$releaseUrl = "https://github.com/byt3-dev/secret/releases/latest/download/secret.exe"

Write-Host "Downloading latest Secret release..."
Invoke-WebRequest -Uri $releaseUrl -OutFile $exePath

# 3. Ensure the file is executable
Write-Host "Setting executable permissions..."
icacls $exePath /grant "$($env:USERNAME):(RX)" | Out-Null

# 4. Add tools directory to PATH (User PATH only, no truncation)
Write-Host "Adding Secret to PATH..."

# Read PATH safely
$path = [Environment]::GetEnvironmentVariable("PATH", "User")

# Avoid duplicates
if ($path -notlike "*$toolsDir*") {
    $newPath = "$path;$toolsDir"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "User")
    Write-Host "PATH updated. Restart your terminal to use 'secret'."
} else {
    Write-Host "PATH already contains Secret directory."
}

# 5. Final message
Write-Host "`nInstallation complete!" -ForegroundColor Green
Write-Host "You can now run: secret" -ForegroundColor Yellow
