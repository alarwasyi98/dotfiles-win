#        .__
# _____  |  |     POWERSHELL 7 SETUP
# \__  \ |  |     Abdul Hakim (alarwasyi98)
#  / __ \|  |__   https://github.com/alarwasyi98/PowerShell
# (____  /____/	  Version: 12.2.1
#      \/

# ENVIRONMENT VARIABLES

$ENV:CONFIG_HOME	= "$HOME\.config"
$ENV:STARSHIP_CONFIG 	= "$HOME\.config\starship.toml"
$ENV:GIT_SSH        	= "$ENV:SYSTEMROOT\system32\OpenSSH\ssh.exe"

# EDITOR DETECTION

function Test-CommandExists {
    param($command)
    return $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
}

$EDITOR = switch ($true) {
    (Test-CommandExists nvim)         { 'nvim'; break }
    (Test-CommandExists vim)          { 'vim'; break }
    (Test-CommandExists vi)           { 'vi'; break }
    (Test-CommandExists code)         { 'code'; break }
    (Test-CommandExists 'notepad++')  { 'notepad++'; break }
    default                           { 'notepad' }
}

Set-Item -Path alias:vim -Value $EDITOR
Set-Item -Path alias:vi  -Value $EDITOR

# CHOCOLATEY

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
    Import-Module $ChocolateyProfile
}

# FUNCTIONS

# Edit PowerShell Profile and Config
function Edit-Profile  { & $EDITOR $PROFILE }
function Edit-Starship { & $EDITOR $ENV:STARSHIP_CONFIG }
function Edit-Nvim     { & $EDITOR "$ENV:LOCALAPPDATA\nvim" }
function Edit-SSHConfig { & $EDITOR "$HOME\.ssh\config" }

# GIT FLOW
Function gs { git status }
Function ga { git add . }
Function gp { git push }
Function gcl { git clone "$args" }

function gcom {
    git add .
    git commit -m "$args"
}

function lazyg {
    git add .
    git commit -m "$args"
    git push
}

# FZF

function bfzf {
    fzf --preview="bat --decorations=always --color=always {}"
}

function fzfvim {
    & $EDITOR (fzf --preview="bat --decorations=always --color=always {}")
}

# UTILITIES

## Reload PowerShell Profile
function Update-Profile {
    . $PROFILE
    Write-Output "Profile reloaded."
}

## Create New File
function touch {
    param($file)
    "" | Out-File $file -Encoding ASCII
}

## Search file Recursively
function ff {
    param($name)
    Get-ChildItem -Recurse -Filter "*${name}*" -ErrorAction SilentlyContinue |
        ForEach-Object { Write-Output $_.FullName }
}

## Extract ZIP
function unzip {
    param($file)
    Write-Output "Extracting $file to $PWD"
    $fullFile = Get-ChildItem -Path $PWD -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $PWD
}

## which-like command
function which {
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]$command
    )
    $result = Get-Command $command -ErrorAction SilentlyContinue
    if ($result) { $result.Source } else { Write-Host "$command not found" }
}

# Run as Administrator via Windows Terminal
function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb RunAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb RunAs
    }
}

# Yazi file manager with directory tracking
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

# SSH agent - auto-start
if (-not (Get-Process ssh-agent -ErrorAction SilentlyContinue)) {
    Start-Service ssh-agent -ErrorAction SilentlyContinue
}

# ALIASES

Set-Alias -Name tt		-Value tree
Set-Alias -Name cat     	-Value bat
Set-Alias -Name h       	-Value Get-History
Set-Alias -Name su      	-Value admin
Set-Alias -Name ep      	-Value Edit-Profile
Set-Alias -Name sedit   	-Value Edit-Starship
Set-Alias -Name sshconfig	-Value Edit-SSHConfig
Set-Alias -Name z	  	-Value cd

# MODULES

Import-Module Terminal-Icons

Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# PSREADLINE

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView

# INVOCATIONS

Show-ColorScript -Name alpha

Invoke-Expression (&starship init powershell)

fnm env --shell powershell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
