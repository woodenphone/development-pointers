#!/usr/bin/env bash
## weed-volume-example-thing.sh
## ======================================== ##
## LICENSE: MIT
## AUTHOR: Ctrl-S
## CREATED: 2024-12-02
## MODIFIED:  2024-12-02
## ======================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
# set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Shell special vars:
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read.
# set -o xtrace # Print a trace of simple commands. (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ ${BASH_SOURCE[0]}:${LINENO} ' 
## ==========< /Shell setup >========== ##


echo "[${0##*/}] Script starting (at $(date +%Y-%m-%dT%H:%M:%S%z))"
echo "[${0##*/}] Running as: ${USER?}@${HOSTNAME?}:${PWD?}"
echo "[${0##*/}] Current security context (via \$ id): $(id)"


## ==========< VolumeServer example >========== ##
voldirs="$( echo /media/ExampleHDD/weed{1..10})"
echo "[${0##*/}] voldirs=(${voldirs[*]@Q})"

echo "[${0##*/}] Attempting to create dirs... (at $(date +%Y-%m-%dT%H:%M:%S%z))"
for voldir in "$( echo /media/ExampleHDD/weed{1..10} | sed "s/ /,/g" )"; do
	mkdir -v "${voldir?}" || /bin/true
done 

echo "[${0##*/}] Concat volume dirpaths for params... (at $(date +%Y-%m-%dT%H:%M:%S%z))"
voldirs_for_arg="$( echo ${voldirs[@]} | sed "s/ /,/g" )" ## Join with commas, no trailing coma.

echo "[${0##*/}] Building params... (at $(date +%Y-%m-%dT%H:%M:%S%z))"
vol_cmd=(
	weed
	## ---------------------------------------- ##
	## Logging params (must go between 'weed' and the subcommand):
	## TODO: Log params.
	## ---------------------------------------- ##
	## Weed subcommand:
	volume
	## ---------------------------------------- ##
	##: Common across cluster:
	-mserver="localhost:9333"
	## ---------------------------------------- ##
	## Identifies this Rack and VolumeServer:
	# -ip="server_name" ## (Defaults to guessing own IP addr)
	# -ip.bind  ## (Defaults to whatever '-ip' has set)
	-port="9001"
	# -port.grpc="19001"  ## (defaults to '-port' + 10000)
	## ---------------------------------------- ##
	## Replication-related:
	# -dataCenter="demo-dc-alpha" ## (Used to determine replication structure)
	# -rack="demo-box-one" ## (Used to determine replication structure)
	# -disk=""  ## (Used to determine replication structure)
	## ---------------------------------------- ##
	## Disk parameters:
	# -minFreeSpace="100G" ## We'd use this if not just faking disks
	-max="80" ## 0 is as many as will fit in free space.
	# -dir="$( echo /media/ExampleHDD/weed{1..10} | sed "s/\0/,/g" )"
	-dir="${voldirs_for_arg?}"
)
echo "[${0##*/}] vol_cmd=${vol_cmd[*]@Q}"
echo "[${0##*/}] Running command... (at $(date +%Y-%m-%dT%H:%M:%S%z))"
time "${vol_cmd[@]}"
echo "[${0##*/}] Command exited with code $? (at $(date +%Y-%m-%dT%H:%M:%S%z))"
## ==========< /VolumeServer example >========== ##


echo "[${0##*/}] Script finished (at $(date -Is)), took $((${SECONDS?}/86400))d $((${SECONDS?}/3600))h $(((${SECONDS?}/60) % 60))m $((${SECONDS?}%60))s (${SECONDS?} seconds total) to complete."
exit

	# -port="$(echo 90{01..10} | sed "s/ /,/g")"
	# -port.grpc="$(echo 190{01..10} | sed 's/ /,/g')" ## (defaults to port+10000)
	# echo 90{01..10} | sed "s/ /,/g"}
