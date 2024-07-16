# Open Windows Utilitie Chris Titus
function winutil {
	Invoke-WebRequest -useb https://christitus.com/win | Invoke-Expression
}

# Enhanced Listing
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ln { Get-ChildItem -Name | Format-Table -Autosize}

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