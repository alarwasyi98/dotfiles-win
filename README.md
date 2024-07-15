# Abdul Hakim's Windows Dotfiles

Welcome to my `Windows Dotfiles` repository! This repository contains various configurations that I use whenever I set up a new laptop or PC with Windows. The goal is to simplify the initial setup and save time by using proven and tailored environments.

> [!IMPORTANT]
> This repository only contains a collection of basic configurations that I use for daily use. No automation or bootstrapping

## Table of Contents

- [Abdul Hakim's Windows Dotfiles](#abdul-hakims-windows-dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Basic Overview](#basic-overview)
  - [Included Configurations](#included-configurations)
  - [Configuration Procces](#configuration-procces)
    - [1. Installing Windows Using Answer File](#1-installing-windows-using-answer-file)
    - [2. Softwares Installation](#2-softwares-installation)
    - [3. Chocolatey Installation](#3-chocolatey-installation)
    - [4. Installing Scoop](#4-installing-scoop)
    - [5. Installing App via Microsoft Store](#5-installing-app-via-microsoft-store)
    - [6. Installing Additional App](#6-installing-additional-app)
    - [7. yeet! Another Installation](#7-yeet-another-installation)
    - [8. Enabling Windows Features](#8-enabling-windows-features)
  - [TODO's](#todos)
  - [Contribution](#contribution)
  - [License](#license)

## Basic Overview

This repository is a collection of various application configurations I use daily as a front-end developer on Windows 11. All configurations are organized to be easily transferable and applicable to new installations of Windows.

## Included Configurations

This repository includes configurations for the following applications and tools: You can see list of apps that I configure in [Included-Configuration](./README.md)

- **Windows Terminal**
- **PowerShell 7**
- **Neovim**
- **VSCode**
- **Git**
- **WSL (Windows Subsystem for Linux)**
- **Other relevant applications**

## Configuration Procces

### 1. Installing Windows Using [Answer File](https://github.com/memstechtips/UnattendedWinstall)

> [!WARNING]
> Make sure you understand the risks and benefits of this file. Do it at your own risk!

When I first configured the `Bootable Disk`, the answer file served to shorten my time in tweaking the windows installation. You can read their [Documentation](https://github.com/memstechtips/UnattendedWinstall/blob/main/README.md) for more details.

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

Because we use the `answer file` during Windows Installation, we don't get Bloatware Applications like in a normal Windows installation. Therefore, we need Microsoft Store to install some essential Apps for regular use. The following apps is some apps that only available in Microsft Store.

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

- [Nitro PDF Reader](https://www.gonitro.com/)
- [Character Map UWP](https://github.com/character-map-uwp/Character-Map-UWP); A modern, native UWP replacement for the Win32 Character Map
- [Notion](https://www.notion.so/) ; The all-in-one workspace
- [Notion-Calendar](https://www.notion.so/product/calendar) ; Notion-designed Calendar
- [Cloudflare-WARP](https://one.one.one.one) ; VPN-like service, but not

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
  - Change `DisableNotificationCenter` to 0

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

## TODO's

- [x] Tweaks troubleshoots
- [x] Package Manager Conf
- [x] Basic Softwares Installation
- [x] Add IDE configuration (neovim & VScode)
- [ ] Environment Variables Conf
- [ ] Git integration
- [ ] Build a `bootstrap.ps1` script for Automation

## Contribution

> [!NOTE]
> I know that this way is for dummies. I'm looking for easier way to manage the configuration such as [GNU Stow](https://www.gnu.org/software/stow/), the dotfiles manager for UNIX System. Tell if any!

Contributions are welcome! If you want to add or update configurations, please make a pull request. Make sure you have tested the changes you made before submitting the PR.

## License

This repository is licensed under the [GPL License](LICENSE). Please read the license file for more information.

---

Happy configuring and I hope you find this repository useful!
