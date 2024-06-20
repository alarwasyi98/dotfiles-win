# alarwasyi98 Terminal Look
These are my user-specific configuration files that I use to personalize my Windows experience.

## Prerequisites
- [Nerd Font](nerfonts.com) required! which I use currently is [UbuntuMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/UbuntuMono.zip)
- Of course, a Shell Terminal. Whatever you have, but in my case, I use Windows Terminal with [Powershell 7](https://github.com/PowerShell/PowerShell)
- Starship installed. You can read their [documentation](https://starship.rs) to do this

## Installation
- Install the [Nerd Font](nerfonts.com) you want. Or if you wanna install directly from my ```ubuntu_mono_install.sh``` , go ahead for it.
- Configure starship with make a directory that provide a ```starship.toml``` file. All configurations and customization will be done in it.
- <b>Powershell:</b> Open terminal and run this command 
``` 
mkdir -p $HOME/.config && touch $HOME/.config/starship.toml 
```
- <b>Bash</b>
``` 
# create starship configuration 
mkdir -p ~/.config && touch ~/.config/starship.toml 

# Add the following to the end of ~/.bashrc
eval "$(starship init bash)"
```
- Open the ```starship.toml``` file with your loved Code Editor or even Notepad and Copy the template in my ```.starship``` folder.
- Enjoy!
## Windows Terminal Configuration 
If you same as me that using Powershell as the primary terminal in your machine, you have to do this: 
  - Make a folder called "Powershell" in your ```Documents``` folder
  - Run this command:

```
notepad $PROFILE
```
  -  You will notice that your computer is automatically open a Notepad Windows. Copy my setting in ```.pwsh``` folder