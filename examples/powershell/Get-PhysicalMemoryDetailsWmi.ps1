#!powershell
## Get-PhysicalMemoryDetailsWmi.ps1
Get-WmiObject win32_physicalmemory | Format-Table Manufacturer,Banklabel,Configuredclockspeed,Devicelocator,Capacity,PartNumber,Serialnumber -autosize
