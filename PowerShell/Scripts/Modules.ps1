# Modules Importer
# Terminal-Icons
Import-Module Terminal-Icons

# PSReadline
Import-Module PSReadline
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -PredictionViewStyle ListView
Set-PsReadlineOption -PredictionSource History