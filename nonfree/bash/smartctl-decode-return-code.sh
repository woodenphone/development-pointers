#!/usr/bin/env bash
## smartctl-decode-return-code.sh
## The example from the smartctl manpage.
## ======================================== ##
## USAGE:
## ./$0 SMARTCTL_PARAMS...
## ======================================== ##
## Copied from https://man.archlinux.org/man/smartctl.8#EXIT_STATUS
## ======================================== ##
## LICENSE: MIT (Except copypasted section)
## AUTHOR: Ctrl-S
## CREATED: 2025-05-18
## MODIFIED: 2025-05-18
## ======================================== ##
echo "[${0##*/}] Invoked with argv=( ${*[*]@Q} ) (at $(date -Is))"

smartctl "$@" ## Run smartctl with same params this script got.

## Copied from https://man.archlinux.org/man/smartctl.8#EXIT_STATUS
## ====< Begin copypasted section >===== ##
val=$?; mask=1
for i in 0 1 2 3 4 5 6 7; do
  echo "Bit $i: $(((val & mask) && 1))"
  mask=$((mask << 1))
done
## ====< End copypasted section >===== ##

exit ## Exit script and pass back out most recent return code.
