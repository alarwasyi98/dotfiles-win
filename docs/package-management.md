
## [WinGet](https://learn.microsoft.com/en-us/windows/package-manager/winget/#install-winget)

A package manager command-line tool powered officially by Windows that enabling users to discover, install, upgrade, remove and configure applications on Windows Machine. This tool was installed by default on Windows 10 and Windows 11. However, you can run this PowerShell command to request WinGet registration:

```powershell
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe
```

Run `winget --help` and verify that Winget is running properly.

```
winget --help
```

## [Chocolatey](https://chocolatey.org/)

Chocolatey (`choco`) is popular package repostory around Windows community. It gives us speed and simplicity of building a package. Not stop there, chocolatey offers deployment tool and package building on their repository.  

It can be installed by running the following oneliner command. It will installing chocolatey community version because of chocolatey is basicly paid service. 

```powershell
# copy and paste the following command
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# verify installation by running:
choco -?
```
## [Scoop](https://scoop.sh)

Scoop is a Command-Line Installer for Windows that focused on developer tools building packages like [Zed](https://zed.dev), [Node](https://nodejs.org/), [Go](https://go.dev/). Its uses GitHub repository as `bucket` of the apps. 

Before installing `scoop`, make sure you set the `ExecutionPolicy` to `RemoteSigned` by running this command:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

After that, we can install scoop seamlessly with this simple command:

```powershell
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

Verify scoop installation by adding some basic `bucket`

```sh
scoop bucket add main
scoop bucket add extras
```

## [Windows Utility](https://christitustech.github.io/winutil/) 

This utility is provided by Chris Titus Tech. Windows Utility is a go-to utility for optimizing and managing your Windows environment. Whether you’re an IT professional, power user, or regular user, WinUtil provides a comprehensive set of tools to enhance your Windows experience. 

To install it, simply run this command on PowerShell terminal as Administrator.

```powershell
Invoke-RestMethod https://christitus.com/win | Invoke-Expression
```

A handy way to check all the required program is by importing a `JSON` file that contains all requiered packages in this setup.  refer to: [winutil.json](https://github.com/alarwasyi98/dotfiles-win/blob/main/winutil.json)
