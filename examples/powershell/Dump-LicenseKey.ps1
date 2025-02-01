#!powershell
## Dump-LicenseKey.ps1
$MachineInfo = New-Object PSObject -Property @{
	ComputerName = (Get-WmiObject -ComputerName localhost -Namespace root\cimv2 -Class Win32_ComputerSystem).Name
	ComputerManufacturer = (Get-WmiObject -ComputerName localhost -Namespace root\cimv2 -Class Win32_ComputerSystem).Manufacturer
	ComputerModel = (Get-WmiObject -ComputerName localhost -Namespace root\cimv2 -Class Win32_ComputerSystem).Model
	ComputerSerialNumber = (Get-WmiObject -ComputerName localhost -Namespace root\cimv2 -Class Win32_SystemEnclosure).SerialNumber
	CPUCaption = (Get-WmiObject Win32_Processor).Caption
	CPUName = (Get-WmiObject Win32_Processor).Name
	TotalRAMKB = (Get-WmiObject Win32_computersystem).TotalPhysicalMemory
	PowerPlatformRole = (Get-CimInstance Win32_OperatingSystem).PowerPlatformRole
	WindowsVersion = (Get-CimInstance Win32_OperatingSystem).version
	WindowsBuildNumber = (Get-CimInstance Win32_OperatingSystem).BuildNumber
	WindowsSerialNumber = (Get-CimInstance Win32_OperatingSystem).SerialNumber
	WindowsProductKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
	Timestamp = "$(Get-Date -Format u)"
}
Write-Output $MachineInfo | ConvertTo-JSON
