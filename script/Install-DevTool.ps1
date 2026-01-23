<#
.SYNOPSIS
    Installs development tools and utilities for a complete coding environment setup.

.DESCRIPTION
    This script automates the installation of the following tools:
    - Git (version control)
    - Neovim (modern Vim editor)
    - NuShell (modern shell)
    - Starship (cross-shell prompt)
    - Superfile (spf) (terminal file manager) [installed from official source]
    - Wezterm (GPU-accelerated terminal)
    - FiraCode Nerd Font (via scoop)

    Uses winget for most installations, official source for Superfile, and scoop for font management.
.LINK 
    https://github.com/alarwasyi98/dotfiles-win
.NOTES
    Author: Abdul Hakim Alarwasyi
    Email: alarwasyi98@gmail.com
    Created: Saturday, May 18 2025
    Version: 0.1
#>

# Function to check if a command exists
function Test-Command {
    param([string]$command)
    return [bool](Get-Command -Name $command -ErrorAction SilentlyContinue)
}

# Function to install with winget
function Install-WingetPackage {
    param(
        [string]$packageId,
        [string]$packageName
    )
    
    Write-Host "Installing $packageName..." -ForegroundColor Cyan
    winget install --id $packageId --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Failed to install $packageName"
        return $false
    }
    return $true
}

# Function to install Superfile from official source
function Install-Superfile {
    Write-Host "Installing Superfile (spf) from official source..." -ForegroundColor Cyan
    try {
        $installScript = {
            powershell -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://superfile.netlify.app/install.ps1'))"
        }
        Invoke-Command -ScriptBlock $installScript
        if (Test-Command -command "spf") {
            Write-Host "Superfile installed successfully" -ForegroundColor Green
            return $true
        }
        else {
            Write-Warning "Superfile installation might have failed"
            return $false
        }
    }
    catch {
        Write-Warning "Error installing Superfile: $_"
        return $false
    }
}

# Check if winget is available
if (-not (Test-Command -command "winget")) {
    Write-Error "winget is not available. Please install Windows Package Manager first."
    exit 1
}

# Install core applications
$packages = @(
    @{Id = "Git.Git"; Name = "Git"},
    @{Id = "Neovim.Neovim"; Name = "Neovim"},
    @{Id = "Nushell.Nushell"; Name = "NuShell"},
    @{Id = "Starship.Starship"; Name = "Starship"},
    @{Id = "WezFurlong.WezTerm"; Name = "Wezterm"}
)

foreach ($package in $packages) {
    Install-WingetPackage -packageId $package.Id -packageName $package.Name
}

# Install Superfile from official source
Install-Superfile

# Install FiraCode Nerd Font using scoop
if (-not (Test-Command -command "scoop")) {
    Write-Host "Installing Scoop..." -ForegroundColor Cyan
    try {
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        if (-not (Test-Command -command "scoop")) {
            Write-Error "Failed to install Scoop. FiraCode font won't be installed."
        }
    }
    catch {
        Write-Warning "Failed to install Scoop: $_"
    }
}

if (Test-Command -command "scoop")) {
    Write-Host "Installing FiraCode Nerd Font..." -ForegroundColor Cyan
    scoop bucket add nerd-fonts
    scoop install FiraCode-NF
}

# Verify installations
Write-Host "`nVerifying installations..." -ForegroundColor Green

$tools = @(
    "git", "nvim", "nu", "starship", "spf", "wezterm"
)

foreach ($tool in $tools) {
    if (Test-Command -command $tool) {
        Write-Host "$tool installed successfully" -ForegroundColor Green
    }
    else {
        Write-Warning "$tool installation might have failed"
    }
}

# Check font installation
if (Test-Command -command "scoop")) {
    scoop list | Select-String "FiraCode" | ForEach-Object {
        Write-Host "Font installed: $_" -ForegroundColor Green
    }
}

Write-Host "`nSetup completed!" -ForegroundColor Green
Write-Host "Some applications may require:" -ForegroundColor Yellow
Write-Host "- A restart or new terminal session" -ForegroundColor Yellow
Write-Host "- Additional configuration (e.g., Starship needs shell integration)" -ForegroundColor Yellow
