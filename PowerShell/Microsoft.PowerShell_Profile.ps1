# ChocolateyProfile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Starship Prompt Conf
# $ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
# $ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
$ENV:STARSHIP_DISTRO = "  alarwasyi98 "

# Aliases
Set-Alias tt tree
# Set-Alias ll ls
Set-Alias vim nvim
Set-Alias cat bat

# fzf preview windows grep
function bfzf {
    fzf --preview="bat --decorations=always --color=always {}"
}
# fzf preview nvim click
function fzfvim {
    nvim (fzf --preview="bat --decorations=always --color=always {}")
}

##########################
# Linux-Like Function
##########################

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    }
    else {
        Start-Process wt -Verb runAs
    }
}
# Set UNIX-like aliases for the admin command, so sudo <command> will run the command with elevated rights.
Set-Alias -Name su -Value admin

# Easy Navigate Program
function whereis ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch($file) { "" | Out-File $file -Encoding ASCII }
function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.FullName)"
    }
}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

# Navigation Shortcuts
function docs { Set-Location -Path $HOME\Documents }
function pict { Set-Location -Path $HOME\Pictures }
function dev { Set-Location -Path x:\ }

# Quick Access to Editing the Profile
function Edit-Profile {
    vim $PROFILE.CurrentUserAllHosts
}
function ep { vim $PROFILE }
function staredit {
    param (
        [string]$FilePath = "C:\Users\alarwasyi98\.config\starship.toml"
    )
    nvim $FilePath
}

# Open Windows Utilitie Chris Titus
function winutil {
    Invoke-WebRequest -useb https://christitus.com/win | Invoke-Expression
}

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ln { Get-ChildItem -Name | Format-Table -Autosize }

# Git Shortcuts
function gs { git status }
function ga { git add . }
function gc { param($m) git commit -m "$m" }
function gp { git push }
function g { z Github }
function gcl { git clone "$args" }
function gcom {
    git add .
    git commit -m "$args"
}
function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# Modules Importer
# Terminal-Icons
Import-Module Terminal-Icons

# PSReadline
Import-Module PSReadline
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -PredictionViewStyle ListView
Set-PsReadlineOption -PredictionSource History

# PSGallery => PowerShellGet Package Manager Credential
# Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

# Invoke Expressions
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) }) # Must in the end
