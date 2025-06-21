#!/usr/bin/env bash
## disk-keepawake-simple.sh
## To keep a disk device awake/active; i.e. inhibit disk sleep.
## e.g. for external enclosures.
## ======================================== ##
## USAGE:
## ./$0 DEVICE
## ======================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2025-05-01
## Modified: 2025-06-16
## ======================================== ##

echo "[${0##*/}] Starting, targeting device ${1@Q} (at $(date -Is))" >&2

## ==========< Main loop >========== ##
while true; do
	sleep 30 ## Wait a little while between access attmpts.
	
	## Access a small amount of data to keep disk awake
	offset=$((1 + $RANDOM % 100)) ## Random number below 100

	## https://www.man7.org/linux/man-pages/man1/dd.1.html
	## https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html
	## Read 1KiB data from the disk:
	dd "if=${1?}" "of=/dev/null" "iflag=nocache" "ibs=1K" "seek=${offset?}" "count=1"
	## Reasons for flags:
	## nocache - Re-read from disk instead of using cache, while not clobbering anything.
done
## ==========< Main loop >========== ##

exit
