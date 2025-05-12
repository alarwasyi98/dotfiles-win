# Fungsi untuk memeriksa koneksi internet
function Test-InternetConnection {
    $pingTest = Test-Connection -ComputerName 8.8.8.8 -Count 2 -Quiet
    return $pingTest
}

# Fungsi untuk memeriksa hak administrator
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Fungsi untuk menginstal Chocolatey
function Install-Chocolatey {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Memeriksa koneksi internet
if (-not (Test-InternetConnection)) {
    Write-Host "No Internet Connection! Try again later."
    exit
}

# Memeriksa hak administrator
if (-not (Test-Administrator)) {
    Write-Host "The script needs Administrator rights!."
    exit
}

# Menginstal Chocolatey jika belum terinstal
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Install-Chocolatey
}

# Memperbarui WinGet
Write-Host "Updating WinGet..."
winget upgrade --silent --accept-package-agreements --accept-source-agreements

# Menginstal PowerShell 7 jika belum terinstal
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "Instaling PowerShell 7..."
    winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "You Are All Set!" -ForegroundColor Green
