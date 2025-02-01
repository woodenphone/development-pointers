<#
	robocopy-example.from-md.ps1

	.SYNOPSIS
	Simple runner for robocopy.

	.DESCRIPTION
	Example code copied from my guide into seperate file for easier use.
	Robocopy invocation to make a verbatim copy, including identical timestamps.

	.EXAMPLE
	Administrator PS> .\robocopy-example.from-md.ps1

	.NOTES
	Author: Ctrl-S
	Created: 2023-11-11
	Modified: 2025-01-04
	License: GPLv3

	.NOTES
	See also: 
	https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
#>

$robocopy_params = $( # params as array for readability and logging.
	## See: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
	## > robocopy
	## SOURCE:
	"D:\",
	## DEST:
	"F:\my-verbatim-copy\", 
	"/E", # Copy subdirs, including empty ones.
	## Retry and permission handling
	"/ZB", ## Copies files in restartable mode. If file access is denied, switches to backup mode.
	"/R:1", ## Retry anything that fails once before moving on to next file.
	"/W:10", ## Wait this long between retries.
	## What to copy:
	"/COPY:DAT", 
	"/DCOPY:DAT",
	"/timfix" ## Fixes file times on all files, even skipped ones.
	"/SJ", ## Copies junctions (soft-links) to the destination path instead of link targets.
	"/sl", ## Don't follow symbolic links and instead create a copy of the link.
	"/XJ", ## Excludes junction points, which are normally included by default.
	## Exclude special files and folders:
	"/XD", "Recycler", "Recycled", "`$Recycle.bin", "System Volume Information",
	"/XF", "pagefile.sys", "swapfile.sys", "hiberfil.sys",
	## Log and message options:
	"/LOG+:robocopy-log.txt", ## Write to logfile.
	"/NP" ## Don't show console messages.
)
## Print out and record the inocation parameters:
Write-Information "robocopy_params = ${robocopy_params}";
Write-Output ${robocopy_params} | ConvertTo-Json > "robocopy_command.json" ;
## Actually run robocopy with the parameters:
robocopy ${robocopy_params} ;

exit
