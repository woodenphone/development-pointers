# Windows configuration via Powershell


## List WMI classes
```powershell
PS> Get-WmiObject -Class __Provider | Select-Object -ExpandProperty Name
```

```powershell
PS> Get-CimClass
```
* https://devblogs.microsoft.com/scripting/powertip-list-all-wmi-classes/
* https://devblogs.microsoft.com/scripting/finding-wmi-classes-that-contain-methods/


```powershell
PS> Get-CimClass | ForEach-Object {$_.CimClassName} > CimClassNames.txt
```

## Display

```powershell
PS> Get-WmiObject -Class CIM_Display
```


```powershell
PS> (Get-WmiObject -Class CIM_Display ).PixelsPerXLogicalInch
96
```
