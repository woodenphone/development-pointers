#!powershell
## enable-touchscreen.ps1
## Disable the touchscreen, as would be done in device manger manually.
## AUTHOR: Ctrl-S, 2021-11
## Must be run as administrator!
Write-Verbose "Starting" -Verbose

## NOTE: Where-Object {$_.PropertyName -ComparisonType FilterValue}

Get-PnpDevice -PresentOnly -Class "HIDClass" | Where-Object {$_.'FriendlyName' -like "*HID-compliant touch screen*"} | Enable-PnpDevice

Write-Verbose "Finished" -Verbose
