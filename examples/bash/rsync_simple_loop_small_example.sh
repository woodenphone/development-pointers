#!/usr/bin/env bash
## rsync_simple_loop_small_example.sh
## Copy files across, retry on error.
## ======================================== ##
## USAGE:
##   $ ./$0
##   i.e. $ ./rsync_simple_loop_small_example.sh
## ======================================== ##
## NOTES:
## - You need to edit the values in the array 'rsync_params' to suit your transfer.
##     Example placeholder values are included as hints on formatting.
## - This script expects a passwordless ssh keypair to be setup for network transfers.
##     (via ~/.ssh/id_<ALGO> and ~/.ssh/authorized_keys)
## - Be aware that rsync uses its own address format different to that used by ssh.
## - Ensure required src/dest dirs exist with correct permissions.
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
## Manpages: ---------- ---------- ---------- ----------
## - via $ man PAGE_NAME [SECTION_NUM]
##    e.g. $ man rsync 1
## rsync(1); rsyncd.conf(5); 
## ssh(1); sshd_config(5); sshd(8);
## bash(1); date(1); cp(1); 
## ======================================== ##
## Author: Ctrl-S
## Created: 2023-04-18
## Modified: 2025-05-26
## ======================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Override PATH to a sensible value: ---------- ----------
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing ---------- ----------
##
## Send xtrace messages to file:: ----------
## * https://serverfault.com/questions/296991/send-bash-x-output-to-logfile-without-interrupting-standard-output
## Create alternate file descriptor for xtrace messages (default is just using STDERR):
# xtrace_filepath="/tmp/${0##*/}.$(date %Y-%m-%dT%H-%M-%S%z).trace" ## Choose filepath for trace output.
# exec 19>"${xtrace_filepath?}" ## Allocate arbitrary FD pointing at trace path, 
# export BASH_XTRACEFD=19 ## Tell bash to use our FD for trace messages.
##
## Custom xtrace styles: ----------
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}:${LINENO} ' ## Like: '+ Script.sh:100 <EXPRESSION>'
PS4='+ ${BASH_SOURCE[0]:-${SHELL##*/}}:${LINENO} ' ## Like: '+ Script.sh:100 <EXPRESSION>'
##
## Enable debug tracing / line echoing: ----------
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace ## Print a trace of simple commands. (set -x) (Uses $PS4 and $BASH_XTRACEFD)
## ==========< /Shell setup >========== ##


## =========< Start message >========== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2
echo "[${0##*/}] Running as: $(whoami)@$(hostname) $(pwd)" >&2 
echo "[${0##*/}] Effective permissions (id): $(id)" >&2
# echo "[${0##*/}] argc=$#; argv=(${*[*]@Q});" >&2 # Print CLI params.
argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#argv[@]}; argv=( ${argv[@]@Q} );" >&2
## =========< /Start message >========== ##


## =========< Config >========== ##
max_retries=100 # Die after this many total attempts.
retry_delay_secs=30 # Sleep before retry.
## =========< /Config >========== ##


## Stash copy of script with results:
# echo "[${0##*/}] Stashing copy of script to dest dir, to record how and why transfer was done." >&2
# cp -v "$0" "/media/DRIVE_NAME/PATH_TO/DEST/"


## =========< Main loop >========== ##
for (( i=0; i<=${max_retries?}; i++ )); do
	echo "[${0##*/}]" "Start of loop, i=${i@Q} (at $(date -Is))" >&2
	rsync_params=( ## Prepare cmd/params as array to permit commenting, logging, etc.
		## $ rsync [...]
		## Test mode: ---------- ----------
		# --dry-run ## 'perform a trial run with no changes made'
		## Ensure verbatim copy: ---------- ----------
		--archive
		--no-links ## Skip symlinks.
		## Logging params: ---------- ----------
		# --verbose ## "increase verbosity"
		# --progress ## "show progress during transfer"
		# --human-readable ## "output numbers in a human-readable format"
		--info="stats1,progress2" ## Only display progress and end of run stats.	
		# --info=STATS ## Show stats at end of run. ( see $ rsync --info=help )
		## Use partial files to allow resuming and avoid invalid files: ---------- ----------
		--partial
		## File handling params: ---------- ----------
		# --remove-source-files ## Deletes files from source after they are transferred.
		# --checksum ## Checkums determine if file modiified instead of modtime; Slower and much more disk IO!
		--one-file-system ## "don't cross filesystem boundaries"
		## Filter params: ---------- ----------
		# --filter="-! PATTERN_HERE*" ## Only transfer files matching pattern.
		## Network params: ---------- ----------
		--rsh="ssh -p 22" ## Connect using ssh on specified port. (This is where the security comes from.)
		# --rsync-path="sudo rsync" ## Command to execute on remote side. ('sudo rsync' to run rsync as root)
		--bwlimit=10000 ## Throttle network use (In KB/sec).
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
	## Display/log params:
	# echo "[${0##*/}] rsync_params: $( builtin printf '%q ' "${rsync_params[@]}" )"
	echo "[${0##*/}] rsync_params=( ${rsync_params[*]@Q} );" >&2
	## Run actual command:
	time rsync "${rsync_params[@]}" 
	rsync_exit_status=$? ## Record exit status for comparison. (bash "time" passes along exit status)
	echo "[${0##*/}] rsync_exit_status=${rsync_exit_status@Q} (at $(date -Is))" >&2 # Report exit status.
	## Decide if retry is appropriate based on exit status:
	case ${rsync_exit_status?} in
		## Exit status found in rsync manpage; Add extra exit code handlers if/as needed.
		0 ) ## "0 - Success" -> Finished.
			echo "[${0##*/}]" "0 - Success" "(break from loop)" >&2
			break ## Done with loop.
			;;
		30 ) ## "30 - Timeout in data send/receive" -> Retry.
			echo "[${0##*/}]" "30 - Timeout in data send/receive" "(continue loop)" >&2
			;;
		255 ) ## 255, reported broken pipe error case -> Retry.
			echo "[${0##*/}]" "255 - rsync failed" "(continue loop)" >&2
			;;
		* ) ## Any other exit status -> die for safety.
			echo "[${0##*/}]" "Unhandled exit status" "(break from loop)" >&2
			break
			;;
	esac
	## Delay before retry:
	echo "[${0##*/}] Sleeping for ${retry_delay_secs?} secs (at $(date -Is))" >&2
	sleep ${retry_delay_secs?}
done
echo "[${0##*/}] Final value of loop counter: i=${i@Q}" >&2
## =========< Main loop >========== ##


## =========< Ending message >========== ##
echo "[${0##*/}] Finished. Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete (at $(date -Is))" >&2
## =========< /Ending message >========== ##
exit
