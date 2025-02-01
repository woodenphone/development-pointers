# Powershell snippets
Collection of useful pieces of powershell code.

All code, commands, etc. is Powershell unless indicated otherwise.


## Powershell basics
Information on how to use powershell such as guides, tutorials, manuals, ect.
[Microsoft powershell overview](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.2)


## Informative
Snippets to get information.

Check if running as an administrator:
```powershell
(New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
```

### Show ENV
Show the current environment variables.
```powershell
Get-ChildItem Env: | Sort Name
```


### Get-ComputerInfo
Provides a variety of information about the system.
```powershell
Get-ComputerInfo | Sort Name
```


### Arguments as array
Prepare and pass arguments as an array.
Good for readability in scripts.
Note that the values need to be quoted and comma-seperated using normal powershell array syntax.
```powershell
# Create an array of strings to be passed as arguments:
$args_array = @(
	# ssh://user@host:port
    "ssh://someuser@10.1.1.120:22",
    '-f', '-N',
    # Port forwarding:
    '-L', "42069:10.1.120:42069",
    '-o', 'ExitOnForwardFailure=yes'
)

# Print the array's strings:
echo $args_array

# Invoke command, passing the array contents as arguments:
ssh $args_array
```

## Windows components
### Install SSH and SSHD
Install the windows components for the windows native versions of ssh and sshd (openssh).
Note that additional steps are required to configure openssh after it is intalled.
```powershell
# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```
[Microsoft OpenSSH install guide](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse)
[Microsoft OpenSSH configuration guide](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration)


## Hardware management


### Disable / enable touchscreen
Enable and disable the touchscreen.
Handy for when you have a laptop with touchscreen but don't want to deal with screwy inputs whenever you wipe the screen.
Roughly equivalent to enabling and disabling via the Windows Device Manager.
Must be run as administrator!

Disable touchscreen: (Admin PS)
```powershell
Get-PnpDevice -PresentOnly -Class "HIDClass" | Where-Object {$_.'FriendlyName' -like "*HID-compliant touch screen*"} | Disable-PnpDevice
```

Enable touchscreen: (Admin PS)
```powershell
Get-PnpDevice -PresentOnly -Class "HIDClass" | Where-Object {$_.'FriendlyName' -like "*HID-compliant touch screen*"} | Enable-PnpDevice
```


### Get BIOS info
```powershell
Get-CimInstance -ClassName Win32_bios | ConvertTo-Json -Depth 1
```


### Wifi / Wireless networking

```powershell
(netsh wlan show interfaces) -Match '^\s+Signal' -Replace '^\s+Signal\s+:\s+',''
```

```powershell
netsh wlan show interfaces
```


## Users and Groups
#### Listing users
List local user accounts:
```powershell
Get-LocalUser
```
[Get-LocalUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/get-localuser)

List user accounts (can act on remote hosts via WMI)
```powershell
Get-WmiObject -ComputerName workstation1 -Class Win32_UserAccount -Filter "LocalAccount=True"
```
[PowerShell Get-LocalUser to List All Local Users on Windows](https://www.lepide.com/how-to/list-all-user-accounts-on-a-windows-system-using-powershell.html)


#### Groups
List local groups:
```powershell
Get-LocalGroup
```
[Get-LocalGroup](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/get-localgroup)

Add some local user to a local group:
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "Admin02"
```
[Add-LocalGroupMember](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/add-localgroupmember)


### Create users
Create a local with password:
```powershell
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'User03'
    Password    = $Password
    FullName    = 'Third User'
    Description = 'Description of this account.'
}
New-LocalUser @params
```

Create a local that doesn't need a password:
```powershell
New-LocalUser -Name 'User02' -Description 'This account does not need a password.' -NoPassword
```
[New-LocalUser](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/new-localuser)

Give a local user local administrator privileges:
```powershell
Add-LocalGroupMember -Group "Administrators" -Member "Admin02"
```

Create a local administrator account:
```powershell
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'SpareAdmin'
    Password    = $Password
    FullName    = 'SpareAdmin'
    Description = 'Spare admin account'
}
New-LocalUser @params
Add-LocalGroupMember -Group "Administrators" -Member "SpareAdmin"
```


## Time and date
Produces format: `2024-10-24T18-24-15`
```powershell
Write-Host "The date is $(Get-Date -UFormat "%Y%m%dT%H%M%S")"
```

Produces format: `2024-10-24T18-24-15`
```powershell
$(Get-Date -UFormat "%Y-%m-%dT%H-%M-%S")
```

Produces format: `2024-10-24T18:29:16.2359320+08:00`
```powershell
Get-Date -Format o
```

Produces format: `2019-06-27T07.59.24.4603750-07.00`
```powershell
Get-Date -Format o | ForEach-Object { $_ -replace ":", "." }
```

Produces format: `2024-10-24T18-26-00.3873769+08-00`
```powershell
Get-Date -Format o | ForEach-Object { $_ -replace ":", "-" }
```

Produces format: `CHANGEME`
```powershell
Get-Date CHANGEME
```

* ["Get-Date" (microsoft.powershell.utility)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-date)


## dummy


## Misc
List WMI classes:
```powershell
Get-WmiObject -List
```


## Meta
Stuff for managing the document.


### TITLE
EXPLAINATION
```
COMMANDS
```
[LINK_TEXT](LINK_URL)
