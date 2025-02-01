# WSL basics



## Installing WSL
* TODO: WSL setup / link
List available distros to install:
```powershell
wsl --list --online
```

Install specific distro:
```powershell
# wsl --install -d <DistroName> 
wsl --install -d Debian
```


## Backing up WSL
Back up WSL distro and contents to a tarball:
```powershell
wsl --export (distribution) filename.tar
```

e.g.
```powershell
wsl --export "Debian" "Debian.wsl-backup.tar"
```

## Basic WSL usage

Can run commands from default WSL distro by prefixing with `wsl`:
```powershell
wsl man man
```


## WSL Filepaths
Filepaths to access WSL2 locations:
```path
\\wsl$\<DistroName>\home\<UserName>\Project
```
[Example link to a local WSL distro named ""](\\wsl$\debian\home\purplesmart\)

You may want to create a shortcut to your WSL homedir to easily get there from Windows. To do that in powershell:
```powershell
$WshShell = New-Object -COMObject WScript.Shell;
$Shortcut = $WshShell.CreateShortcut("${Env:USERPROFILE}\Desktop\WSL_Debian_My-WSL-User.lnk");
$Shortcut.TargetPath = "\\wsl$\Debian\home\My-WSL-User\Project";
$Shortcut.Save();
```
Explaination links for shortcut:
* https://stackoverflow.com/questions/9701840/create-a-shortcut-lnk-file-using-powershell
* https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.4#creating-a-desktop-shortcut-with-wscriptshell
* https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.4
* https://learn.microsoft.com/en-us/previous-versions/windows/desktop/legacy/bb776890(v=vs.85)
* https://learn.microsoft.com/en-us/windows/win32/com/using-com-objects-in-windows-script-host
* https://old.reddit.com/r/PowerShell/comments/mdykzz/what_does_newobject_comobject_wscriptshell_do/



## Tweaks for WSL ease of life
#### Install packages

Installing 
```bash
sudo apt update && sudo apt upgrade
sudo apt install nano vim screen tmux byobu curl wget rsync ssh gnupg python3 python3-pip ansible
```

To install many packages from a list file:
```bash
## Long args:
grep --perl-regexp --ignore-case --invert-match --file="wsl-debian-packages.txt" --regexp='^#'  | sudo xargs --open-tty --no-run-if-empty apt install -y
## Shortened args:
grep -pivf "wsl-debian-packages.txt" -e '^(#|;|/|\r|\n)' | sudo xargs -or apt install -y
```
* "examples\wsl\wsl-debian-packages.txt"


#### Customize sudo
To safely edit `/etc/sudoers` file:
```bash
sudo visudo
```

`sudo` group can use sudo without typing their password:
```sudoers
## Passwordless sudo.
%sudo  ALL=(ALL)       NOPASSWD: ALL
```

Make it easier to tell if your password entry is misbehaving:
```sudoers
## Display hint as you type to indicate typing was registered.
Defaults	pwfeedback
```

Custom auth inactivity expiry time:
```sudoers
## Period in minutes of sudo inactivity before auth expires: 
Defaults	timestamp_timeout=120
```

#### Bashrc file


#### Custom scripts install dir
For only one user: `~/bin/`



