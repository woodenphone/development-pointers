#!/usr/bin/bash
## maintain-ssh-tunnel.sh
## Create a ssh tunnel
## ==================================== ##
## Remote user runs: (TESTME)
## bob:~ $ ssh -q -W someuser@localhost:22 someuser@jump.example.com -p 22
## ==================================== ##
## See also:
##  https://www.man7.org/linux/man-pages/man1/ssh.1.html
##  https://www.man7.org/linux/man-pages/man5/sshd_config.5.html
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-05-06
## MODIFIED: 2025-01-25
## ==================================== ##
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}] Starting at $(date -Is)"

## ==========< Config >========== ##
## Local files and sockets:
identity_file="${HOME}/.ssh/id_rsa" ## SSH key to authenticate with.
ssh_socketfile="${HOME}/${0##*/}.sock" ## Socketfile to control ssh connection.
## Misc.
loop_delay=30 ## Seconds before reattempting to connect.
## ==========< /Config >========== ##

## ==========< Strict mode >========== ##
## https://devhints.io/bash
## http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'
## ==========< /Strict mode >========== ##

## Dir needs to exist:
mkdir -vp $( dirname ${ssh_socketfile?} )

echo "Press [CTRL+C] to stop loop.."
while true; do
	## ==========< Create tunnel >========== ##
	ssh_params=(
		-M -S "${ssh_socketfile?}" # Create a socket for controlling tunnel.
		-i "${identity_file?}" # Private key file
		## Do not return until after tunnel setup is done: ( https://gist.github.com/scy/6781836 )
		# -f ## "fork into background"
		-N ## "run no command" (Needed to keep ssh in background, omitting makes ssh take over tty.)
		## SSH options: (see ssh(1) and ssh_config(5) manpages)
		-o ExitOnForwardFailure=yes ## Client exits if any portforward fails.
		-o "ServerAliveInterval=30" ## Client sends a keepalive packet this often.
		-o "ServerAliveCountMax=10" ## Client exits after this many repeated keepalive failures.
		##
		## Forward local port(s) to remote host:
		# -L "${local_listen_port?}:${remote_ssh_host?}:${remote_port?}"
		# -L "28000:.192.168.0.1:8000"
		# -L "28001:.192.168.0.1:8001"
		##
		## Forward remote port(s) to local:
		## -R [bind_address:]port:host:hostport
		-R 10022:localhost:22 # Let sshd recieve connections from jumpserver.
		##
		## Remote host:
		# -p "${remote_ssh_port?}" # Remote host SSH port 
		"ssh://alice@jumpserver.example.com:22"
		## Keep SSH tunnel alive for 600 seconds of inactivity:
		sleep 600 ## Gives time for port forward to be actually used to persist tunnel.
	)
	echo "#[${0##*/}] ssh_params=( ${ssh_params[*]@Q} );"
	echo "#[${0##*/}] Starting ssh tunnel at $(date -Is)"
	ssh "${ssh_params[@]}"
	echo "#[${0##*/}] ssh returned code $? at $(date -Is)"
	## ==========< /Create tunnel >========== ##
	echo "#[${0##*/}] Sleeping for ${loop_delay?} before retrying..."
	sleep ${loop_delay?}
	echo "#[${0##*/}] Retrying"
done

echo "#[${0##*/}] Finished at $(date -Is)"
exit
