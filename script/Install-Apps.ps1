# Check if running as Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This script requires Administrator privileges. Please run it as Administrator."
    exit
}

# Define the list of winget install commands directly in the script
$packages = @(
    "winget install --id Bitwarden.Bitwarden -e --silent",
    "winget install --id Google.Chrome -e --silent",
    "winget install --id Microsoft.Edge -e --silent",
    "winget install --id Mozilla.Firefox -e --silent",
    "winget install --id FilesCommunity.Files -e --silent",
    "winget install --id JackieLiu.NotepadsApp -e --silent",
    "winget install --id VideoLAN.VLC -e --silent",
    "winget install --id Docker.DockerDesktop -e --silent",
    "winget install --id LeNgocKhoa.Laragon -e --silent",
    "winget install --Id wez.wezterm -e --silent",
    "winget install --id Microsoft.WindowsTerminal -e --silent",
    "winget install --id Microsoft.VisualStudioCode -e --silent",
    "winget install --id Figma.Figma -e --silent",
    "winget install --id Inkscape.Inkscape -e --silent",
    "winget install --id Notion.Notion -e --silent",
    "winget install --id Notion.NotionCalendar -e --silent",
    "winget install --id Obsidian.Obsidian -e --silent",
    "winget install --id RustemMussabekov.Raindrop -e --silent",
    "winget install --id WhatsApp.WhatsApp -e --silent",
    "winget install --id 9WZDNCRDXF41 -e --silent",
    "winget install --id Nilesoft.Shell -e --silent",
    "winget install --id Skillbrains.Lightshot -e --silent",
    "winget install --id ShareX.ShareX -e --silent",
    "winget install --id RARLab.WinRAR -e --silent",
    "winget install --id sharkdp.bat -e --silent",
    "winget install --id aristocratos.btop4win -e --silent",
    "winget install --id dandavison.delta -e --silent",
    "winget install --id junegunn.fzf -e --silent",
    "winget install --id Git.Git -e --silent",
    "winget install --id JesseDuffield.lazygit -e --silent",
    "winget install --id LLVM.LLVM -e --silent",
    "winget install --id Neovim.Neovim -e --silent",
    "winget install --id OpenJS.NodeJS.LTS -e --silent",
    "winget install --id Nushell.Nushell -e --silent",
    "winget install --id Microsoft.PowerShell -e --silent",
    "winget install --id Microsoft.PowerToys -e --silent",
    "winget install --id BurntSushi.ripgrep.MSVC -e --silent",
    "winget install --id Starship.Starship -e --silent",
    "winget install --id ajeetdsouza.zoxide -e --silent",
    "winget install --id sharkdp.fd -e --silent"
)

# Main installation loop
foreach ($line in $packages) {
    # Extract the ID for user-friendly prompt
    if ($line -match '--id ([^ ]+)') {
        $packageId = $matches[1]
    } else {
        Write-Warning "Could not parse package ID from line: $line"
        continue
    }

    # Prompt user to install or skip
    $answer = Read-Host -Prompt "Install '$packageId'? [Y/N]"
    if ($answer -ne 'Y' -and $answer -ne 'y') {
        Write-Host "Skipped: $packageId" -ForegroundColor Yellow
        continue
    }

    Write-Host "Installing: $packageId" -ForegroundColor Green

    try {
        # Execute winget install command
        Invoke-Expression "$line 2>&1"
        
        # Check exit code
        if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne 1641 -and $LASTEXITCODE -ne 3010) {
            throw "winget install failed with exit code $LASTEXITCODE"
        }
    }
    catch {
        Write-Error "Failed to install $packageId`: $_"
    }
}

# Final completion message
Write-Host "You are all set!" -ForegroundColor Cyan
