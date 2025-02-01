#!/usr/bin/env bash
## mylsblk-id
## A useful lsblk invocation.
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2024-08-28
## MODIFIED: 2023-11-24
## ==================================== ##
date -Is
params=( ## $ lsblk
	-o KNAME,SIZE,MODEL,SERIAL,LABEL,MOUNTPOINT,WWN,UUID,PARTUUID
)
if [[ $# -ne 0 ]]; then ## Append script arguments if any were given.
	params=( "${params[@]}" "$@" )
fi
lsblk "${params[@]}"
## $ lsblk -o KNAME,SIZE,MODEL,SERIAL,LABEL,MOUNTPOINT,WWN,UUID,PARTUUID
exit
