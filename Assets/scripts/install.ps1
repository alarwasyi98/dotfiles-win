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
    Write-Host "Tidak ada koneksi internet. Silakan hubungkan ke internet dan jalankan skrip kembali."
    exit
}

# Memeriksa hak administrator
if (-not (Test-Administrator)) {
    Write-Host "Skrip ini memerlukan hak administrator. Silakan jalankan PowerShell sebagai Administrator."
    exit
}

# Menginstal Chocolatey jika belum terinstal
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Menginstal Chocolatey..."
    Install-Chocolatey
}

# Memperbarui WinGet
Write-Host "Memperbarui WinGet..."
winget upgrade --silent --accept-package-agreements --accept-source-agreements

# Menginstal browser
Write-Host "Menginstal browser..."
winget install Google.Chrome --silent --accept-package-agreements --accept-source-agreements
winget install Mozilla.Firefox --silent --accept-package-agreements --accept-source-agreements
winget install Microsoft.Edge --silent --accept-package-agreements --accept-source-agreements

# Menginstal VSCode dan Neovim
Write-Host "Menginstal VSCode dan Neovim..."
winget install Microsoft.VisualStudioCode --silent --accept-package-agreements --accept-source-agreements
choco install neovim -y

# Menginstal CLI Tools
Write-Host "Menginstal CLI Tools..."
choco install zoxide fzf git -y

# Menginstal PowerShell 7 jika belum terinstal
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Host "Menginstal PowerShell 7..."
    winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
}

# Menginstal modul PowerShell
Write-Host "Menginstal modul PowerShell..."
pwsh -Command {
    Install-Module -Name PSReadLine -Force -SkipPublisherCheck
    Install-Module -Name Terminal-Icons -Force
}

Write-Host "You Are All Set!" -ForegroundColor Green