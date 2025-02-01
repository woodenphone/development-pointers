#!/bin/bash
## scrub-all-btrfs-drives.sh
## Perform a scrub on all mounted BTRFS drives.
## ! WIP !
## ==================================== ##
## 
## 
## ==================================== ##
## SEE ALSO:
## * 
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-11-02
## MODIFIED: 2023-11-02
## ==================================== ##
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}]" "Starting" "at $(date -Is)"
echo "#[${0##*/}]" "argv=${*[*]@Q}" # Print shellescaped invocation params.
echo "#[${0##*/}]" "Running as" "${USER}@${HOSTNAME}:${PWD}"
echo "#[${0##*/}]" "id:" "$(id)" # Current security context.

## ==========< Functions >========== ##
f_list_btrfs_filesystems() {
	## List devicepaths for all local BTRFS filesystems.
	lsblk -o 'PATH,TYPE,MOUNTPOINT' | gawk '$2 == "btrfs" {print $3}'
}
## ==========< /Functions >========== ##


## ==========< Config >========== ##
run_timestamp="$(date -Is)"
output_dir="scrub-results"
logfile="${output_dir?}/scrub-all-btrfs-drives.${run_timestamp?}.log"
scrubs_log="${output_dir?}/scrubs-results.${run_timestamp?}.log"
## ==========< /Config >========== ##


main_f() { # As func to help capture STDERR and STDOUT.
	## Make log header:
	printf "## Start of log; ${scrubs_log}\n" > "${scrubs_log?}"

	## Get all BTRFS drives on system:
	btrfs_filesystems="$(lsblk -o 'PATH,TYPE' | gawk '$2 == "btrfs" {print $1}')"
	echo "#[${0##*/}]" "btrfs_filesystems=${btrfs_filesystems[*]@Q}" | tee -a "${scrubs_log?}"

	## Loop over the BTRFS drives, scrubbing and recording results:
	for fs_to_scan in ${btrfs_filesystems} do
		echo "#[${0##*/}]" "fs_to_scan=${fs_to_scan@Q}" | tee -a "${scrubs_log?}"
		btrfs scrub start -Bf "${fs_to_scan?}" | tee -a "${scrubs_log?}"
		printf "\n\n" | tee -a "${scrubs_log?}"
	done
	echo "#[${0##*/}]" "Finished" "at $(date -Is)"
}
## Log STDOUT and STDERR:
main_f \
	1> >(sed 's/^/1>/' | tee -a "${logfile?}" ) \
	2> >(sed 's/^/2>/' | tee -a "${logfile?}" >&2)
printf '\n' | tee -a "${logfile?}" ## Ensure trailing newline.

exit
