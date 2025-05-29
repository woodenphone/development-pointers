<#
	.SYNOPSIS
	Produce a list of file hash records for the given files.

	.DESCRIPTION
	Hash the files at the specified paths and output 
	Uses a pseudo-BSD style / '--tag' output formatting.

	.EXAMPLE
	PS> ./hash-files.ps1 [-v|-verbose] [FILE...]

	.EXAMPLE
	PS> ./hash-files.ps1 foo bar baz

	.EXAMPLE
	PS> Get-Content FilesList.txt | ./hash-files.ps1

	.INPUTS
	Postitionals: Zero or more filepaths.
	Pipeline: Zero or more filepaths.

	.OUTPUTS
	[string] '$SizeBytes Bytes ($FilePath) $Algo = $FileHash'

	.LINK 
	https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash?view=powershell-7.5

	.NOTES
	Author: Ctrl-S
	Created: 2025-05-23
	Modified: 2025-05-27
	License: MIT
#>

## ====================< Accept params >==================== ##
## Accept params and pipe input.
param (
	# [Parameter(
	# 	HelpMessage="Escape characters in paths."
	# )]
	# [Alias("e","escape")]
	# [switch] $DoEscapePaths, # Default to null.

	# [Parameter(
	# 	HelpMessage="Method of escaping to use for paths."
	# )]
	# [Alias("E","escape-type")]
	# [ValidateSet("posix", "msdos", "win32", "alnum-fs", "alnum-bs", "none")]
	# [string] $EscapeType = 'posix',

	# [Parameter(
	# 	HelpMessage="Method of escaping to use for paths."
	# )]
	# [Alias("o","output","dest","destination")]
	# [string] $OutputFile, # Default to null.

	# [Parameter(
	# 	HelpMessage="Delimiter between input filepaths (where applicable)."
	# )]
	# [Alias("d","delimiter","Delimiter")]
	# [string] $InputDelimiter, # Default to null.

	# [Parameter(
	# 	HelpMessage="Disable tolerance for both unix-style <LF> and windows-style <CR><LF>."
	# )]
	# [Alias("I","Intolerant","ExactLineEndings","ExactEndings","ExactDelimiter")]
	# [switch] $IntolerantInput, # Default to null.

	# [Parameter(
	# 	HelpMessage="file containing list of filepaths to hash."
	# )]
	# [Alias("l","fileslist")]
	# [string] $InputListFile, # Default to null.

	# [Parameter(HelpMessage="Emit more details about what is being done.")]
	# [Alias("v")]
	# [switch] $Verbose,

	[Parameter(
		ValueFromRemainingArguments,
		HelpMessage="Paths of file(s) to hash."
	)]
	[string[]] $TargetFilesFromParams, # Default to null.

	[Parameter(
		ValueFromPipeline,
		HelpMessage="Paths of file(s) to hash."
	)]
	[string[]] $TargetFilesFromPipe # Default to null.
)
if ($Verbose) {
	Write-Information "Invoked via ${MyInvocation.Line}"
}
# if (not $TargetFilesFromPipe -like '' and not $TargetFilesFromParams) {
# 	Write-Information "No target files given!"
# 	exit 1
# }
## ====================< /Accept params >==================== ##

## ====================< Functions >==================== ##
## Custom functions:
# EscapeFilePath() {
# 	## https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.wildcardpattern.escape?view=powershellsdk-7.4.0
# 	[Management.Automation.WildcardPattern]::Escape($1)
# }

function HashOneFile {
	param (
		[Parameter(Mandatory, Position=0,
		HelpMessage="Path of the file to hash.")]
		[ValidateNotNullOrEmpty()]
		[string] $TargetFile
	)
	## Generate hash of file:
	$FileHashObj = $(Get-FileHash $TargetFile) ## Create hash
	## Convert values from objects into strings
	[string]$HashAlgorithm = "$($FileHashObj | Select-Object -ExpandProperty  Algorithm)"
	# [string]$FilePath = "$($FileHashObj | Select-Object -ExpandProperty  Path)"
	[string]$FileHash = "$($FileHashObj | Select-Object -ExpandProperty  Hash)"
	# $EscapedFilePath = [Management.Automation.WildcardPattern]::Escape($FilePath)
	## Query size of file:
	[string]$FileSizeBytes = "$(Get-Item $TargetFile | Select-Object -ExpandProperty  Length)"
	## Emit output text:
	Write-Output "${FileSizeBytes} Bytes `(${TargetFile}`) ${HashAlgorithm} = ${FileHash}"
	return
}
## ====================< /Functions >==================== ##

## ====================< Main task >==================== ##
## Process files from positional params:
if ($TargetFilesFromParams) {
	if ($Verbose) {
		Write-Information "Process files from positional params...}"
	}
	[int] $PositionalsFileCounter = 0
	[int] $NumPostionalFiles = ${TargetFilesFromParams}.Count()
	$TargetFilesFromParams | ForEach-Object {
		[int] $PositionalsFileCounter++
		[string] $TargetFile = $_
		try {
			HashOneFile ${TargetFile}
		}
		catch {
			Write-Error "Exception while hashing file from positionals ${PositionalsFileCounter} of ${$NumPostionalFiles}: ${TargetFile} "
			Write-Error $_ ## Print builtin description of exception.
			Write-Error $_.ScriptStackTrace ## Print stack trace for exception.
		}
		finally {
			if ($Verbose) {Write-Information "Completed hashing files from positional params, total: ${NumPostionalFiles}" }
		}
	}
}

## Process files from pipeline:
if ($TargetFilesFromPipe) {
	if ($Verbose) {
		Write-Information "Process files from pipeline..."
	}
	[int] $PipedFileCounter = 0
	$TargetFilesFromPipe | ForEach-Object {
		[int] $PipedFileCounter++
		[string] $TargetFile = $_
		try {
			HashOneFile ${TargetFile}
		}
		catch {
			Write-Error "Exception while hashing ${PipedFileCounter} piped file: ${TargetFile} "
			Write-Error $_ ## Print builtin description of exception.
			Write-Error $_.ScriptStackTrace ## Print stack trace for exception.
		}
		finally {
			if ($Verbose) {Write-Information "Completed hashing files from pipe, totall: ${PipedFileCounter}"}
		}
	}
}
## ====================< /Main task >==================== ##

## End-of-run stats:
if ($Verbose) {
	Write-Information "Total files hashed:  ${PositionalsFileCounter} positionals, ${PipedFileCounter} piped."
}
exit
