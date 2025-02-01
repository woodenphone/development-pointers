<#
	create-files-checklist.ps1

	.SYNOPSIS
	Simple file list checklist thing.

	# .DESCRIPTION
	.EXAMPLE
	PS> .\bin\create-files-checklist.ps1

	.NOTES
	Author: Ctrl-S
	Created: 2025-01-25
	Modified: 2025-01-25
	License: GPLv3

	.NOTES
	See also: 
	https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem
    Attribute meanings: https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes

#>

$outfile = "meta\file-checklist.testing.md"

## Header:
write-Output @"
# Files checklist
Read the whole file and remove anything confidential before marking off any file.

"@  | Add-Content -Path $outfile

## Checklist of files:
Get-ChildItem -Path . -Force -Recurse  -Attributes "!Directory" | Resolve-Path -Relative  | ForEach-Object { $_ -replace '\\', '/' -replace '^(.+)', '- [ ] "$1"' } | Add-Content -Path $outfile

## Footer:
write-Output @"

"@  | Add-Content -Path $outfile

exit