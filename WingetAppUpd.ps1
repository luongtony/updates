# Define the directory where the installer will be downloaded
$downloadPath = "C:\temp"

# Create the directory if it does not exist
if (-Not (Test-Path $downloadPath)) {
    New-Item -Path $downloadPath -ItemType Directory
}

# Define the URL for the latest winget release on GitHub
$wingetReleaseUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"

# Define the full path to save the installer
$installerPath = Join-Path $downloadPath "winget.appxbundle"

# Download the latest release
Invoke-WebRequest -Uri $wingetReleaseUrl -OutFile $installerPath

# Install winget using Add-AppxPackage
Add-AppxPackage -Path $installerPath

# Verify installation and update all software if winget is installed
if (Get-Command 'winget' -ErrorAction SilentlyContinue) {
    Write-Host "winget is installed. Updating all installed software..."
    winget upgrade --all
} else {
    Write-Host "Installation failed. Please ensure your system supports app package installations."
}

# Clean up the installer
Remove-Item -Path $installerPath

& winget upgrade --all
