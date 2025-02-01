#!/usr/bin/bash
## numdisks.sh


# date;df -hT -xtmpfs -xdevtmpfs -xsquashfs | tee /dev/stderr | tail -n +2 |  grep -e '^/dev/sd[[:alnum:]]\+' -e 'zfs' | wc -l
mkdir -p ~/.log
date;df -hT -xtmpfs -xdevtmpfs -xsquashfs | tee /dev/stderr | tail -n +2 | wc -l 



#date | tee -a ~/.log/numdisks.sh.log
#disks_data=$(df -hT -xtmpfs -xdevtmpfs -xsquashfs | tee -a ~/.log/numdisks.sh.log)
#disks_count=$( printf '%s\n' $disks_data | tail -n +2 | wc -l | tee -a ~/.log/numdisks.sh.log)
#printf '%s\n' $disks_data
#printf '%s\n' $disks_count
#echo "" | tee -a ~/.log/numdisks.sh.log >/dev/null


