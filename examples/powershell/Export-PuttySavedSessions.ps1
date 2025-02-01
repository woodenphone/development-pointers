#!powershell
## Export-PuttySavedSessions.ps1
## DESCRIPTION
## ==================================== ##
## USAGE: TODO
## ==================================== ##
## See also:
## * https://stackoverflow.com/questions/13023920/how-to-export-import-putty-sessions-list#13023979
## * https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/reg-export
## * https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-entries
## * https://stackoverflow.com/questions/23066783/how-to-strip-illegal-characters-before-trying-to-save-filenames#23067832
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-12-10
## MODIFIED: 2023-12-10
## ==================================== ##


## ==========< Config >========== ##
param(
	[Parameter(Mandatory=$false,
		HelpMessage = 'Dir path to save exported sessions into."',
		Position = 1)]
	[string] $OutputDir = "PuTTY-Exported-Sessions"
)
## ==========< /Config >========== ##
Write-Host "[${MyInvocation.ScriptName}] Starting at $(Get-Date -f "O")"

## ==========< Dump sessions to files >========== ##
## Location PuTTY stores saved session configs:
$SessionsRegPath = "HKCU:\Software\SimonTatham\PuTTY\Sessions"

## Dest dir must exist.
New-Item -ItemType Directory -Force -Path $OutputDir

Get-ChildItem -Path $SessionsRegPath `
	|  ForEach-Object { 
		# $_ | Get-Member;
		# $SessionRegistryPath = $_.PSPath ## Session registry path in powershell format.
		$SessionNameRaw = $_.PSChildName ## Session name.

		## Path suitable for reg export:
		$SessionRegPath = "HKCU\Software\SimonTatham\PuTTY\Sessions\" + $SessionNameRaw ## Session registry path in regedit format.
		
		## Make string filename-safe:
		$SessionNameFNSafe = $($SessionNameRaw.Split([IO.Path]::GetInvalidFileNameChars()) -join '_')
		$SessionFilepath = "$OutputDir\$SessionNameFNSafe.reg"

		Write-Output "Dump: $SessionRegPath to file: $SessionFilepath"
		# Export this session's config to a file:
		reg export "$SessionRegPath" "$SessionFilepath"
};
## ==========< /Dump sessions to files >========== ##

Write-Host "[${MyInvocation.ScriptName}] Finished at $(Get-Date -f "O")"
exit
