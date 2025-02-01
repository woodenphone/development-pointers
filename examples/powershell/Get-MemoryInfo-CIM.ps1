#!powershell
## Get-MemoryInfo-CIM.ps1
## Get the information about installed RAM modules.

Get-CimInstance -ClassName Win32_PhysicalMemory
