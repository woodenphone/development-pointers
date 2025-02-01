#!/usr/bin/env bash
## ia-download-many.sh
## Simple thing to run many internetarchive / archive.org 
##   item downloads sequentially.
## Requires python3 internetarchive pip3 package.
##
## Copypaste this to a new file and put a bunch of item ID slugs in.
## ======================================== ##
## Author: Ctrl-S
## Created: 2023-09-03
## Modified: 2023-09-03
## ======================================== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2

item_names=( ## Array of item-name-slug strings as used by 'ia' tool.
	## i.e. FOO from $ ia download FOO
	""
	""
	""
	""
	""

)
echo "[${0##*/}] item_names=${item_names[*]@Q}" >&2

echo "[${0##*/}] Begin looping over item name slugs... (at $(date -Is))" >&2
for item_name in $item_names; do
	echo "[${0##*/}] item_name=${item_name@Q} (at $(date -Is))" >&2
	if [[ -z ${item_name} ]]; then 
		echo "[${0##*/}] Skipping invalid item_name string" >&2 # Report exit status.
		continue
	fi
	## Attempt download of item:
	time ia download "${item_name?}"
	returned_exit_status=$? ## Record exit status for comparison.
	echo "[${0##*/}] returned_exit_status=${returned_exit_status@Q}" >&2 # Report exit status.
	sleep 600
done
echo "[${0##*/}] Loop finished (at $(date -Is))" >&2

echo "[${0##*/}] Script finished (at $(date -Is))" >&2
exit
