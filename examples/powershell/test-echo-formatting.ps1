#!powershell
## test-echo-formatting.ps1
## Experiments with formatting output.
## ======================================== ##
## PURPOSE:
## * Ensure I can write vars shellquoted - suitable for re-entering to get an identical variable back later.
## * Nice message formatting such as script-name prefix and ISO timestamps
##
## ======================================== ##
## USAGE:
## PS> ./robocopy-task.ps1
## ======================================== ##
## SEE ALSE:
## https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/robocopy
##
## ======================================== ##
## License: GPLv3
## Author: Ctrl-S
## Created: 2023-11-11
## Modified: 2023-11-11
## ======================================== ##

## Test Bash-like method to get script name by slicing $0
Write-Output "[${0##*/}] Starting at $(Get-Date -Format "o"
)"

## Assign script name to a variable:
$MyTestScriptName = "$(& { $MyInvocation.ScriptName | split-path -Leaf; })"
Write-Output "MyTestScriptName inside text:${MyTestScriptName}"

Write-Output "Plain MyTestScriptName:"
Write-Output ${MyTestScriptName}

Write-Output "thingy a":
Write-Output "$(& { $MyInvocation.ScriptName; })"



$MyTestSimpleArray=(
    1, 2, 3, "four", 5, "six"
)
Write-Output "MyTestSimpleArray inside text: ${MyTestSimpleArray}";
Write-Output $MyTestSimpleArray;
Write-Output $MyTestSimpleArray > "MyTestSimpleArray.txt";
Write-Output $MyTestSimpleArray | ConvertTo-Json > "MyTestSimpleArray.json";
Write-Output $MyTestSimpleArray | ConvertTo-Xml > "MyTestSimpleArray.xml";


MyTestInvocationArray = $(
    "robocopy",
    ## SOURCE:
    "",
    ## DEST:
    "", 
    "/e", # Copy subdirs, including empty ones.
    "/copy:DAT",
    "/dcopy:DAT",
    "/timfix" ## Fixes file times on all files, even skipped ones.
    ## Exclude special files:
    "/XD", "Recycler", "Recycled", "`$Recycle.bin", "System Volume Information",
    "/XF", "pagefile.sys", "swapfile.sys", "hiberfil.sys",
    "/LOG+:robocopy-log.txt"
);
Write-Output $MyTestInvocationArray > "MyTestInvocationArray.txt";
Write-Output $MyTestInvocationArray | ConvertTo-Json > "MyTestInvocationArray.json";
Write-Output $MyTestInvocationArray | ConvertTo-Xml > "MyTestInvocationArray.xml";

exit