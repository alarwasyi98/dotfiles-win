# Fungsi untuk meminta input dari pengguna
function Get-UserInput($prompt) {
    $input = Read-Host -Prompt $prompt
    return $input.Trim()
}

# Minta input username dan email
$username = Get-UserInput "Your Git Username"
$email = Get-UserInput "Your Git Email"

# Konfigurasi Git
$gitConfig = @"
[user]
        name = $username
        email = $email
[core]
        editor = code --wait
[init]
        defaultBranch = main
[credential]
        helper = store
[color]
        ui = auto
[default]
        difftool = default-difftool
[default "default-difftool"]
        cmd = code --wait --diff `$LOCAL `$REMOTE
"@

# Path ke file .gitconfig
$gitConfigPath = "$HOME\.gitconfig"

# Tulis konfigurasi ke file .gitconfig
Set-Content -Path $gitConfigPath -Value $gitConfig

Write-Host "Konfigurasi Git telah diatur dan disimpan di $gitConfigPath"
Write-Host "Konfigurasi yang diterapkan:"
Write-Host $gitConfig