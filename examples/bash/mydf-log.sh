#!/usr/bin/bash
## mydf-log
## A convenient df invocation.
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-12-24
## MODIFIED: 2023-12-24
## ==================================== ##

## Use environment var if set, otherwise default path.
outfile="${MYDF_LOGFILE:-${HOME}/.mydf-log.txt}"

printf "[${USER}@${HOSTNAME} ${PWD}]\$ $@\n" | tee -a ${outfile} > /dev/null # Only display in logfile.

date -Is | tee -a ${outfile} ## When measurement was taken, in an obvious format.
df --local --total --human-readable --exclude-type=devtmpfs --exclude-type=tmpfs ${*[@]} | tee -a ${outfile}

exit
