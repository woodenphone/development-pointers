#!/usr/bin/env bash
## hash-two-locations-simple.sh
## Use hashdeep to calculate hashes for multiple locations
## ======================================== ##
## USAGE:
##   $ sudo ./$0
## (Must be run as superuser to access files)
## ======================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2025-04-22
## Modified: 2025-04-24
## ======================================== ##


## ==========< Welcome message >========== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2
echo "[${0##*/}] Running as: $(whoami)@$(hostname):$(pwd)" >&2
echo "[${0##*/}] Effective permissions: $(id)" >&2
orig_argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#orig_argv[@]}; argv=(${orig_argv[@]@Q});" >&2
## ==========< /Welcome message >========== ##

## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit	# Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset	# Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} ln${LINENO} '  ## Like: '+ /usr/local/bin/FileName.sh:123 echo foo bar baz'
# PS4='+ ${BASH_SOURCE[0]##*/} ln${LINENO} ' ## Like: '+ FileName.sh 123 echo foo bar baz'
# PS4='+ ${BASH_SOURCE[0]##*/}:${LINENO} ' ## Like: '+ FileName.sh:123 echo foo bar baz'
## ==========< /Shell setup >========== ##


## ==========< Functions >========== ##
## TODO: Slugify func
## ==========< /Functions >========== ##


## ==========< Config >========== ##
dest_dir="/media/my_hdd_1/ctrls-old-4tb-ssd.2025"
data_paths
## ==========< /Config >========== ##

## ==========< Hash data >========== ##
## Assure integrity of data.
echo "[${0##*/}] Hashing src at $(date -Is)" >&2
## Use all hash algos, as hashdeep does all algos together in one read pass.
time hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "/mnt/my_ssd_a/" > "${dest_dir?}/my_ssd_a.$(date -u +%Y-%m-%dT%H%M%S%z=@%s).hashlist"; 
echo "[${0##*/}] Done hashing src at $(date -Is)" >&2


echo "[${0##*/}] Hashing dest at $(date -Is)" >&2
## Use all hash algos, as hashdeep does all algos together in one read pass
time hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "/media/my_hdd_01/my_workdir/my_ssd_a.2025q2.description/" > "${dest_dir?}/my_ssd_a.2025q2.description.$(date -u +%Y-%m-%dT%H%M%S%z=@%s).hashlist";  
echo "[${0##*/}] Done hashing dest at $(date -Is)" >&2
## ==========< /Hash data >========== ##


## ==========< Hash hashlists >========== ##
## Assure integrity of hashlists themselves.
echo "[${0##*/}] Hashing hashlists at $(date -Is)" >&2
## --tag to explicitly list algo.
md5sum --tag ${dest_dir?}/*.hashlist > ${dest_dir?}/hashlists.md5
sha256sum --tag ${dest_dir?}/*.hashlist > ${dest_dir?}/hashlists.sha256

## Hashdeeep already does multiple algos ezpz, so just use that again
time hashdeep -c "md5,sha1,sha256,tiger,whirlpool" "${dest_dir?}"/*.hashlist > "${dest_dir?}/hashlists.$(date -u +%Y-%m-%dT%H%M%S%z=@%s).hashlist"; 
echo "[${0##*/}] Done hashing hashlists at $(date -Is)" >&2
## ==========< /Hash hashlists >========== ##


## =========< Ending message >========== ##
echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
## =========< /Ending message >========== ##
exit
