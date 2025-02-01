#!/usr/bin/env bash
## ia-download-many.sh
## Simple thing to run many internetarchive / archive.org 
##   item downloads sequentially.
## Requires python3 internetarchive pip3 package.
##
## Copypaste this to a new file and put a bunch of item ID slugs in.
## ======================================== ##
## Author: Ctrl-S
## Created: 2023-11-18
## Modified: 2023-11-18
## ======================================== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2

## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Override PATH to a sensible value: ---------- ----------
# export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
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
# PS4='+ ${BASH_SOURCE[0]:-${SHELL##*/}}:${LINENO} ' ## Like: '+ Script.sh:100 <EXPRESSION>'
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
PS4='+ [$( if ! [[ ${#BASH_SOURCE[@]} -lt 1 ]]; then echo "${SHELL##*/}"; else echo "${BASH_SOURCE[0]##*/}"; fi; ):${LINENO}] ' ## Like: '+ [Script.sh:100] <EXPRESSION>' (intended for multi-file projects.)
##
## Enable debug tracing / line echoing: ----------
set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace ## Print a trace of simple commands. (set -x) (Uses $PS4 and $BASH_XTRACEFD)
## ==========< /Shell setup >========== ##

## =========< Functions >========== ##
message() { ## WIP
	## Like echo but prefix with script name and append to logfile.
	## Expects args: $1 [$2...$n] - Strings as like for 'echo' command.
	## If declared: $log - filepath of logfile.
	## -----
	( ## contain vars declared via read
	read -r lineno funcname file <<<$(caller 2) ## Grandparent (2) because we are in a subshell inside a function.
	local message_prefix="[${file##*/}:${funcname}:${lineno}]"
	echo "${message_prefix}" "${@[@]}" | tee -a "${log:-/dev/null}" >&2
	)
}

_hello_message_script_argv=( "$@" ) ## Capture script argv to pass accross function boundary.
fn_hello_message() {
	## Display a informational message about script run context.
	echo "[${0##*/}] Starting (at $(date -Is))"
	echo "[${0##*/}] Running as: $(whoami)@$(hostname) $(pwd)" 
	echo "[${0##*/}] Effective permissions (id): $(id)"
	echo "[${0##*/}] argc=${#_hello_message_script_argv[@]}; argv=( ${_hello_message_script_argv[@]@Q} );"
}

fn_coerce_to_itemname() { ## WIP
	## Coerce to an internetarchive itemname
	local string="${1?}"
	if ( printf '%s\n' "${string?}" | grep -q 'archive.org/' ); then
		## URL case:
		## TODO: PCRE regex to convert URL to itemname.
		printf '%s\n' "${string?}" | perl -n -e'/(?!http)?s?[:\/]*([\w_\.-]+)\.([\w_\.-]+)\/([\w_\.-]+)\/([\w_\.-]+)/ && print $1' ## TODO:FIXME.
	else ## Not a URL case:
		printf '%s\n' "${string?}"
	fi
}

fn_download_one_item() { ## WIP
	## Download one item from internetarchive
	item_name=${1?}
	echo "[${0##*/}] attempting download of item_name=${item_name@Q} (at $(date -Is))" >&2
	## Attempt download of item:
	time ia download "${item_name?}"
	local returned_exit_status=$? ## Record exit status for comparison.
	echo "[${0##*/}] returned_exit_status=${returned_exit_status@Q}" >&2 # Report exit status.
}

fn_download_from_listfile() { ## WIP
	## Download internetarchive items line-by-line from a list file.
	local list_file="${1?}"
	echo "[${0##*/}] Begin looping over lines from list_file=${list_file@Q} (at $(date -Is))" >&2
	local prev_line="" # Empty if first item
	while IFS='' read -r LINE || [ -n "${LINE}" ]; do
		echo "[${0##*/}] LINE=${LINE@Q}"
		fn_download_one_item "${LINE}"
		if [[ -z "${prev_line}" ]]; then ## If first line in file
			sleep 600
		fi
		prev_line="${LINE}"
	done < "${list_file?}" ## Feed in line by line.
	echo "[${0##*/}] Finished processing lines from list_file=${list_file@Q} (at $(date -Is))" >&2
}
## =========< /Functions >========== ##



## =========< Main >========== ##
# fn_hello_message
## Accept script argument(s):
list_file="${1?}" 
## Perform work:
fn_download_from_listfile "${list_file?}"
## =========< /Main >========== ##



echo "[${0##*/}] Finished. Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete (at $(date -Is))"
exit
