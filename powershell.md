# Powershell


### Command history
(Like `~/.bash_history` on linux does)
* TODO: Figure this out.


## General Powershell

Show Powershell Version:
```powershell
$PSVersionTable
```

### Installing / Updating powershell
* TODO: Installing latest version.

See official docs page on how to install Powershell for alternative methods and more information ["Installing PowerShell on Windows" (Powershell docs)](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)

To install current stable release version of Powershell via Winget:
```powershell
winget install --id Microsoft.PowerShell --source winget
```
["Install PowerShell using Winget (recommended)"](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#install-powershell-using-winget-recommended)


### Writing Powershell scripts
* TODO: Examples of decent quality Powershell scripts.
* TODO: Links to guides.

See examples in: `examples\powershell\`


### Running Powershell scripts
* TODO: Security policy and how to bypass it.
* TODO: Running powershell scripts
* TODO: User-placed scripts location etc. ala $PATH on linux.


### Using Microsoft documentation
* TODO: Explain using official Powershell docs.
* TODO: Explain hunting down Microsoft docs pertinent to whatever task may be - often need to settle with using docs listed as for older Windows versions or marked as outright obsolete.

In general a web search like "Bing" or "Google" is better at finding pertinent documentation than the search box on Microsoft's site.

Many windows components have behaved largely the same across versions, so documentation for older versions of windows is frequently very useful and may contain correct information absent from the documentation for the latest versions of Windows, etc.


### Using COM objects in Powershell
* TODO: flesh out conceptual description and examples. (EXPLAIN: What is a COM object)
* https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.4#creating-a-desktop-shortcut-with-wscriptshell
See example in: `examples\powershell\minimal-create-shortcut.ps1`
* TODO: Web Links.


### Using WMI objects in Powershell
* TODO: EXPLAIN: What is a WMI object
* TODO: Copy in examples.
* TODO: Web Links.


## Remote Powershell
Using powershell to access another computer.

### Use Powershell via SSH / sshd
* TODO: FOO.

#### Install windows SSHD
How to install `ssh` and `sshd` (OpenSSH) for Windows.

To install OpenSSH for Windows: (In admin Powershell)
```powershell
## Check if openssh is already installed:
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'


# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server


# Start the sshd service
Start-Service sshd

# OPTIONAL but recommended:
## Set the service for SSHD to start automatically:
Set-Service -Name sshd -StartupType 'Automatic'

## Setup Windows firewall rules to permit incoming SSH traffic:
# Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
    Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
    New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
} else {
    Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
}
```
* ["Install OpenSSH for Windows Server"](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2022#tabpanel_2_powershell)
* ["Enable OpenSSH for Windows Server 2025"](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=powershell&pivots=windows-server-2025#tabpanel_1_powershell)


#### Reccomended basic configuration for Windows SSHD
How to do the basics of securing your system's SSH stuff.

Require pubkey based auth, disable password login, 

Default Windows sshd config file location is: `%programdata%\ssh\sshd_config` i.e. `${Env:ProgramData}\ssh\sshd_config`

* TODO: Example windows sshd_config file.
* ["OpenSSH Server configuration for Windows Server and Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration)


#### Granting inbound SSH access for a regular Windows user account
How to enable a Windows account to recieve SSH logins.
* ["AuthorizedKeysFile"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#authorizedkeysfile)

A user's public key goes in: `%USERPROFILE%/.ssh/authorized_keys` i.e. `${Env:USERPROFILE}/.ssh/authorized_keys`


#### Granting inbound SSH access for an Administrator Windows user account
Admin accounts are slightly more complicated than non-admin accounts.

Administrators also must have their key in the Administrators authorized_keys file: `%programdata%/ssh/administrators_authorized_keys` i.e. `${Env:ProgramData}/ssh/administrators_authorized_keys`

Administrative actions require the key to be present in `administrators_authorized_keys`

So your admin account's pubkey must be in both:
- User-specific authorized_keys file: `%USERPROFILE%/.ssh/authorized_keys` i.e. `${Env:USERPROFILE}/.ssh/authorized_keys`
- Administrators authorized_keys file: `%programdata%/ssh/administrators_authorized_keys` i.e. `${Env:ProgramData}/ssh/administrators_authorized_keys`


#### Permissions for config files
* TODO: Explain concepts RE windows permissions.
* TODO: Permissions expected for `ssh` / `sshd` - related files.
* TODO: copypasta - "fix permissions"


#### misc windows SSHD
* TODO: windows authorized_keys and quirks (administrators special case)
* TODO: Disable password auth.
* TODO: ssh-keygen.
* TODO: ssh-add-key.
* TODO: GNUPG agent
* TODO: GPG smartcard auth.
* TODO: FIDO dongle auth.
* TODO: CCID smartcard auth?
* TODO: TPM-based auth?
* TODO: HSM-based auth?
* TODO: Phone SIM-based auth? (If even possible as more than a shitty source of static password via serial number.)
* TODO: host keys and host-based auth and host based validation; overview on each and clearly differentiate properties and uses of each.

* TODO: Copy in and write more docs and examples for Yubikey USB-smartcard-dongle.

* TODO: Git + Windows SSH.
* TODO: Getting Windows SSH, Windows SSHD, gnupg-agent, pagent, PuTTY, etc. to work together decently.

* TODO: Helper `Windows (Scheduled Task|Service|Scheduled Job|etc.)` to automaate resolving various issues.
* TODO: Autostart programs with Windows.
* TODO: Per-user ssh-agent socketfiles; figure out how to make admin powershell play nice with user-level auth somehow?

* TODO: `.ssh/config` and `.ssh/config.d`
* TODO: `.ssh/known-hosts` and quick-fix troubleshooing for common issues (e.g. mismatch).
* TODO: Accessing the vaarious pertinent logs and how to enable logging mode(s).
* TODO: Windows firewall and port forwarding from Windows through to VMs / WSL (In both directions).
* TODO: Automaating password entry.
* TODO: relevant .rc files and similar, for configuring utils pertinent to ssh activities.
* TODO: SFTP.
* TODO: FTP.
* TODO: TFTP.
* TODO: Using SSH connections / tunnels with various programs.

* TODO: Ansible as target, may be better with ansible docs?


#### Powershell as default shell for incoming SSH TTY sessions
To set Powershell as the shell used for incoming SSH sessions:
```powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
```
* ["Configuring the default shell for OpenSSH in Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows)

* https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/ssh-remoting-in-powershell?view=powershell-7.4
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
* https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration


#### outgoing ssh config
* TODO: `.ssh/config` and `.ssh/config.d`
Used to define, remember, alias, etc. your SSH destinations.
* ["OpenSSH Server configuration for Windows Server and Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows)
* [OpenBSD ssh_config manual page"](https://man.openbsd.org/ssh_config)
* [OpenBSD sshd_config manual page"](https://man.openbsd.org/sshd_config)


### Maintenance tasks
* TODO: Software updates / upgrades (winget, etc.)

To upgrade packages on/via winget:
```powershell
winget upgrade
```

* TODO: Periodic key management tasks.
* TODO: Recovery key management tasks.


#### Controlling network via netsh

provide wlan status:
```powershell
netsh wlan show interfaces
```

Disconnect wlan:
```powershell
netsh wlan disconnect
```

* ["Network shell (netsh)"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh)
* ["Netsh command syntax, contexts, and formatting"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-contexts)
* ["Network Shell (Netsh) Example Batch File"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-wins)
* ["Netsh Mobile Broadband Network commands"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-mbn)


#### Finding devices - COM ports
Getting a list of serial / parllel / COM ports in windows Powershell.

By type `Win32_SerialPort`:
```powershell
Get-WmiObject Win32_SerialPort | Select-Object deviceid
```

By ClassGuid:
```powershell
$lptAndCom = '{4d36e978-e325-11ce-bfc1-08002be10318}'
get-wmiobject -Class win32_pnpentity | where ClassGuid -eq $lptAndCom | select name
```
- Methods found at: https://stackoverflow.com/questions/40370167/list-of-all-com-ports-shown-in-device-manager-by-using-powershell
- List of ClassGuid values: https://learn.microsoft.com/en-us/windows-hardware/drivers/install/system-defined-device-setup-classes-available-to-vendors


## Loading DLLs in Powershell
Example:
```powershell
$DrawingGraphics = [Drawing.Graphics]::FromImage($ScreenshotObject)
```
Genric form:
```powershell
$ResultObject = [NamespacedAPI]::Method(Arguments)
```
* ["Add-Type" - "Adds a Microsoft .NET class to a PowerShell session." (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-7.5)
* ["Add-Type" "Example 4: Call native Windows APIs" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-7.5#example-4-call-native-windows-apis)
* ["about_Using" - "Allows you to specify namespaces to use in the session." (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_using?view=powershell-7.5)
* ["about_Using" "Example - Add namespaces for typename resolution" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_using?view=powershell-7.5#example---add-namespaces-for-typename-resolution)
* ["Use DLL files in PowerShell"](https://tekcookie.com/use-dll-files-in-powershell/)
* Also examples of using DLL / dotnet in powershell: ["JocysCom/FocusLogger/blob/main/Solution_Cleanup.ps1"](https://github.com/JocysCom/FocusLogger/blob/main/Solution_Cleanup.ps1)

Examples of using inline csharp: 
* ["PowerSploit - A PowerShell Post-Exploitation Framework" "github:PowerShellMafia/PowerSploit"](https://github.com/PowerShellMafia/PowerSploit)
* ["Get-TimedScreenshot.ps1" "github:PowerShellMafia/PowerSploit"](https://github.com/PowerShellMafia/PowerSploit/blob/master/Exfiltration/Get-TimedScreenshot.ps1) (Pertinent lines of "Get-TimedScreenshot.ps1" (lines 72-75))[https://github.com/PowerShellMafia/PowerSploit/blob/d943001a7defb5e0d1657085a77a0e78609be58f/Exfiltration/Get-TimedScreenshot.ps1#L72C8-L72C75]

----------


## Files
Files in this repo relating to PowerShell.

- Powershell example scripts dir ["examples/powershell"](<##/examples/powershell>)
- Script to hash files it's pointed at, intended to make notekeeping easier: ["hash-files.ps1"](<##/examples/powershell/hash-files.ps1>)


## Links
* TODO: Copy bookmark links to here.
* TODO: Copy links from my other documentation to here.
* TODO: Copy links from my scripts to here.
* TODO: Links to my related scripts.


### Official Microsoft Powershell documentation (Links)
Documentation produced or published by Microsoft specifically about Powershell.
* ["PowerShell Documentation"](https://learn.microsoft.com/en-us/powershell/?view=powershell-7.4)
*  ["Installing PowerShell on Windows" (Powershell docs)](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4)

* ["What is PowerShell?" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.4)
* "Describes how to use the try, catch, and finally blocks to handle terminating errors." ["about_Try_Catch_Finally" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally?view=powershell-7.4)

* ["about_CimSession" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_cimsession?view=powershell-7.4)
* ["CDXML definition and terms" (learn.microsoft.com)](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/wmi_v2/cdxml-overview)
* ["New-CimSession" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/new-cimsession?view=powershell-7.4)

* ["about_PSSessions" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_pssessions?view=powershell-7.4)

* ["about_Logical_Operators" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-7.4)
* ["about_Operators" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4)
* ["ForEach-Object" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.4)
* ["ConvertTo-Json" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7.4)
* ["Add-Type" (learn.microsoft.com)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/add-type?view=powershell-7.5)

- ["about_operators"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.5)
- ["about_logical_operators"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-5.1)
- ["about_comparison_operators"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.5)

- ["about_hash_tables"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.5)

- ["where-object"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/where-object?view=powershell-5.1)
- ["get-childitem"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.5)

- ["about_filesystem_provider"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_filesystem_provider?view=powershell-7.5)
- ["about_registry_provider"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_registry_provider?view=powershell-7.5)

- ["join-path"](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/join-path?view=powershell-7.5)

- ["TITLE"](LINK)
- ["TITLE"](LINK)
- ["TITLE"](LINK)
- ["TITLE"](LINK)
- ["TITLE"](LINK)
- ["TITLE"](LINK)


### Official Microsoft documentation - adjactent (Links)
Documentation produced or published by Microsoft not directly pertaining to Powershell.
* ["Networking documentation"](https://learn.microsoft.com/en-us/windows-server/networking/)


#### openssh on Windows (Links)
* ["Configuring the default shell for OpenSSH in Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows)
* https://learn.microsoft.com/en-us/powershell/scripting/security/remoting/ssh-remoting-in-powershell?view=powershell-7.4
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
* https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration
* ["AuthorizedKeysFile"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#authorizedkeysfile)
* ["Configuring the default shell for OpenSSH in Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows)
* ["OpenSSH Server configuration for Windows Server and Windows"](https://learn.microsoft.com/en-us/windows-server/administration/OpenSSH/openssh-server-configuration#configuring-the-default-shell-for-openssh-in-windows)
* [OpenBSD ssh_config manual page"](https://man.openbsd.org/ssh_config)
* [OpenBSD sshd_config manual page"](https://man.openbsd.org/sshd_config)


#### netsh (Links)
* ["Network shell (netsh)"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh)
* ["Netsh command syntax, contexts, and formatting"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-contexts)
* ["Network Shell (Netsh) Example Batch File"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-wins)
* ["Netsh Mobile Broadband Network commands"](https://learn.microsoft.com/en-us/windows-server/networking/technologies/netsh/netsh-mbn)


### "WINDOWS_VERSION Forums" group of webforums (Links)
Quite a useful resource for finding tricks and ways to do tasks.
* https://www.vistax64.com/
* https://www.eightforums.com/
* https://www.sevenforums.com/
* https://www.tenforums.com/
* https://www.elevenforum.com/



### Unsorted links

* [List of Windows DLLs](https://gist.github.com/Samirbous/9f9c3237a0ada745e71cc2ba3425311c)
* https://docs.microsoft.com/en-gb/windows/win32/api/winuser/
* https://github.com/JocysCom/FocusLogger/blob/7539d82252b17d87ecc3272f352878795d1be117/FocusLogger/Common/NativeMethods.cs#L18

- `Resolve-Path -Relative` https://stackoverflow.com/questions/12396025/how-to-convert-absolute-path-to-relative-path-in-powershell
- Capture output of program as array of strings: `[string[]] $MyArray = Command;` https://stackoverflow.com/questions/8097354/how-do-i-capture-the-output-into-a-variable-from-an-external-process-in-powershe

