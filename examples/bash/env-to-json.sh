#!/usr/bin/env bash
## env-to-json.sh
## Dump current environment in JSON format to a file.
## ==================================== ##
## USAGE: $ ./$0 FILE
## ==================================== ##
## REFERENCE:
## * https://www.man7.org/linux/man-pages/man1/pr.1.html
## * https://stackoverflow.com/questions/65707623/export-environment-variables-to-json-in-bash#65707749
## * https://jqlang.github.io/jq/manual/#del
## ==================================== ##
## LICENSE: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2024-10-06
## MODIFIED: 2024-10-06
## ==================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing setup:
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value; (used for -x / XTRACE). Like: '+++ STATEMENT...'
# PS4='+ $LINENO: ' ## Like: '+++ <CURRENT_LINENO> STATEMENT...'
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## Like: ' '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO STATEMENT...'
# PS4='+ ${BASH_SOURCE[0]} ln${LINENO} ' ## Like: '+++ <FILE> ln<CURRENT_LINENO> STATEMENT...'
## ==========< /Shell setup >========== ##


## ==========< Functions >========== ##
func_indent_console_wrapped() {
	## Indent and word-wrap long strings from STDIN.
	## * https://www.man7.org/linux/man-pages/man1/pr.1.html
	## * https://www.man7.org/linux/man-pages/man1/fmt.1.html
	local indent=4 ## Depth to indent to.
	local terminal_width="$(tput cols)"
	local target_columns="$(( ${terminal_width?} - ${indent?} ))" ## Fit in terminal.
	## Split into lines
	## | indent lines
	fmt --width="${target_columns?}" "-" \
	| pr --omit-pagination --indent="${indent?}" --width="${target_columns?}" --join-lines --separator="\n"
		# | sed 's/^/  /'
}

## ==========< /Functions >========== ##


## ==========< Start-of-script message >========== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2
echo "[${0##*/}] Running as: $(whoami)@$(hostname):$(pwd)" >&2
echo "[${0##*/}] Effective permissions: $(id)" >&2
argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#argv[@]}; argv=${argv[@]@Q};" >&2
## ==========< /Start-of-script message >========== ##


## ==========< Argument checking >========== ##
## dnf needs some sort of parameters.
if [[ $# -ne 1 ]]; then 
	printf '%s\n' "[${0##*/}] Error: Invalid number of arguments given, expected 1." >&2; 
	printf '\t%s\n' "Was given: argc=${#argv[@]}; argv=${argv[@]@Q};"
	exit 1; 
fi
## ==========< /Argument checking >========== ##


## ==========< Argument handling >========== ##
output_file="${1:-${PWD?}/env.json}" ## First argument  a default filename.
## ==========< /Argument handling >========== ##



## ==========< Dump environment to JSON >========== ##
echo "[${0##*/}] Dumping shell environment (in JSON format) to output_file=${output_file@Q} (at $(date -Is))" >&2
## * https://stackoverflow.com/questions/65707623/export-environment-variables-to-json-in-bash#65707749
## * https://jqlang.github.io/jq/manual/#del
env_json=$(jq -n '$ENV | del(._, .SHLVL)')
printf '%s\n' "${env_json?}" > "${output_file?}"
printf '%s\n' "env_json=${env_json@Q}" >&2 ## pr for console-width aware indent.
## ==========< /Dump environment to JSON >========== ##


## End-of-script message:
printf '%s\n' "[${0##*/}] Script finished (at $(date -Is)) and took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
exit
