#!/bin/bash
## rsync-example.sh
## ==================================== ##
## LICENSE: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2023-06-13
## MODIFIED: 2023-06-13
## ==================================== ##
# set -x ## Print statements as they are interpreted.

echo "#[${0##*/}]" "Start" "$(date -Is)"


## ==========< Config >========== ##
ssh_port="22"
ssh_keyfile="$HOME/.ssh/id_rsa"
## ==========< /Config >========== ##


rsync_params=( # Complex args as array for readability + comments.
	## Log options:
	--verbose
	--progress
	--human-readable
	--itemize-changes
	## File options:
	--archive ## Preserve file attributes.
	## Easy resume via partial-dir:
	--partial
	## Network options:
	--bwlimit="2000" # In KB/sec.
	## Connect over SSH
	--rsh="ssh -p ${ssh_port?} -i ${ssh_keyfile?}"
	## SOURCE:
	"/home/example-user/important-data.tar.gz"
	## DESTINATION:
	"USER@TARGET_HOST:/home/example-user/"
	)

## Print invocation:
echo "#[${0##*/}]" "rsync_params (@A):" "${rsync_params[@]@A}"
echo "#[${0##*/}]" "rsync_params (%q):" "$( builtin printf '%q ' "${rsync_params[@]}" )"

rsync "${rsync_params[@]}" ## Run rsync using array of arguments.

echo "#[${0##*/}]" "End" "$(date -Is)"
exit
