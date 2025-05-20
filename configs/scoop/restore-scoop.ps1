# Restore buckets from JSON
$buckets = Get-Content "$PSScriptRoot/../configs/scoop/buckets.json" | ConvertFrom-Json
$buckets | ForEach-Object {
  if (-not (scoop bucket list | Where-Object { $_ -eq $_.Name })) {
    scoop bucket add $_.Name $_.Source
  }
}

# Install apps from JSON
$apps = Get-Content "$PSScriptRoot/../configs/scoop/apps.json" | ConvertFrom-Json
$apps | ForEach-Object {
  scoop install $_.Name@$_.Version
}

# Restore persisted data (if configured)
if (Test-Path "$PSScriptRoot/../configs/scoop/persist.json") {
  scoop reset *
}
