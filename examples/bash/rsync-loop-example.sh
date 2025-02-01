#!/usr/bin/bash
## rsync-loop-example.sh
## Transfer files via rsync with loop to tolerate network faults.
## ======================================== ##
## USAGE:
##   $ ./$0
##
## Optionally give extra args to passthrough to rsync:
##   $ ./$0 [RSYNC_PARAMS]
##
## Edit script file to suit your task - fill in the example values with something sensible.
## Once values are suited to your needs, execute script. 
## ======================================== ##
## NOTES:
## - This script expects a passwordless ssh keypair to be setup for network transfers.
##     (via ~/.ssh/id_<ALGO> and ~/.ssh/authorized_keys)
## 
## - Be aware that rsync uses its own address format different to that used by ssh.
## ======================================== ##
## REFERENCE:
## Rsync: ---------- ----------
## * https://www.man7.org/linux/man-pages/man1/rsync.1.html
## * https://www.man7.org/linux/man-pages/man5/rsyncd.conf.5.html
## * https://rsync.samba.org/
## * https://rsync.samba.org/documentation.html
## * https://download.samba.org/pub/rsync/rsync.1
## * https://download.samba.org/pub/rsync/rsyncd.conf.5
## * https://phoenixnap.com/kb/rsync-command-linux-examples
## SSH: ---------- ----------
## * https://www.man7.org/linux/man-pages/man1/ssh.1.html
## * https://www.man7.org/linux/man-pages/man5/sshd_config.5.html
## * https://www.man7.org/linux/man-pages/man8/sshd.8.html
## Misc: ---------- ----------
## * https://www.man7.org/linux/man-pages/man1/date.1.html
## Shell scripting: ---------- ----------
## * https://devhints.io/bash
## ======================================== ##
## LICENSE: GPLv3
## Author: Ctrl-S
## Created: 2024-05-30
## Modified: 2024-11-04
## ======================================== ##
# set -x # Print statements as they are interpreted (bash option).
# set -v # Print lines as they are run (bash option).
echo "#[${0##*/}]" "Starting" "$(date -Is)" >&2
echo "#[${0##*/}]" "Running as: $(whoami)@$(hostname) $(pwd)" >&2
echo "#[${0##*/}]" "Effective permissions (id):" $(id) >&2
echo "#[${0##*/}] argc=$#; argv=${*[*]@Q};" >&2


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} ln${LINENO} ' 
## ==========< /Shell setup >========== ##


## =========< Config >========== ##
max_retries=100 # Die after this many total attempts.
retry_delay_secs=30 # Sleep before retry.

## Parameters / arguments for rsync:
rsync_params=( ## Prepare cmd/params as array to permit commenting, logging, etc.
	## Ensure verbatim copy: ---------- ----------
	--archive
	--no-links ## Skip symlinks.
	## Logging params: ---------- ----------
	# --verbose
	# --progress
	# --human-readable
	--info=stats1,progress2 ## Only display progress and end of run stats.	
	# --info=STATS ## Show stats at end of run. ( see $ rsync --info=help )
	## Use partial files to allow resuming and avoid invalid files: ---------- ----------
	--partial
	## File handling params: ---------- ----------
	# --remove-source-files ## Deletes files from source after they are transferred.
	# --checksum ## Checkums determine if file modiified instead of modtime; Slower and much more disk IO!
	## Filter params: ---------- ----------
	# --filter="-! PATTERN_HERE*" ## Only transfer files matching pattern.
	## Network params: ---------- ----------
	--rsh="ssh -p 22" ## Connect using ssh on specified port. (This is where the security comes from.)
	--bwlimit=10000 ## In KB/sec.
	# --compress ## Uses more CPU, situationally useful.
	## Source: ---------- ----------
	"USERNAME@REMOTE_HOST:/REMOTE_PATH/" # Trailing forwardslash means dir contents.
	## Optional extra source paths; see: https://www.man7.org/linux/man-pages/man1/rsync.1.html#ADVANCED_USAGE
	# ":/REMOTE_PATH2" 
	# "USERNAME@REMOTE_HOST:/REMOTE_PATH3/" 
	# "USERNAME@REMOTE_HOST:/REMOTE_PATH4/" 
	## Dest: ---------- ----------
	"/LOCAL_PATH/"
)
# rsync_params="$@[@]" ## Uncomment to use script argv. i.e. $ ./script.sh [YOUR RSYNC PARAMS...]
## =========< /Config >========== ##


## =========< Take / apssthrough params from CLI >========== ##
## If script was given CLI arguments, handle them here.
## * https://web.archive.org/web/20230320184716/https://wiki.bash-hackers.org/scripting/posparams
echo "#[${0##*/}]" "\$#=( ${#@Q} );" >&2 ## DEVEL REMOVEME
if [[ $# -gt 1 ]]; then # If script was given CLI arguments.
    echo "#[${0##*/}]" "argv=( ${@[*]@Q} );" >&2
    echo "#[${0##*/}]" "Passing through script params to rsync" >&2
    # Use CLI params as rsync params.
    rsync_params=( "${@:1}" ) # 0:script.sh 1:FirstArg
    echo "#[${0##*/}]" "rsync_params=( ${rsync_params[*]@Q} );" >&2 ## DEVEL REMOVEME
fi
## =========< Take / apssthrough params from CLI >========== ##


## =========< Main loop >========== ##
for (( i=0; i<=${max_retries?}; i++ )); do
	echo "#[${0##*/}]" "Start of loop, i=${i@Q} at $(date -Is)" >&2
	## Display/log params:
	# echo "#[${0##*/}]" "rsync_params:" "$( builtin printf '%q ' "${rsync_params[@]}" )"
	echo "#[${0##*/}]" "rsync_params=( ${rsync_params[*]@Q} );" >&2 # TESTME: New array repr.
	## Run actual command:
	time rsync "${rsync_params[@]}" 
	rsync_exit_status=$? ## Record exit status for comparison. (bash "time" passes along exit status)
	echo "#[${0##*/}]" "rsync_exit_status=${rsync_exit_status@Q} at $(date -Is)" >&2 # Report exit status.
	## Decide if retry is appropriate based on exit status:
	case ${rsync_exit_status?} in
		## Exit status found in rsync manpage; Add extra exit code handlers if/as needed.
		0 ) ## "0 - Success" -> Finished.
			echo "#[${0##*/}]" "0 - Success" "(break from loop)" >&2
			break ## Done with loop.
			;;
		30 ) ## "30 - Timeout in data send/receive" -> Retry.
			echo "#[${0##*/}]" "30 - Timeout in data send/receive" "(continue loop)" >&2
			;;
		255 ) ## 255, reported broken pipe error case -> Retry.
			echo "#[${0##*/}]" "255 - rsync failed" "(continue loop)" >&2
			;;
		* ) ## Any other exit status -> die for safety.
			echo "#[${0##*/}]" "Unhandled exit status" "(break from loop)" >&2
			break
			;;
	esac
	## Delay before retry:
	echo "#[${0##*/}]" "Sleeping for ${retry_delay_secs?} secs at $(date -Is)" >&2
	sleep ${retry_delay_secs?}
done
echo "#[${0##*/}]" "Final value of loop counter:" "i=${i@Q}" >&2
## =========< Main loop >========== ##


echo "[${0##*/}] Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
echo "#[${0##*/}]" "Finished" "$(date -Is)" >&2
exit
