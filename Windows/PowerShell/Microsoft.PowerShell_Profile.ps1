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

#############################
# --- Linux-Like Function ---
#############################

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

# Print Command Location
function which {
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

# Make new item
# parameters: -encoding, -d for directory
function touch {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$path,
        
        [Parameter(Mandatory = $false)]
        [switch]$d,

        [Parameter(Mandatory = $false)]
        [ValidateSet("utf8", "utf8BOM", "ascii", "unicode")]
        [string]$encoding = "utf8"
    )

    if ($d) {
        # Membuat direktori
        if (!(Test-Path -Path $path)) {
            New-Item -ItemType Directory -Path $path -Force
        }
        else {
            Write-Host "Directory already exists: $path"
        }
    }
    else {
        # Membuat atau memperbarui file
        if (Test-Path -Path $path) {
            (Get-Item $path).LastWriteTime = Get-Date
        }
        else {
            $encodingObj = switch ($encoding) {
                "utf8" { [System.Text.Encoding]::UTF8 }
                "utf8BOM" { New-Object System.Text.UTF8Encoding $true }
                "ascii" { [System.Text.Encoding]::ASCII }
                "unicode" { [System.Text.Encoding]::Unicode }
            }
            [System.IO.File]::WriteAllText($path, "", $encodingObj)
        }
    }
}


# reload PowerShell Profiles for All Users
function Reload-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }
}

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

function Install-Dependencies {
    param(
        [string[]]$Tools = @('git', 'fzf', 'bat', 'zoxide', 'lazygit', 'neofetch'),
        [string[]]$Modules = @('PSReadline', 'PSWebsearch', 'Terminal-Icons')
    )

    # Check if running as Administrator
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Write-Warning "This script requires running as Administrator."
        return
    }

    # Check if Chocolatey is installed
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force;
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        RefreshEnv
    }

    # Function to install a tool using Chocolatey
    function Install-Tool {
        param(
            [string]$Tool
        )
        Write-Host "Installing $Tool..."
        choco install $Tool -y
    }

    # Function to install a PowerShell module
    function Install-ModuleSafely {
        param(
            [string]$Module
        )
        Write-Host "Installing PowerShell module: $Module..."
        try {
            Install-Module -Name $Module -Force -AllowClobber -Scope CurrentUser -ErrorAction Stop
        }
        catch {
            Write-Warning "Failed to install module $Module. Error: $_"
        }
    }

    # Install each tool
    foreach ($tool in $Tools) {
        Install-Tool -Tool $tool
    }

    # Install each PowerShell module
    foreach ($module in $Modules) {
        Install-ModuleSafely -Module $module
    }

    Write-Host "All tools and modules have been installed successfully."
}

# Call the function to install the tools and modules
Install-ToolsAndModules


#############################
# --- Modules Importer ---
#############################

# Terminal-Icons
Import-Module Terminal-Icons

# PSReadline
Import-Module PSReadline
Set-PSReadLineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -PredictionViewStyle ListView
Set-PsReadlineOption -PredictionSource History

# starship prompt 'winget install starship'
Invoke-Expression (&starship init powershell)
# zoxide autojump 'winget install zoxide'
Invoke-Expression (& { (zoxide init powershell | Out-String) }) # Must in the end
