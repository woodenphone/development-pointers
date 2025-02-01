#!/usr/bin/env bash
## my-lsblk-only-hdds.sh
## List only HDDs.
## ==================================== ##
## USAGE: ./$0
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-11-24
## MODIFIED: 2023-11-24
## ==================================== ##
echo "[${0##*/}] Scanning (at $(date -Is))"
## First field filters rotational or not:
# lsblk -o 'ROTA,KNAME,SIZE,MODEL,SERIAL,LABEL,UUID,PARTUUID' | gawk '$1 != "0" {print $0}' ## awk method.

## lsblk's builtin filter compares if rotational:
lsblk --paths --filter 'ROTA == 1' --output 'KNAME,SIZE,MODEL,SERIAL,FSTYPE,LABEL,UUID,PARTUUID' ## Filter method, see manpage of lsblk(1).
exit
