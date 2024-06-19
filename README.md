# alarwasyi98 Terminal Look
These are my user-specific configuration files that I use to personalize my Windows experience.

## Prerequisites
- [Nerd Font](nerfonts.com) required!
- Actually a Shell Terminal. Whatever you have, but in my case, I use Windows Terminal with Powershell 7
- Starship installed. You can read their [documentation](https://starship.rs) to do this

## Installation
- Configure starship with make a directory that provide a ```starship.toml``` file. All configurations and customization will be done in it.
- Open terminal and run this command 
``` 
mkdir -p $HOME/.config && touch $HOME/.config/starship.toml 
```
- Open it with your loved Code Editor or even Notepad and Copy the template in my ```.starship``` folder.
- Enjoy!
### Windows Terminal Configuration 
If you same as me that using Powershell as the primary terminal in your machine, you have to do this: 
  - Make a folder called "Powershell" in your ```Documents``` folder
  - Run this command:

```
notepad $SHELL
```
  -  You will notice that your computer is automatically open a Notepad Windows. Copy my setting in ```.pwsh``` folder