## create-gpg-startup-shortcut.ps1
## 
## ========== ========== ========== ==========
## License: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2023-01-18
## MODIFIED: 2023-01-18
## ========== ========== ========== ==========
Write-Host "Creating shortcut"

## * https://learn.microsoft.com/en-us/powershell/scripting/samples/creating-.net-and-com-objects--new-object-?view=powershell-7.3
## * https://learn.microsoft.com/en-us/troubleshoot/windows-client/admin-development/create-desktop-shortcut-with-wsh
## * https://learn.microsoft.com/en-us/previous-versions//98591fh7(v=vs.85)
## * https://learn.microsoft.com/en-us/previous-versions//xk6kst2k(v=vs.85)
# Open comhost API and store reference to it
$WshShell = New-Object -ComObject WScript.Shell
## Create new shortcut
$ShortcutLocation = "${Env:AppData}\Microsoft\Windows\Start Menu\Programs\start-gpg-agent.lnk"
Write-Host "Creating shortcut at: $ShortcutLocation"
$lnk = $WshShell.CreateShortcut($ShortcutLocation)
$lnk.WindowStyle = 7 # 7 Minimizes the window and activates the next top-level window.
$lnk.TargetPath = "cmd.exe" # Run windows cmd
$lnk.Arguments = " /c gpg-connect-agent /bye" ## /c no echo, used to make it invisible.
$lnk.Save() ## Save/apply new shortcut properties.

Write-Host "Finished creating shortcut"
