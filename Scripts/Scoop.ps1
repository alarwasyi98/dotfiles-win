# Periksa apakah Scoop sudah terinstal
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop Installed Succesfully"
}
else {
    # Set execution policy untuk pengguna saat ini
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

    # Unduh dan jalankan skrip instalasi Scoop
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

    # Periksa apakah instalasi berhasil
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        Write-Host "Scoop Installed Succesfully"
    }
    else {
        Write-Host "Failed installing scoop. Check your Internet Connection"
    }
}

# Tambahkan Scoop ke PATH jika belum ada
if ($env:Path -notlike "*$env:USERPROFILE\scoop\shims*") {
    $env:Path += ";$env:USERPROFILE\scoop\shims"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
    Write-Host "Scoop added to ENV_VAR"
}

Write-Host "Scoop Installation Finished. try scoop -? to verify"