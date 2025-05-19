
This page contains a categorized list of GUI and CLI applications included in the Windows environment setup, along with their descriptions and installation commands using `winget`. However, you can still use any package manager you prefer LOL.

# Desktop & GUI Apps

If you installing windows using this [Answer File](https://github.com/memstechtips/UnattendedWinstall) you will haven't access to Microsoft Store by default. So if you still want to get some apps from Micrososft Store, you can follow the following steps:
1. Install [XBOX Desktop](https://www.xbox.com/en-US/apps/xbox-app-on-pc) like installing regular programs
2. It will gives you a pop-up that requiring Microsoft Store
3. Click "Install Microsoft Store" and follow the instruction. 
4. Done.

From Microsoft Store, install some basic apps:
- [Microsoft Image](https://apps.microsoft.com/detail/9wzdncrfjbh4?hl=en-us&gl=ID): Default Microsoft's Image Viewer
- [Microsoft ToDO](https://to-do.office.com/tasks/): Simple to-do list app By Microsoft

Insttead of using Microsoft Store, I prefered using `winget` or other Package Managers. Install the following essential applications:

## Essential Apps

| Package Name | Description                                                                                                     | Winget Command                                 |
| ------------ | --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| Bitwarden    | An open-source, cloud-based password manager that helps users store, manage, and share sensitive data, and more | `winget install --Id Bitwarden.Bitwarden -e`   |
| Chrome       | Web Browser, developed by Google                                                                                | `winget install --Id Google.Chrome -e`         |
| Edge         | Web Browser, developed by Microsoft                                                                             | `winget install --Id Microsoft.Edge -e`        |
| Firefox      | Web Browser, developed by Mozilla                                                                               | `winget install --Id Mozilla.Firefox -e`       |
| Files        | A FOSS File Explorer Alternative with extensive features and beautiful UI.                                      | `winget install --id FilesCommunity.Files -e`  |
| Notepad Apps | Modern, lightweight text editor with a fluent design.                                                           | `winget install --id JackieLiu.NotepadsApp -e` |
| VLC Player   | Free and open-source cross-platform multimedia player.                                                          | `winget install --id VideoLAN.VLC -e`          |

## Development Tools

| Package Name     | Description                                                          | Winget Command                                      |
| ---------------- | -------------------------------------------------------------------- | --------------------------------------------------- |
| Docker Desktop   | A container for building and sharing containerized app.              | `winget install --id Docker.DockerDesktop -e`       |
| Laragon          | Portable and powerful universal development environment.             | `winget install --id LeNgocKhoa.Laragon -e`         |
| Wezterm          | GPU-Accelerated Terminal Emulator; written in Rust                   | `winget install --Id wez.wezterm -e`                |
| Windows Terminal | Modern terminal application for command-line tools and shells.       | `winget install --id Microsoft.WindowsTerminal -e`  |
| VS Code          | A free, powerful, and lightweight code editor developed by Microsoft | `winget install -e --id Microsoft.VisualStudioCode` |

## Design Tools

| Package Name | Description                                         | Winget Command                             |
| ------------ | --------------------------------------------------- | ------------------------------------------ |
| Figma        | Collaborative interface design tool.                | `winget install --id Figma.Figma -e`       |
| Inkscape     | A free and open-source vector-based graphics editor | `winget install --id Inkscape.Inkscape -e` |

## Productivity Tools


| Package Name    | Description                                                                       | Winget Command                                     |
| --------------- | --------------------------------------------------------------------------------- | -------------------------------------------------- |
| Notion          | All-in-one workspace for notes, tasks, and collaboration.                         | `winget install --id Notion.Notion -e`             |
| Notion Calendar | Integrated calendar for Notion workspace.                                         | `winget install --id Notion.NotionCalendar -e`     |
| Obsidian        | A local-first, markdown-based personal knowledge base and note-taking application | `winget install --id Obsidian.Obsidian -e`         |
| Raindrop        | Bookmark manager to organize and sync across devices.                             | `winget install --id RustemMussabekov.Raindrop -e` |
| WhatsApp        | Cross-platform messaging and Voice over IP service.                               | `winget install --id WhatsApp.WhatsApp -e`         |
| Zoom            | Video Conferencing App                                                            | `winget install --Id Zoom.Zoom -e`                 |

## Utilities

| Package Name      | Description                                            | Winget Command                                 |
| ----------------- | ------------------------------------------------------ | ---------------------------------------------- |
| Character Map UWP | Modern UWP replacement for the classic Character Map.  | `winget install --id 9WZDNCRDXF41 -e`          |
| Lightshot         | Fast and easy screenshot tool.                         | `winget install --id Skillbrains.Lightshot -e` |
| Nilesoft Shell    | Powerful context menu manager for Windows.             | `winget install --id Nilesoft.Shell -e`        |
| ShareX            | Screen capture, file sharing, and productivity tool.   | `winget install --id ShareX.ShareX -e`         |
| WinRAR            | Powerful archive manager supporting RAR and ZIP files. | `winget install --id RARLab.WinRAR -e`         |

```sh
winget install --id Bitwarden.Bitwarden -e --silent
&& winget install --id Google.Chrome -e --silent
&& winget install --id Microsoft.Edge -e --silent
&& winget install --id Mozilla.Firefox -e --silent
&& winget install --id FilesCommunity.Files -e --silent
&& winget install --id JackieLiu.NotepadsApp -e --silent
&& winget install --id VideoLAN.VLC -e --silent
&& winget install --id Docker.DockerDesktop -e --silent
&& winget install --id LeNgocKhoa.Laragon -e --silent
&& winget install --Id wez.wezterm -e --silent
&& winget install --id Microsoft.WindowsTerminal -e --silent
&& winget install --id Microsoft.VisualStudioCode -e --silent
&& winget install --id Figma.Figma -e --silent
&& winget install --id Inkscape.Inkscape -e --silent
&& winget install --id Notion.Notion -e --silent
&& winget install --id Notion.NotionCalendar -e --silent
&& winget install --id Obsidian.Obsidian -e --silent
&& winget install --id RustemMussabekov.Raindrop -e --silent
&& winget install --id WhatsApp.WhatsApp -e --silent
&& winget install --id Zoom.Zoom -e --silent
&& winget install --id 9WZDNCRDXF41 -e --silent
&& winget install --id Nilesoft.Shell -e --silent
&& winget install --id Skillbrains.Lightshot -e --silent
&& winget install --id ShareX.ShareX -e --silent
&& winget install --id RARLab.WinRAR -e --silent
```
# Command Line Tools

In the other hand, there are some applications that run without a Graphical User Interface (GUI) that support the software development experience. These applications are usually some utilities, essential tools, and some other tools that can improve our productivity workflow in the development process. 

| Package Name | Command     | Description                                                                                                   | Winget Command                                   |
| ------------ | ----------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| bat          | `bat`       | A `cat` clone with syntax highlighting and Git integration.                                                   | `winget install --id sharkdp.bat -e`             |
| btop         | `btop`      | A resource monitor that shows usage and stats for processor, memory, disks, network, processes, and services. | `winget install --Id aristocratos.btop4win -e`   |
| delta        | `delta`     | A syntax-highlighting pager for git, diff, and grep output.                                                   | `winget install --id dandavison.delta -e`        |
| fd-find      | `fd`        | A simple, fast, and user-friendly alternative to `find`.                                                      | `winget install --id sharkdp.fd -e`              |
| fzf          | `fzf`       | A general-purpose command-line fuzzy finder.                                                                  | `winget install --id junegunn.fzf -e`            |
| Git          | `git`       | A distributed version control system for tracking changes in source code.                                     | `winget install --id Git.Git -e`                 |
| Lazygit      | `lazygit`   | A simple terminal UI for git commands.                                                                        | `winget install --id JesseDuffield.lazygit -e`   |
| LLVM         | `llvm`      | A Project of bundling C Compiler developed by Illinoise Uni Student                                           | `winget install --id LLVM.LLVM -e`               |
| Neovim       | `nvim`      | A hyperextensible Vim-based text editor.                                                                      | `winget install --id Neovim.Neovim -e`           |
| Node.js LTS  | `node`      | A JavaScript runtime built on Chrome's V8 JavaScript engine.                                                  | `winget install --id OpenJS.NodeJS.LTS -e`       |
| Nushell      | `nu`        | A new type of shell that focuses on structured data.                                                          | `winget install --id Nushell.Nushell -e`         |
| PowerShell   | `pwsh`      | A cross-platform task automation and configuration management framework.                                      | `winget install --id Microsoft.PowerShell -e`    |
| PowerToys    | `powertoys` | A set of utilities for power users to tune and streamline their Windows experience.                           | `winget install --id Microsoft.PowerToys -e`     |
| ripgrep      | `rg`        | A line-oriented search tool that recursively searches your current directory for a regex pattern.             | `winget install --id BurntSushi.ripgrep.MSVC -e` |
| Starship     | `starship`  | A minimal, blazing-fast, and infinitely customizable prompt for any shell.                                    | `winget install --id Starship.Starship -e`       |
| Superfile    | `superfile` | A modern terminal file manager.                                                                               | *Not available via winget*                       |
| zoxide       | `zoxide`    | A smarter `cd` command for your terminal.                                                                     | `winget install --id ajeetdsouza.zoxide -e`      |

```shell
winget install --id sharkdp.bat -e --silent 
&& winget install --id aristocratos.btop4win -e --silent 
&& winget install --id dandavison.delta -e --silent 
&& winget install --id junegunn.fzf -e --silent 
&& winget install --id Git.Git -e --silent 
&& winget install --id JesseDuffield.lazygit -e --silent
&& winget install --id LLVM.LLVM -e --silent
&& winget install --id Neovim.Neovim -e --silent 
&& winget install --id OpenJS.NodeJS.LTS -e --silent 
&& winget install --id Nushell.Nushell -e --silent 
&& winget install --id Microsoft.PowerShell -e --silent 
&& winget install --id Microsoft.PowerToys -e --silent 
&& winget install --id BurntSushi.ripgrep.MSVC -e --silent 
&& winget install --id Starship.Starship -e --silent 
&& winget install --id ajeetdsouza.zoxide -e --silent 
&& winget install --id sharkdp.fd -e --silent
```

Currently, Superfile (`spf`) is not yet available in the `winget` repo, instead you can use this official command or install it via `scoop`

```powershell
pwsh -ExecutionPolicy Bypass -Command "Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://superfile.netlify.app/install.ps1'))"
```

```sh
scoop add bucket main
scoop install main/superfile
```

# Miscellaneous

Most of these listed apps are not yet supported for installation via-Package Manager

- [Microsoft Office 365](https://office.com/): Regular Office Suite.
- [Affinity Creative Apps](https://affinity.serif.com): My Primary Graphic Design Tools.
- [Nitro Pro PDF](https://www.gonitro.com/): Powerfull PDF Viewer, Editor, and Converter.
- [Quick Share](https://www.android.com/intl/id_id/better-together/quick-share-app/): Seamlessly sharing files cross-devices.
- [Capacities](https://capacities.io): Yet another PKM Apps.
- [Everything](https://www.voidtools.com/): Locate files and folders by name instantly.
- [XNShell Extension](https://www.xnview.com/en/): Convert image file easily from context menu.
