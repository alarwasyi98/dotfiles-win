<!-- markdownlint-disable MD041 -->
![alt text](/Assets/Images/desktop_2.png)

# Abdul Hakim's Windows Dotfiles

![scripting-badge](https://img.shields.io/badge/dotfiles-Windows-blue?style=flat-square)
![windot](https://img.shields.io/badge/scripting-PowerShell-blue?style=flat-square)
![level](https://img.shields.io/badge/level-very_beginner-green?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/alarwasyi98/dotfiles-win?style=flat-square)

Welcome to my **Windows Dotfiles** repository! This repository contains various configurations that I use whenever I set up a new laptop or PC with Windows. The goal is to simplify the initial setup and save time by using proven and tailored environments.

> [!NOTE]
> This repository only contains a collection of basic configurations that I use for daily use. No automation or bootstrapping

## Table of Contents

- [Abdul Hakim's Windows Dotfiles](#abdul-hakims-windows-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Basic Overview](#basic-overview)
  - [Included Configurations](#included-configurations)
  - [Installation](#installation)
  - [Installation Procces](#installation-procces)
    - [1. Installing Windows Using Answer File](#1-installing-windows-using-answer-file)
    - [2. Softwares Installation](#2-softwares-installation)
    - [3. Chocolatey Installation](#3-chocolatey-installation)
    - [4. Installing Scoop](#4-installing-scoop)
    - [5. Installing App via Microsoft Store](#5-installing-app-via-microsoft-store)
    - [6. Installing Additional App](#6-installing-additional-app)
    - [7. yeet! Another Installation](#7-yeet-another-installation)
    - [8. Enabling Windows Features](#8-enabling-windows-features)
  - [Apps Configuration](#apps-configuration)
    - [Windows Terminal](#windows-terminal)
    - [Starship Prompt](#starship-prompt)
    - [PowerShell 7](#powershell-7)
    - [Git \& Git Bash](#git--git-bash)
    - [Zoxide \& fzf](#zoxide--fzf)
    - [Neovim](#neovim)
    - [Windows Subsystem for Linux (WSL)](#windows-subsystem-for-linux-wsl)
  - [TODO's](#todos)
  - [Contribution](#contribution)
  - [License](#license)

## Basic Overview

This repository is a collection of various application configurations I use daily as a front-end developer on Windows 11. All configurations are organized to be easily transferable and applicable to new installations of Windows.

## Included Configurations

This repository includes configurations for the following applications and tools: You can see list of apps that I configure in [Included-Configuration](included.md)

- **Windows Terminal**
- **Starship Prompt**
- **PowerShell 7**
- **Git & Git Bash**
- **VSCode**
- **Neovim**
- **WSL (Windows Subsystem for Linux)**
- **Other relevant applications**

## Installation

- Git installed? If yes, execute in a terminal window: `cd ~; git clone https://github.com/fleschutz/my-settings`
- Otherwise, download and extract this repository into the home folder (see green button above).

## Installation Procces

### 1. Installing Windows Using [Answer File](https://github.com/memstechtips/UnattendedWinstall)

> [!CAUTION]
> Before proceeding with the installation or any major configuration changes, it is highly recommended to create a Restore Point.
> Make sure you understand the risks and benefits of this file. Do it at your own risk!

When you first configured the `Bootable Disk`, the answer file served to shorten my time in tweaking the windows installation. You can read their [Documentation](https://github.com/memstechtips/UnattendedWinstall/blob/main/README.md) for more details.

### 2. Softwares Installation

I use [PowerShell Utility](github.com/christitustech/winutil) by [ChrisTitusTech](github.com/christitustech/) to install software on my computer. you can minimize software installation time. Here's how to use it:

- Open PowerShell in Admin rights
- Run this command to allow installing software from other source
  
  ``` PowerShell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

- Proceed by executing this command

    ``` PowerShell
    Invoke-RestMethod christitus.com/win | Invoke-Expresion
    ```

- After the Windows pops out, you can import `winutil.json` by click gear icons above, and click import.
- Upload the [winutil.json](.\winutil.json)
- Click Install / Upgrade All

### 3. Chocolatey Installation

Chocolatey is a package manager for Windows that simplifies the installation and management of software.

1. Open PowerShell as an Administrator.

2. Run the following command to install Chocolatey:

    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    ```

3. Verify the installation by running:

    ```powershell
    choco -v
    ```

### 4. Installing Scoop

Scoop is another package manager for Windows that focuses on simplicity and ease of use.

1. Open PowerShell.
2. Ensure that you are in `C:\` directory
3. Run the following command to install Scoop:

    ```powershell
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; irm get.scoop.sh | iex
    ```

4. Verify the installation by running:

    ```powershell
    scoop -v
    ```

### 5. Installing App via Microsoft Store

> [!NOTE]
> If you do not see the Microsoft Store due to Windows installation using [Answer File](#1-installing-windows-using-answer-file), you can download [XBOX Desktop] first, then install the Microsoft Store in the pop-up window.

Because we use the [Answer File](#1-installing-windows-using-answer-file) during Windows Installation, we don't get Bloatware Applications like in a normal Windows installation. Therefore, we need Microsoft Store to install some essential Apps for regular use. The following apps is some apps that only available in Microsft Store.

- [Notepad](https://apps.microsoft.com/detail/9msmlrh6lzf3?hl=en-us&gl=ID)
  - or the alternative [NotepadsApp](https://www.notepadsapp.com/)
- [Snipping-Tool](https://apps.microsoft.com/detail/9mz95kl8mr0l?hl=en-us&gl=ID)
  - or the alternatives:
  - [ShareX](https://getshearex.com)
  - [lightshot](https://app.prntscr.com/)
- [Image Viewer](https://apps.microsoft.com/detail/9wzdncrfjbh4?hl=en-us&gl=ID)
- [Microsoft ToDo](https://apps.microsoft.com/detail/9nblggh5r558?hl=en-us&gl=ID)
- [WhatsAppp](https://apps.microsoft.com/detail/9nksqgp7f2nh?hl=en-us&gl=ID)
- [beWidget (optional)](https://apps.microsoft.com/detail/9nq07fg50h2q?hl=en-us&gl=ID)

### 6. Installing Additional App

Some additional apps that I didn't get through winutil or Microsoft Store:

- [Nitro PDF Reader](https://www.gonitro.com/) ; Powerful PDF Reader
- [Character Map UWP](https://github.com/character-map-uwp/Character-Map-UWP); A modern, native UWP replacement for the Win32 Character Map
- [Notion](https://www.notion.so/) ; The all-in-one workspace
- [Notion-Calendar](https://www.notion.so/product/calendar) ; Notion-designed Calendar
- [Cloudflare-WARP](https://one.one.one.one) ; VPN-like service, but not
- [Pasteboard](https://www.pasteboard.app/); Windows Clipboard manager
- [Raindrop IO](https://www.raindrop.io/); Bookmark manager with Awesome UI
- [Nanazip](https://apps.microsoft.com/detail/9n8g7tscl18r?rtc=1&hl=en-id&gl=ID); ZIP Archiver Alternatives

    ``` powershell
    # install Nitro PDF
    winget install --id NitroSoftware.NitroPro

    # install character map UWP
    winget install --id 9WZDNCRDXF41
    
    # install Notion
    winget install --id Notion.Notion

    # install Notion Calendar
    winget install --id Notion.NotionCalendar

    # install WARP
    winget install --id Cloudflare.Warp

    # Install Pasteboard
    winget install --Id 9P3Q21SL03RL

    # Install Raindrop
    winget install --Id RustemMussabekov.Raindrop

    # Install Nanazip
    winget install --Id Nanazip
    ```

### 7. yeet! Another Installation

- [Office Suite](office.com)
- [XAMPP](https://sourceforge.net/projects/xampp/files/XAMPP%20Windows/)
- [Composer](https://getcomposer.org/download/)

### 8. Enabling Windows Features

Some of the windows features and services that I turned on

- **Notification Centre**

  - Start Push Notification Service
  - Run regedit `regedit`
  - Go to following location `Computer\HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer`
  - Change `DisableNotificationCenter` to `0`

- **Context Menu**

- Bring Back Old Context Menu
  - Open Registry Editor, run `regedit`
  - Set location to: `Computer\HKEY_CURRENT_USER\SOFTWARE\CLASSES\CLSID\`
  - Create `{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}` Key.
  - Create `InprocServer32` Sub-Key

- Undo Old Context Menu
  - Open Registry Editor, run `regedit`
  - Set Location to: `HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32`
  - Remove `{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32`

- **Change User Account Control (UAC)**

    UAC is a security feature in Windows that protects the operating system from unauthorized changes and reduces the risk of malware. You can change UAC settings in the Control Panel

  - Go to Start and open Control Panel
  - Select System and Security
  - Under Security and Maintenance, select Change User Account Control settings
  - Move the slider to the desired level of security
  - Select OK to save your changes
  - Select Yes when prompted to confirm the changes
  - Reboot your computer for the change to take effect.

## Apps Configuration

### Windows Terminal

- Make sure that Windows Terminal is installed, then copy the colorscheme in [win-terminal-setting.json](.\.config\win-terminal.setting.json).

  ``` json
  "schemes": [
    # copy colorscheme you like in this section
  ]
  ```

- Next step is customize the Icons of `$SHELL`. You can find the Icons in `.\Assets\Icons` in this repo.

  ![Terminal-Shell](/Assets/Images/terminal-bar.png)

- Make [PowerShell](learn.microsoft.com/powershell) to the top of list.

### Starship Prompt

[Starship](starship.rs) is a customizable prompt for any shell! you can customize almost everything that appear in your shell. Let's configure!

- Ensure that [Starship](starship.rs) is installed.
- Type this command in the end of your profile. `Microsoft.PowerShell_profile.ps1` for PowerShell, `.bashrc`, `.zshrc` for Bash and ZSH.

  ``` powershell
  # Microsoft.PowerShell_profile.ps1
  Invoke-Expression (&starship init powershell)

  # .bashrc or zsh
  eval "$(starship init $shell)"
  ```

- Copy [starship.toml](./Starship/starship.toml) to your `.config` directory

### PowerShell 7

I have created a profile that collects aliases, functions, and module importers. You can copy the file into the PowerShell profile folder. Here's how.

- Make sure your powershell profile exists in the `~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1` directory. If not, try running this command:
- Copy [Powershell Profile](./PowerShell/Microsoft.PowerShell_Profile.ps1) and overwrite the existing one by running the command:

  ``` powershell
  cd dotfiles-win

  Copy-Item -Path .\PowerShell\Microsoft.PowerShell_Profile.ps1 -Destination $HOME\Documents\PowerShell -Recurse -Force
  ```

- You have the option to copy the `RAW` code only. Customize your needs
- Some commands to run existing modules in the [Powershell Profile](./PowerShell/Microsoft.PowerShell_Profile.ps1)

  ``` powershell
  # PowerShellGet Package Manager
  Install-Module -Name PowerShellGet -AllowCober -Force

  # Trust PSGallery Repo
  Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

  # WinGet Client for PowerToys Util
  Install-Module -Name Microsoft.WinGet.Client -RequiredVersion 0.2.1
  
  # Terminal-Icons Module
  Install-Module -Name Terminal-Icons

  # Prompt Editor and Completion
  Install-Module -Name PSReadline

  # Googling via-terminal 
  Install-Module -Name PSWebSearch -Force
  ```

### Git & Git Bash

- **Git Basic Configutation**

  ``` bash
  # User Info
  git config --global user.name "$user.name"
  git config --global user.email "$user.email"
  
  # Default Editor
  git config --global core.editor "code --wait"
  git config --global default.difftool "default-difftool"
  git config --global default.deafult-difftool.cmd "code --wait --diff \$LOCAL \$REMOTE"
  
  # Set Other Setting
  git config --global init.defaultBranch main
  git config --global core.autocrlf false
  git config --global core.symlink true
  git config --global core.longpath true
  git config --global merge.renamelimit 99999
  git config --global pull.rebase false
  git config --global fetch.parallel 0
  git config --global credential.helper store
  git config --global color.ui auto
  git config --list --show-origin
  
  # Git Custom aliases
  git config --global alias.br "branch"
  git config --global alias.chp "cherry-pick --no-commit"
  git config --global alias.ci "commit"
  git config --global alias.co "checkout"
  git config --global alias.ls "log -n20 --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an%Creset %C(green)%cr%Creset' --abbrev-commit"
  git config --global alias.mrg "merge --no-commit --no-ff"
  git config --global alias.pl "pull --recurse-submodules"
  git config --global alias.ps "push"
  git config --global alias.smu "submodule update --init"
  git config --global alias.st "status"
  ```

- **Setup SSH Key**
  
  ``` bash
  # Generate new SSH Key
  ssh-keygen -t rsa -b 4096 -C "user@email.com"
  
  # Get Public SSH Key for Git Server e.g GutHub
  cd $HOME\.ssh
  cat rsa_id.pub # Yank all of passphrase, paste to GitHub SSH & APG Key
  
  # Test SSH Connection
  ssh -T git@github.com

  ```

- **Git Bash Prompt**

  Ensure you have `Git Bash` profile in Windows Terminal, and configure the [starship setup](#starship-prompt) to customize the prompt.

  > [!NOTE]
  > If you don't see the git profile in your Windows Terminal, do the following instruction:

  - Open your [Windows Terminal](https://github.com/microsoft/terminal) application.
  - Click on the drop-down arrow next to the tabs and select "Settings" from the menu.
  - Click `+ Add New Profile` then `+ New Empty Profile`.
  - Give it a name and add this to Command Line section: `C:\Program Files\Git\bin\bash.exe -l -i`
  - You are all set

### Zoxide & fzf

Zoxide allows you to navigate to the file with fuzzyfinder method. Configure the zoxide by initialize it to PowerShell. Run this command:

``` bash
zoxide.exe init powershell # or any shell you have
```

### Neovim

Neovim is an IDE that you can run it directly via-terminal for fat-forward coding. But neovim installation in Windows is kinda complicated remembering neovim is configured for UNIX system. Here is how:

- Of course, make sure that [Neovim](github.com/neovim/neovim) is installed
- Install C Language Compiler. Download [This File](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z) and extract it to `C:\` directory, then add `C:\minGW64\bin` directory to **Environment Variable**. I Assume that you already know about add something to `$ENV` in Windows.
- Install following software
  
  ``` shell
  # Install Nerd-Fonts via-Scoop
  scoop add bucket nerd-fonts
  scoop install nerd-fonts/FiraCode-NF
  scoop install nerd-fonts/Hack-NF

  # Install Lazygit
  winget install --Id JesseDuffield.lazygit
  ```

- Install [LazyVim](lazyvim.org/installation), you can read the Documentation after run these commands

  ``` powershell
  # required
  Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
  
  # optional but recommended
  Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak

  # Clone the Starter Boilerplate
  git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim

  # Remove .git directory
  Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

  # Start Neovim
  nvim
  ```

- Update all of the Plugins, and add [alpha.lua](.\.config\nvim\lua\plugins\alpha.lua) to you Neovim Configuration folder in `C:\Users\UserName\AppData\Local\nvim\lua\plugins`
- Restart Neovim, and you will have this output after that

  ![neovim-dashboard](/Assets/Images/neo-dashboard.png)

### Windows Subsystem for Linux (WSL)

Refer to [Ubuntu-WSL-dotfiles](github.com/alarwasyi98/dotfiles)

## TODO's

- [x] Tweaks troubleshoots
- [x] Package Manager Conf
- [x] Basic Softwares Installation
- [x] Add IDE configuration (neovim & VScode)
- [ ] Neovim Configuration
- [ ] WSL Configuration
- [ ] Add fonts Installation scripts
- [ ] Environment Variables Conf
- [ ] Git integration
- [ ] Build a `bootstrap.ps1` script for Automation

## Contribution

> [!NOTE]
> I knew that this way is very inconvinience. This is my first repo btw. I'm looking for easier way to manage the configuration such as [GNU Stow](https://www.gnu.org/software/stow/), the dotfiles manager for UNIX System. Tell if any!

Contributions are welcome! If you want to add or update configurations, please make a pull request. Make sure you have tested the changes you made before submitting the PR.

## License

This repository is licensed under the [Public Domain License](LICENSE). Please read the license file for more information.

---
...

Happy configuring and I hope you find this repository useful! ✨
