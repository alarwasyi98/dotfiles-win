# Minimalist Terminal Look
These are my user-specific configuration files that I use to personalize my Windows experience. This is first time for me to create a README file, so i'll explain these in dummy ways. 

## Prerequisites
- [Nerd Font](nerfonts.com) required! which I use currently is [UbuntuMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip)
- Of course, a Shell Terminal. Whatever you have, but in my case, I use Windows Terminal with [Powershell 7](https://github.com/PowerShell/PowerShell)
- Starship installed. You can read their [documentation](https://starship.rs) to do this

## Installation
- Install the [Nerd Font](nerfonts.com) you want. Or if you wanna install directly from my ```ubuntu_mono_install.sh``` , go ahead for it.
- Configure starship with make a directory that provide a ```starship.toml``` file. All configurations and customization will be done in it.
- <b>Powershell:</b> Open terminal and run this command 
``` PowerShell
mkdir -p $HOME/.config && touch $HOME/.config/starship.toml 
```
## Windows Terminal Configuration 
If you same as me that using Powershell as the primary terminal in your machine, you have to do this: 
  - Make a folder called "Powershell" in your ```Documents``` folder. Or if its exist;
  - Run this command:

``` shell
notepad $PROFILE
```
  -  You will notice that your computer is automatically open a Notepad Windows. Copy my setting in ```./.pwsh/Microsoft.PowerShell_Profile.ps1``` 
  -  Execute the ```starship.toml``` and apply the theme.
  -  Enjoy!
## Linux Bash Configuration
- If you are using [Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/about), you should through the different way to setup these terminal personalization. Here it is!
- Run [setup.sh](alarwasyi98/dotfiles/.bash/setup.sh) (this is optional, if you like to using old school way, go for it)
> The [setup.sh](alarwasyi98/dotfiles/.bash/setup.sh) is including: Starship Installation, Zoxide Installation, Fuzzyfinder Installation and another dependencies. But you still can provide to customize your own script! I use ChrisTitus Setup for this script. Read his [mybash Docs](https://github.com/ChrisTitusTech/mybash) 
- Make a Starship directory and configuration file:
``` bash
# create starship configuration 
mkdir -p ~/.config && touch ~/.config/starship.toml 
```
- Run command ```vim ~/.bashrc```, Click ```i``` and Add these lines to ```.bashrc```. Close vim by press ```esc```, ```:wq```
```bash
# Add the following to the end of ~/.bashrc
eval "$(starship init bash)"
```
- Open the ```starship.toml``` file with your loved Code Editor or even Notepad and Copy the template in my ```.starship``` folder.
- Enjoy!