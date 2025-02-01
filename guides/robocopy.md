# Robocopy guide (Windows file transfer/copy utility)
One of the major advantages of Robocopy is its ability to preserve timestamps from the source to the destination when copying.


Robocopy can produce a job definition file containing the information on the specified job to do, which can be given to robocopy later to do the same thing.
	e.g. scheduled backup job, reliably resumable copy/move job.
	`/save:<jobname>`
	More detail is available in the ["Job options" section of Robocopy documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy#job-options)



## Copypasta
Verbose annotated format for scripts: [robocopy-task.copy-over-old-ssd.os.ps1](./examples/powershell/robocopy-task.copy-over-old-ssd.os.ps1) ["robocopy-example.from-md.ps1"](.\examples\powershell\robocopy-example.from-md.ps1)
```powershell
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
```

Classic-style invocation:
```powershell
robocopy 

```
* TODO: Working example invocation.



### Useful CLI parameters
* TODO: Attribute / metadata copying - timestamps, permissions, etc.


#### Common exclude patterns
If you're backing up a running system there are certain files very likely to cause problems and which are generally best excluded.

Exclude special files that could cause trouble:
```powershell
robocopy "/XD" "Recycler" "Recycled" "`$Recycle.bin" "System Volume Information" "/XF" "pagefile.sys" "swapfile.sys" "hiberfil.sys"
```

Explaination of exclude copypasta:

Folders that could lead to trouble:
```
"Recycler" "Recycled" "$Recycle.bin" "System Volume Information"
```

Windows swapfile / pagefile, used for swap (Using disk to expand logical RAM capacity)
"pagefile.sys" "swapfile.sys"

Hibernation file, used for sleep mode - Contents of RAM get moved here so system RAM and related circuitry can be powered down. AHCI power state stuff. 
`"hiberfil.sys"`

* TODO: Links to technical explainations of each file or dir.


## Files
Links to files within this repo.
Examples, tools, etc.
* A powershell script demonstrating using Robocopy []()./examples/powershell/robocopy-task.copy-over-old-ssd.os.ps1)
* ["robocopy-task.copy-over-old-ssd.os.ps1"](./examples/powershell/robocopy-task.copy-over-old-ssd.os.ps
* Simplified example ["robocopy-example.from-md.ps1"](.\examples\powershell\robocopy-example.from-md.ps1)


## Links
* [Robocopy documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy)
* ["Job options" section of Robocopy documentation](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy#job-options)
