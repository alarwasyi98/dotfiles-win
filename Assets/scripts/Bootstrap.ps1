<#
.SYNOPSIS
	Installing basic applications for this dotfiles
.DESCRIPTION
	This PowerShell script is Installing required programs.
.NOTES
	Author: Abdul Hakim Alarwasyi | License: CC0
#>

# Function for checking internet connection
function Test-InternetConnection {
    $pingTest = Test-Connection -ComputerName 8.8.8.8 -Count 2 -Quiet
    return $pingTest
}

# Make sure you have elevated rights
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Installing Chocolatey
function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Checking internet connection
if (-not (Test-InternetConnection)) {
    Write-Host "You are disconnected. Connect to internet and try again"
    exit
}

# Memeriksa hak administrator
if (-not (Test-Administrator)) {
    Write-Host "The Script is require administrator rights"
    exit
}

# Menginstal Chocolatey jika belum terinstal
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Please wait, Installing Chocolatey..."
    Install-Chocolatey
}

# Memperbarui WinGet
Write-Host "Updating WinGet..."
winget upgrade --silent --accept-package-agreements --accept-source-agreements

# Menginstal browser
Write-Host "Installing browsers..."
winget install Google.Chrome --silent --accept-package-agreements --accept-source-agreements
winget install Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.Edge --silent --accept-package-agreements --accept-source-agreements

# Menginstal VSCode dan Neovim
Write-Host "Menginstal VSCode dan Neovim..."
winget install Microsoft.VisualStudioCode --silent --accept-package-agreements --accept-source-agreements
winget install -e --id Neovim.Neovim

# Menginstal CLI Tools
Write-Host "Installing CLI Tools..."
winget install -e --id ajeetdsouza.zoxide;winget install -e --id junegunn.fzf;winget install -e --id Git.Git;winget install -e --id dandavison.delta;winget install -e --id Starship.Starship

# Menginstal PowerShell 7 jika belum terinstal
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "Installing PowerShell 7..."
    winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
}

# Menginstal modul PowerShell
Write-Host "Installing PowerShell Modules..."
pwsh -Command {
    Install-Module -Name PSReadLine -Force -SkipPublisherCheck
    Install-Module -Name Terminal-Icons -Force
    Install-Module -Name PSWebSearch -Force
}

Write-Host "You Are All Set!" -ForegroundColor Green
