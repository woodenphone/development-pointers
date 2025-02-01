#!/bin/bash
## setpriv-example.sh
## Example usage of setpriv to descend from root to a user to run some command.
## USAGE: $0 PROGRAM [ARGUMENTS...]
## AUTHOR: Ctrl-S, 2022-06-01 - 2022-06-01.
## LICENSE: BSD0
echo  "#[${0##*/}]" "Starting" "$(date +%Y-%m-%d_%H-%M%z=@%s)"
echo  "#[${0##*/}]" "argc:" "$#" "argv:" "$( builtin printf '"%q" ' "$@" )"

## Enable excessive debug output:
set -o xtrace -o verbose;


## Run given invocation as less-priveliged user with setpriv:
## $ setpriv [options] program [arguments]
## ex: setpriv --reuid=1000 --regid=1000 --init-groups
## e.g. setpriv --reuid=${UID-1000} --regid=${GID-1000} --init-groups id
setpriv --reuid=${UID-1000} --regid=${GID-1000} --init-groups "$@[@]"


echo  "#[${0##*/}]" "Finished" "$(date +%Y-%m-%d_%H-%M%z=@%s)"
exit
##==========< Notes >==========##
## Use $GID if it is set; if unset use 1000: ${GID-1000}
## Script args as seperate strings: "$@[@]"
## https://man7.org/linux/man-pages/man1/setpriv.1.html
## https://man7.org/linux/man-pages/man1/su.1.html
## https://man7.org/linux/man-pages/man1/runuser.1.html
## https://man7.org/linux/man-pages/man8/sudo.8.html
## https://man7.org/linux/man-pages/man1/set.1p.html
