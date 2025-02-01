#!/usr/bin/env bash
## xargs-ghorg-example-bravo.sh
## Runs 'ghorg' git-hoster organization downloader for many targets.
## (Copypasta)
## ======================================== ##
## USAGE: $ ./$0
## (Just run the script.)
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-01-19
## MODIFIED: 2025-01-19
## ======================================== ##
script_argv=( "$@" ) ## Capture script argv to pass to anywhere within script.
echo "[${0##*/}] Starting (at $(date -Is))"
echo "[${0##*/}] Invoked with with argc=${#script_argv}; script_argv=(${script_argv@Q});" >&2

## Uses shell invocation to do a sleep between tasks:
## e.g. $ sh -c '{ echo %; sleep 1; }'
printf '%s\0' "$@" | xargs --null --verbose --no-run-if-empty '-I{}' -- bash -x -c 'ghorg clone --clone-type org {}; sleep 600;'


echo "[${0##*/}] Finished. Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete (at $(date -Is))" >&2
exit
