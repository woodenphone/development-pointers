#!powershell
## maintain-ssh.ps1
## Open a ssh tunnel and reopen it if it disconnects.
## ! WIP !
## ======================================== ##
## USAGE: PS> ./$0
## ======================================== ##
## See also:
## * https://learn.microsoft.com/en-us/windows/terminal/tutorials/ssh
## * https://www.man7.org/linux/man-pages/man1/ssh.1.html
## ======================================== ##
## LICENSE: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2023-11-21
## MODIFIED: 2023-11-22
## ======================================== ##
Write-Output "[$MyInvocation.MyCommand.Name] Starting. $(Get-Date -Format "o")"


## ==========< Functions >========== ##
function LogMessage {
    <#
    .SYNOPSIS
    Print a message with basic formatting.

    Concatenate positional parameters using space as a seperator,
    a prefix based on the name of the running script,
    and a suffix containing an ISO timestamp.
    #>
    $MessagePrefix = "[$MyInvocation.MyCommand.Name]" ## Name of running script file.
    $MessageSuffix = "(at $(Get-Date -Format o))" ## ISO Timetamp.
    Write-Information $( $args | Join-String -Separator " " -OutputPrefix $MessagePrefix -OutputSufix $MessageSuffix )
}
## ==========< /Functions >========== ##


## ==========< Connection parameters >========== ##
$reconnect_sleep_seconds = "30"
$ssh_params = $( # params as array for readability and logging.
    ## Connect to:
    "ssh://USER@HOST:PORT",  ## "ssh://USER@HOST:PORT" 
    # "-i", "identity_file", ## Use private key from file.
    ## Connection options:
    # "-o", "LogLevel=VERBOSE",
    "-o", "ExitOnForwardFailure", ## Treat portforward failues as fatal.
    "-o", "ServerAliveInterval=10",
    "-o", "ServerAliveCountMax=12",
    ## Forward port(s):
    "-D", "localhost:9910" ## -D [bind_address:]port
    ## Background SSH params:
    "-N", ## "run no command" (Needed to keep ssh in background, omitting makes ssh take over tty.)
    "sleep 600" ## Gives time for port forward to be actually used to persist tunnel.
)
Write-Output ${ssh_params}
${ssh_params} | ConvertTo-Json > "ssh_params.json"
## ==========< /Connection parameters >========== ##


## ==========< Main loop >========== ##
while ( $true ) {
    Write-Output "[$MyInvocation.MyCommand.Name] Connecting. $(Get-Date -Format "o")"
    ssh ${ssh_params}
    Write-Output "[$MyInvocation.MyCommand.Name] Waiting ${reconnect_sleep_seconds} seconds before reconnecting. $(Get-Date -Format "o")"
    Start-Sleep -Seconds ${reconnect_sleep_seconds}
}
## ==========< /Main loop >========== ##


Write-Output "[$MyInvocation.MyCommand.Name] End of script. $(Get-Date -Format "o")"
exit
