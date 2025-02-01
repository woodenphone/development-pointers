#!/bin/bash
## is-yt-dlp-running.sh
# $ ps -C 'yt-dlp' -f | tee /dev/tty | tail --lines=+2 | wc --lines
#cmds="$(pgrep -a "yt-dlp")"
echo "#[${0##*/}]" "$(date)"
res="$(ps -C 'yt-dlp' -f)"
echo "${res}"
num="$( echo "${res}" | tail --lines=+2 | wc --lines )"
echo "${num} processes."
