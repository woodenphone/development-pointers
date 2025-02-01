#!/usr/bin/bash
## loop-ssd-endurance-check.sh
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-03-15
## MODIFIED: 2023-03-15
## ==================================== ##
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}]" "Starting" "at $(date -Is)"


## ==========< Config >========== ##
disk_to_watch=/dev/disk/by-id/ata-DISK_NAME_REMOVED
outfile="$HOME/DISK_NAME_REMOVED.endurance-log.csv"
loop_delay=$((60*60*3)) # Sleep time between loops.
## ==========< /Config >========== ##


## ==========< Functions >========== ##
do_disk_checkup() {
	percentage_endurance_used=$(
		sudo smartctl --xall "$(realpath ${disk_to_watch?})" \
		| grep 'Percentage Used Endurance Indicator' \
		| awk '{print $4;}'
	)
	echo "$(date -Is),${percentage_endurance_used?}" \
	| tee -a "${outfile?}"
}
## ==========< /Functions >========== ##


## Prep destination
mkdir -vp $( dirname ${outfile?} )

if [[ ! -e ${outfile?} ]]; then ## If file does not exist
	## Write CSV header:
	echo "# log for ${disk_to_watch}" | tee -a "${outfile?}"
	echo "#ISO_DATE,percentage_endurance_used" | tee -a "${outfile?}"
fi


echo "Press [CTRL+C] to stop loop.."
while true
do
	do_disk_checkup
	sleep ${loop_delay?}
done


echo "#[${0##*/}]" "Finished" "at $(date -Is)"
exit
