#!/usr/bin/env bash
## btrfs-scrub-mounted.status.sh
## Get scrub status on all mounted BTRFS filesystems.
## ======================================== ##
## USAGE: $ ./$0 
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2024-08-20
## MODIFIED: 2024-08-20
## ======================================== ##
echo "[${0##*/}] Script starting at $(date -Is)" >&2


lsblk --noheadings --raw --paths --output 'NAME,FSTYPE,MOUNTPOINT' | awk '$2 ~ "^btrfs$" { print $3 };' | tee /dev/stderr | sudo xargs --verbose -I '%REPL%' -- btrfs scrub status '%REPL%'


echo "[${0##*/}] Script finished at $(date -Is)" >&2
exit
