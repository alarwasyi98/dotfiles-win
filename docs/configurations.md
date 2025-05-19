
# Program Configuration

This section provides instructions and custom configuration examples for essential tools in your Windows development environment. Each section contains the configuration file location and key customizations applied

## Windows Terminal

* **Config File**: `Microsoft.PowerShell_Profile.ps1`
* **Location**: `C:\Users\username\Documents\PowerShell`
* **Dependencies**: Nerd-Fonts

## WezTerm

* **Config File**: `wezterm.lua`
* **Location**: `$ENV:USERPROFILE\.config\wezterm`
* **Dependencies**: Nerd-Fonts

## Git

* **Config File**: `.gitconfig`
* **Location**: `$ENV:USERPROFILE\.gitconfig`
* **Dependencies**: Lazygit, Delta

Git is the version control system (VCS) designed and developed by Linus Torvalds, the creator of the Linux kernel. Git is now used to maintain AUR packages, as well as many other projects, including sources for the Linux kernel.

`~/.gitconfig` or `~/.config/git/config` file: Values specific personally to you, the user. You can make Git read and write to this file specifically by passing the `--global` option, and this affects all of the repositories you work with on your system. Instead, use `--local` to read and write in specific repository.

I've configured `git` with these command. I wrote git settings as command intentionally so you can execute them individually and know what it does.

```sh
# 1 Setup user identity
git config --global user.name "$yourname"
git config --global user.email "$useremail"
# 2 Set core behaviour
git config --global core.editor "code"
git config --global core.pager "delta"
git config --global core.autocrlf false
git config --global core.symlinks true
git config --global core.longpaths true
# 3 Set default branch name
git config --global init.defaultBranch main
# 4 Set credential helper (read more: https://git-scm.com/docs/git-credential)
git config --global credential.helper store
# 5 Set UI color
git config --global color.ui auto
# 6 Set VS Code as default difftool
git config --global difftool.default-difftool.cmd "code --wait --diff \$LOCAL \$REMOTE"
git config --global difftool.default-difftool.cmd "code --wait --diff \$LOCAL \$REMOTE" # safer repeat due to nested key
# 7 Set merge and pull option
git config --global merge.renamelimit 99999
git config --global merge.conflictstyle zdiff3 # delta setting
git config --global pull.rebase true
# 8 Fetch optimization
git config --global fetch.parallel 0
# 9 Git Aliases
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
# 10 delta-git diff setting
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
```

Otherwise, you can craft your own script to automate these configuration automatically.

## Neovim

* **Config File**: `init.lua` 
* **Location**: `$ENV:LOCALAPPDATA\nvim`
* **Dependencies**: C Compiler, Fzf, fd-find, ripgrep, Nerd-Fonts, lazygit (optional)

Neovim is a modern, highly extensible text editor that's a fork of the original Vim editor, built to be more flexible and easier to use. It's designed for programmers and other users who need a powerful, customizable editor for various tasks, including writing code, editing text files, and more.

### LazyVim Installation

LazyVim: Setting up Neovim from scratch can be a bit daunting, as it requires configuring many things manually. LazyVim is a "Neovim distribution" (often called a "distro"). It comes pre-configured with a lot of sensible defaults, useful plugins, and a nice interface, making it much easier to get started. Here's the steps:

* Backup and even remove your current configuration
  
  ```powershell
  Move-Item $env:LOCALAPPDATA\\nvim $env:LOCALAPPDATA\\nvim.bak
  
  # Optional but remommended to avoid conflicts
  Move-Item $env:LOCALAPPDATA\\nvim-data $env:LOCALAPPDATA\\nvim-data.bak
  ```

* Clone the starter or you can clone the configured file
  
  ```powershell
  # Clone the Starter Boilerplate
  git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
  # Otherwise, you can use mine
  git clone https://github.com/alarwasyi98/neovim $env:LOCALAPPDATA\nvim
  ```
  
* Remove `.git` folder, so you can add your repo later
  
  ```powershell
  Remove-Item $env:LOCALAPPDATA\\nvim\\.git -Recurse -Force
  ```
  
* Start Neovim
  
  ```powershell
  nvim
  ```

    You will prompted to installation process. If there's any error, try to quit and restart neovim. Don't worry, as long as every requirement installed, there will not be any error appear. 

### Configure, Add, and Overriding Plugins

The files `autocmds.lua`, `keymaps.lua`, `lazy.lua` and `options.lua` under `lua/config` will be automatically loaded at the appropriate time, so you don't need to require those files manually. LazyVim comes with a set of default config files that will be loaded before your own

```sh
~/.config/nvim
├── lua
│   ├── config
│   │   ├── autocmds.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   │   └── options.lua
│   └── plugins
│       ├── spec1.lua
│       ├── **
│       └── spec2.lua
└── init.lua
```

> [!caution]
> Do not require `autocmds`, `keymaps`, `lazy` or `options` under `lua/config` or `lazyvim.config` manually. LazyVim will load those files automatically.


## NuShell

* **Config File**: `config.nu`
* **Location**: `$ENV:APPDATA\nushell`
* **Dependencies**: None


## PowerShell

* **Config File**: `Microsoft.PowerShell_Profile.ps1`
* **Location**: `$ENV:USERPROFILE\Documents\PowerShell`
* **Dependencies**: Terminal, Nerd-Fonts

## Starship

* **Config File**: `starship.toml`
* **Location**: `$ENV:USERPROFILE\.config\starship`
* **Dependencies**: Nerd-Fonts, Terminal, Shell

## Superfile

* **Config File**: `config.toml`
* **Location**: `$ENV:LOCALAPPDATA\superfile`
* **Dependencies**: ffmpeg, Nerd-Fonts. 

Superfile (`spf`) is sleek and visually appealing, making it a great choice for lightweight file or directory with excellent interface. 
