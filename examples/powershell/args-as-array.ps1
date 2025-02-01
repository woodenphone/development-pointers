#!powershell
## args-as-array.ps1
## Test script to see if I can pass arguments to a command as an array
## which would permit comments in the argument block.
## ==================================== ##
## See also:
## https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays
## ==================================== ##
## AUTHOR: Ctrl-S
## CREATED: (Before 2025)
## CHANGED 2025-01-31
## ==================================== ##

## Create an array of strings to be passed as arguments:
$args_array = @(
	## This is a comment.
	# user@host
    "ssh://USER@10.1.1.69",
    '-p', "22" # Port
    '-f', '-N',
    ## Port forwarding:
    '-L', "42069:10.1.1.69:42069",
    '-o', 'ExitOnForwardFailure=yes'
)

# Print the array's strings:
Write-Output $args_array

## Invoke command, passing the array contents as arguments:
ssh $args_array

