#!/bin/bash
## cmdlog.sh
## Run a command and store the output, recording what it was.
## USAGE: $ cmdlog OUTFILE COMMAND...
##
## LICENCE: 0BSD (I don't want no trabbre.)
## SPDX-License-Identifier: 0BSD
## AUTHOR: Ctrl-S
## CREATED: 2022-02-22
## MODIFIED: 2022-02-22


## Store output dest:
outfile=$1
## Remove output dest from $@
shift 1
# Store the command to run in a var:
command=$@

## Define our format for the elapsed time counter:
export fmt_time='\n## time: %Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)k%Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps'
## See: https://www.man7.org/linux/man-pages/man1/time.1.html

## Define format for timestamps:
# fmt_timestamp='+%Y-%m-%dT%H%M%S%z=@%s' # 2022-02-22T095722+0800=@1645495042
# fmt_timestamp='+%Y-%m-%dT%H:%M:%S%z=@%s' # 2022-02-22T09:56:28+0800=@1645494988
fmt_timestamp='+%Y-%m-%dT%H:%M:%S%z (= @%s)' # 2022-02-22T10:00:05+0800 (= @1645495205)
# fmt_timestamp='+%Y-%m-%dT%H:%M:%S%z' # 2022-02-22T09:56:28+0800
# fmt_timestamp='+%Y-%m-%dT%H:%M:%S' # 2022-02-22T09:56:28
# fmt_timestamp='+%Y-%m-%dT%H%M%S%z' # 2022-02-22T095655+0800
# fmt_timestamp='+@%s' # @1645495029
## See: https://www.man7.org/linux/man-pages/man1/date.1.html

## Create the output file with header:
echo "## cmdlog()" | tee -a "${outfile}"
echo "## Started at $(date ${fmt_timestamp})" | tee -a "${outfile}"
echo "## $(whoami)@$(hostname):$(pwd)$" ${command[@]} | tee -a "${outfile}" # (Meant to look Like BASH's PS1)

## Run the command, timing it, and recording all STDOUT and STDERR to file.
/bin/time --format="${fmt_time}" ${command[@]}  2>&1 | tee -a "${outfile}"

## Append footer:
echo "## Finished at $(date ${fmt_timestamp})" | tee -a "${outfile}"

exit