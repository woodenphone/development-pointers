#!/usr/bin/env bash
## mutex.sh
## Simple mutex
## ! UNFINISHED !
## ==================================== ##
## USAGE:
## $ ./$0 
## ==================================== ##
## https://www.man7.org/linux/man-pages/man1/kill.1.html
## https://stackoverflow.com/questions/6870221/is-there-any-mutex-semaphore-mechanism-in-shell-scripts
## https://stackoverflow.com/questions/185451/quick-and-dirty-way-to-ensure-only-one-instance-of-a-shell-script-is-running-at
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2024-05-06
## MODIFIED: 2024-05-06
## ==================================== ##
# set -x ## Print statements as they are interpreted.


## ==========< Functions >========== ##

slugify() {
	## From: https://stackoverflow.com/questions/47050589/create-url-friendly-slug-with-pure-bash#49035906
    echo "$1" | iconv -t ascii//TRANSLIT -c | sed -r s/[~\^]+//g | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z
}

mutex() {
	## Calsulate deterministic mutex path:
	mutex_path="/tmp/${0##*/}.pid"
	if [[ $kill_old ]];
		kill ${mutex_path}
	

}

if ! mkdir /tmp/${0##*/}.lock 2>/dev/null; then
    echo "Myscript is already running." >&2
    exit 1
fi

## ==========< /Functions >========== ##

mutex_path="/tmp/${0##*/}.pid"
