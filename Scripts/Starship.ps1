# Instal Starship menggunakan winget
winget install starship

# Buat atau perbarui profil PowerShell 7
$profilePath = $PROFILE.CurrentUserCurrentHost
if (!(Test-Path -Path $profilePath)) {
    New-Item -ItemType File -Path $profilePath -Force
}

# Tambahkan konfigurasi Starship ke profil
$starshipConfig = "Invoke-Expression (&starship init powershell)"
if (!(Select-String -Path $profilePath -Pattern $starshipConfig -Quiet)) {
    Add-Content -Path $profilePath -Value "`n$starshipConfig"
}

Write-Host "Starship is Installed and Configured to $PROFILE"
Write-Host "Restart Windows Terminal to take effect"