## minimal-create-shortcut.ps1
<#
.SYNOPSIS
    A minimal example of creating a Windows shortcut in powershell.
.NOTES
    Further reading / sources:
    * https://stackoverflow.com/questions/9701840/create-a-shortcut-lnk-file-using-powershell
    * https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.4#creating-a-desktop-shortcut-with-wscriptshell
    * https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.4
    * https://learn.microsoft.com/en-us/previous-versions/windows/desktop/legacy/bb776890(v=vs.85)
    * https://learn.microsoft.com/en-us/windows/win32/com/using-com-objects-in-windows-script-host
    * https://old.reddit.com/r/PowerShell/comments/mdykzz/what_does_newobject_comobject_wscriptshell_do/
.NOTES
    Author: Ctrl-S
    Created: 2024-12-18
    Modified: 2024-12-18
#>

## Get a 'WScript.Shell' COM Object.
$WshShell = New-Object -COMObject WScript.Shell;

## Invoke the 'CreateShortcut' method of 'WScript.Shell' specifying the location to place the shortcut.
$Shortcut = $WshShell.CreateShortcut("$Home\Desktop\WSL_Debian_My-WSL-User.lnk");

## Set the 'TargetPath' value to the shortcut target.
$Shortcut.TargetPath = "\\wsl$\Debian\home\My-WSL-User\Project";

## Commit the changes to the new shortcut by calling the 'Save' method.
$Shortcut.Save();

