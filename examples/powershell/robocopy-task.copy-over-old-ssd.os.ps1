#!powershell
# robocopy-task.copy-over-old-ssd.os.ps1
<#
.SYNOPSIS
Simple runner for robocopy.
.DESCRIPTION
Use robocopy to make a verbatim copy of old SSD partitions to dirs in new SSD. 
.EXAMPLE
Administrator PS> .\robocopy-task.copy-over-old-ssd.os.ps1
.NOTES
Author: Ctrl-S
Created: 2023-11-11
Modified: 2024-11-25
License: GPLv3
.NOTES
See also: 
https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
#>

## ==========< Prep >========== ##
$TimeStamp = "$(Get-Date -u '+%Y-%m-%dT%H%M%S%=@%s')";
# $JobName = "migrate-from-old-ssd.os.2024";
$JobName = "migrate-from-old-ssd.2024q4.os.${TimeStamp}";
$ScriptLogFile = "${JobName}.ps-transcript.txt";
$MsgPfx = "[$(& { $MyInvocation.ScriptName | split-path -Leaf; })]"; ## e.g. '[ScriptFileName.ext]'
## ==========< /Prep >========== ##

Start-Transcript -Path ${ScriptLogFile}
try {
    Write-Information "${MsgPfx} Starting at $(Get-Date -Format "o")";
    $ScriptFile = "$MyInvocation.ScriptName";
    Write-Information "${MsgPfx} ScriptFile: ${ScriptFile}";
    Copy-Item $ScriptFile  "${JobName}.used-script.ps1";

    ## ==========< Robocopy >========== ##
    $robocopy_params = $( # params as array for readability and logging.
        ## https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
        ## > robocopy
        ## SOURCE:
        "D:\",
        ## DEST:
        "F:\old-os-ssd\OS", 
        "/E", # Copy subdirs, including empty ones.
        ## Retry and permission handling
        "/ZB", ## Copies files in restartable mode. If file access is denied, switches to backup mode.
        "/R:1",
        "/W:10",
        ## What to copy:
        "/COPY:DAT",
        "/DCOPY:DAT",
        "/timfix" ## Fixes file times on all files, even skipped ones.
        "/SJ", ## Copies junctions (soft-links) to the destination path instead of link targets.
        "/sl", ## Don't follow symbolic links and instead create a copy of the link.
        "/XJ", ## Excludes junction points, which are normally included by default.
        ## Exclude special files:
        "/XD", "Recycler", "Recycled", "`$Recycle.bin", "System Volume Information",
        "/XF", "pagefile.sys", "swapfile.sys", "hiberfil.sys",
        ## Log and message options:
        "/LOG+:${JobName}.robocopy-log.txt", ## Write  to logfile.
        "/NP" ## Don't show console messages.
    )
    ## Print to the console:
    Write-Output "${MsgPfx} robocopy_params = ${robocopy_params}";
    ## Write to a file:
    Write-Output ${robocopy_params} | ConvertTo-Json > "${JobName}.rc_command.json" ;
    ## Run command:
    robocopy ${robocopy_params} ;
    ## ==========< /Robocopy >========== ##
    Write-Information "${MsgPfx} Finished at $(Get-Date -Format "o";)";
}
catch {
    Write-Information "${MsgPfx} An error occurred that could not be resolved.";
    Write-Output $_ | Tee-Object "${JobName}.fatal-exception.txt"; ## Display exception that occured.
}
# finally {
# }
Write-Information "${MsgPfx} Ending transcript log and exiting script.";
Stop-Transcript;
exit
