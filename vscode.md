# VSCode - Visual Studio Code - Tolerable IDE


## Installation
* Official help: ["Setting up Visual Studio Code"](https://code.visualstudio.com/docs/setup/setup-overview)
* https://code.visualstudio.com/download


### Installation on Windows
* https://code.visualstudio.com/docs/setup/windows
* https://code.visualstudio.com/download

Intalling via `winget`:
```powershell
winget show Microsoft.VisualStudioCode

winget install Microsoft.VisualStudioCode
```


### Installation on linux (dnf)
Fedora-like distros that use `dnf`. e.g. Fedora, Centos, RHEL, Rocky, Alma. 

Install certificates and repository information:
```bash
## Install Miscrosoft's public key for the repository:
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

## Create config file with Miscrosoft's yum/dnf repository information:
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
```

Install VSCode package from repository:
```bash
## Reload information about what repository has what packages:
sudo dnf check-update

## Actually perform the install of the new package:
sudo dnf install code 
```
* https://code.visualstudio.com/docs/setup/linux#_rhel-fedora-and-centos-based-distributions


### Installation on linux (apt)
Debian-like distros that use apt. e.g. Debian, Ubunto, Mint, RaspberryPiOS.
* https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions


## Configuration
User settings GUI:
To get to settings GUI: `F1 -> 'settings' -> "Preferences: Open settings (UI)"`

User settings JSON:
Linux: `~/.config/FIXME`  (TODO: Verify canonical location(s))
Windows: `%APPDATA%\Code\User\settings.json` (TODO: Verify canonical location(s))

Workspace  settings JSON:
`Your_Workspace_name.code-workspace`
`.vscode/settings.json`


### Basic configuration
The stuff you should do the first time you open VSCode up.


#### Privacy optouts  (Basic level config)
* TODO: Privacy optouts.
In `Settings`  Set `Telemetry: Telemetry Level` to `Off`

(Equivalent to) In `settings.json`: `"telemetry.telemetryLevel": "off",`


#### Autocomplete and autosuggest (Basic level config)
* TODO: Autocomplete / autosuggest.
* `settings.json`: `"editor.autoClosingQuotes": "never",`


### Advanced global configuration
Linux: `~/.config/FIXME`  (TODO: Verify canonical location(s))
Windows: `%APPDATA%\Code\User\settings.json` (TODO: Verify canonical location(s))


#### SSH destinations (Intermediate level config)
* TODO: SSH config file.
```bash
~/.ssh/config
```

Powershell style:
```powershell
${Env:USERPROFILE}/.ssh/config
```

CMD style
```
%USERPROFILE%/.ssh/config
```


### Workspace configuration
* TODO: `.code-workspace` basics.
* TODO: `.code-workspace` intermediate detail.
* TODO: `.vscode/` and contents.
* TODO: Per-project execute and debug configuration.
* TODO: Example: Run project in WSL.
* TODO: Example: Run project on linux LAN server.


## Dev Containers
Using containers for development.


## Reference for troubleshooting
* https://code.visualstudio.com/docs/editor/variables-reference


## Extentions
This grew large enough to require it's own seperate file.
[VSCode Extentions](./vscode.md)


## Links
Links relating to VSCode.
* [VSCode Variables reference](https://code.visualstudio.com/docs/editor/variables-reference)
* ["Integrate with External Tools via Tasks"](https://code.visualstudio.com/docs/editor/tasks)
* ["Setting up Visual Studio Code"](https://code.visualstudio.com/docs/setup/setup-overview)
* DESCRIPTION [LINK_TEXT](LINK_URL)


## WSL (Windows Subsystem for Linux) (Links)
* https://learn.microsoft.com/en-us/windows/wsl/install
* https://learn.microsoft.com/en-us/windows/wsl/setup/environment#set-up-your-linux-username-and-password
* https://www.windowscentral.com/how-install-wsl2-windows-10
* https://rjtech.dev/blog/fedora-38-on-wsl2/
* https://stackoverflow.com/questions/38776137/native-tar-extraction-in-powershell#46876070


## Unsorted links
https://code.visualstudio.com/docs/remote/ssh
https://code.visualstudio.com/docs/remote/linux
https://code.visualstudio.com/docs/remote/troubleshooting
https://code.visualstudio.com/docs/remote/faq




