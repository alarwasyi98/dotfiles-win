$ScriptsPath = Join-Path $PSScriptRoot "Scripts"

# Load Aliases
. (Join-Path $ScriptsPath "Aliases.ps1")

# Load Functions
. (Join-Path $ScriptsPath "Functions.ps1")

# Load Modules
. (Join-Path $ScriptsPath "Modules.ps1")

# Starship Prompt Conf
$ENV:STARSHIP_CACHE = "$HOME\AppData\Local\Temp"
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"
$ENV:STARSHIP_DISTRO = "  alarwasyi98 "

# ChocolateyProfile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}


# Linux-Like Function

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = "& '$args'"
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}



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
function ep { vim $PROFILE }
function staredit {
    param (
        [string]$FilePath = "C:\Users\alarw\.config\starship.toml"
    )
    nvim $FilePath
}

# Invoke Expressions
Invoke-Expression (&starship init powershell)
Invoke-Expression (& { (zoxide init powershell | Out-String) }) # Must in the end