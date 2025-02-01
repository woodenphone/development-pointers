#!/bin/bash
## check-link-speed.sh
## Check the link speed of network adaptors.
## ========================================
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATD: 2023-03-05
## MODIFIED: 2023-03-05
## ========================================
# set -v ## Make BASH print lines as they are executed; for debugging.
echo "[${0##*/}] Link speeds in Mb/sec at $(date -Is)"
phys=$(ls -1 /sys/class/net/*/speed);
# echo "[${0##*/}] phys=$phys"
for phy in ${phys}; do
#	echo "[${0##*/}] phy=$phy"
	if [[ ! "$phy" =~ "/sys/class/net/lo/speed" ]]; then
		tail -v "$phy"
	fi
done
# tail /sys/class/net/*/speed
exit
