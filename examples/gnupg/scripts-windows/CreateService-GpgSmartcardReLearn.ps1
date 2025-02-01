## CreateService-GpgSmartcardReLearn.ps1
## Create a service to relearn smartcard associateions.
## ! WIP !
## ======================================== ##
## See also:
## https://duffney.io/create-scheduled-tasks-secure-passwords-with-powershell/
## ======================================== ##
## AUTHOR: Ctrl-S
## CREATED: 2023-12-07
## MODIFIED: 2023-12-07
## ======================================== ##
# $SecurePassword = $password = Read-Host -AsSecureString
# $UserName = "$([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)"
# $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $UserName, $SecurePassword
# $Password = $Credentials.GetNetworkCredential().Password 
$Password = ""

$job = Register-ScheduledJob `
	-Name "GpgSmartcardReLearn" `
	-ScriptBlock { gpg-connect-agent "scd serialno" "learn --force" "/bye" } `
    -RunEvery (New-TimeSpan -Minutes 15) `
	-ScheduledJobOption (New-ScheduledJobOption -StartIfOnBattery -ContinueIfGoingOnBattery) `
	-RunNow

$job = $(Get-ScheduledJob -Name "GpgSmartcardReLearn")

# Change principal to run only on interactive logon instead of S4A.
# $principal = New-ScheduledTaskPrincipal -LogonType Interactive -UserId $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name)
$principal = New-ScheduledTaskPrincipal -LogonType Password -UserId $([System.Security.Principal.WindowsIdentity]::GetCurrent().Name) -Password $Password
Set-ScheduledTask -TaskPath \Microsoft\Windows\PowerShell\ScheduledJobs\ -TaskName $job.Name -Principal $principal

