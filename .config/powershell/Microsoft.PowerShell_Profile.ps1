#        .__
# _____  |  |     POWERSHELL 7 SETUP
# \__  \ |  |     Abdul Hakim (alarwasyi98)
#  / __ \|  |__   https://github.com/alarwasyi98/PowerShell
# (____  /____/
#      \/

### ENVIRONMENT VARIABLES ###
Set-Item -Force -Path "ENV:CONFIG_HOME" -Value $HOME\.config
Set-Item -Force -Path "ENV:STARSHIP_CONFIG" -Value $HOME\.config\starship.toml
$ENV:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Utility Functions
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

# Editor Configuration
$EDITOR = if (Test-CommandExists nvim) { 'nvim' }
elseif (Test-CommandExists pvim) { 'pvim' }
elseif (Test-CommandExists vim) { 'vim' }
elseif (Test-CommandExists vi) { 'vi' }
elseif (Test-CommandExists code) { 'code' }
elseif (Test-CommandExists notepad++) { 'notepad++' }
elseif (Test-CommandExists sublime_text) { 'sublime_text' }
else { 'notepad' }

# Exporting chocolatey profile to enable tab-completion
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

### ALIASES ###
Set-Alias -Name tt -Value tree
Set-Alias -Name ll -Value ls

Set-Alias -Name vim -Value $EDITOR
Set-Alias -Name vi -Value nvim
Set-Alias -Name cat -Value bat
Set-Alias -Name h -Value Get-History

### HANDY ALIASES ###
Set-Alias -Name ep -Value Edit-Profile
Set-Alias -Name sedit -Value Edit-Starship

# Set UNIX-like aliases for the admin command, See function below
# so sudo <command> will run the command with elevated rights.
Set-Alias -Name su -Value admin

### FUNCTIONS ###

# pwsh
Function Edit-Profile { vim $PROFILE }

# starship
Function Edit-Starship { vim $STARSHIP_CONFIG }

# nvim
Function Edit-Nvim { vim $ENV:LOCALAPPDATA\nvim }

# Git
Function gs { git status }
Function ga { git add . }
Function gcm { param($m) git commit -m "$m" }
Function gp { git push }
Function g { z Github }
Function gcl { git clone "$args" }
Function gcom {
    git add .
    git commit -m "$args"
}
Function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# fzf
Function bfzf {
    fzf --preview="bat --decorations=always --color=always {}"
}

Function fzfvim {
    nvim (fzf --preview="bat --decorations=always --color=always {}")
}

### SPECIAL FUNCTIONS ###

# Reload PowerShell Profiles for All Users
Function Update-Profile {
    # Memuat ulang profil PowerShell
    . $PROFILE
    Write-Output "Profile Reloaded"
}

# Create New-Item
Function touch($file) { "" | Out-File $file -Encoding ASCII }

# Locate file quickly
Function ff ($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.FullName)"
    }
}

# Extract ZIP File
Function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

# Print command location
Function which {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$command  
    )

    $result = Get-Command $command -ErrorAction SilentlyContinue

    if ($result) {
        $result.Source
    }
    else {
        Write-Host "${command} not found"
    }
}

# Run as Administrator
Function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    }
    else {
        Start-Process wt -Verb runAs
    }
}

### MODULES IMPORTER ###

# Terminal-Icons
Import-Module Terminal-Icons

# PSReadline; fish-like capability
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Set-PSReadlineOption -PredictionViewStyle InlineView 
Set-PsReadlineOption -PredictionSource History

# Command Not Found (PowerToys)
Import-Module -Name Microsoft.WinGet.CommandNotFound

### INVOCATIONS ###

# colorscripts
Show-ColorScript -Name alpha

# starship
Invoke-Expression (&starship init powershell)

# zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
