#!/usr/bin/env bash
## disk-keepawake.sh
## To keep a disk device awake/active; i.e. inhibit disk sleep.
## e.g. for external enclosures.
## ======================================== ##
## USAGE:
## ./$0 --device=/dev/sdz --sleep=10
## ======================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2025-05-01
## Modified: 2025-05-01
## ======================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
# set -o errexit	# Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset	# Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} ln${LINENO} '  ## Like: '+ /usr/local/bin/FileName.sh:123 echo foo bar baz'
# PS4='+ ${BASH_SOURCE[0]##*/} ln${LINENO} ' ## Like: '+ FileName.sh 123 echo foo bar baz'
# PS4='+ ${BASH_SOURCE[0]##*/}:${LINENO} ' ## Like: '+ FileName.sh:123 echo foo bar baz'
## ==========< /Shell setup >========== ##


## ==========< Stash params >========== ##
## Copy script argv / $@ into another array, so function params, shift,  etc. cant interfere.
argv=("$@") # Argument values
argc="${#argv[@]}" # Arugment count
## ==========< /Stash params >========== ##


## ==========< Functions >========== ##
## Bash functions share parent scope for variables; 
## 'local' keyword is required to prevent overwriting variables outside the function.
print_usage() {
	## Print help message for this script to STDERR.
	printf '%s\n' "USAGE:" >&2
	local msg_lines=( ## Indented section.
		"[-l|--log | --logfile] - Path to write log to"
		"[-v|--verbose] - Enable verbose output."
		"[-d|--device] DEVICE - device file to use."
		"[-s | -s=* | --sleep | --sleep=*] - input file to use."
		"[-?|--help] - Display this help text."
		"[--] - Signals any further parameters are to be passed onwards."
		"" # Seperator.
	)
	printf '\t%s\n' "${msg_lines[@]}" >&2
}

print_invalid_param_msg() {
	## Print help message for this script to STDERR.
	echo "[${0##*/}] Error: Unexpected argument." >&2
	local msg_lines=( ## Indented section.
		"position: i=${i?};" 
		"value: arg=${arg@Q};"
		"Was given ${argc?} arguments:"
		"${argv[*]@Q};"
		"" # Seperator.
	)
	printf '\t%s\n' "${msg_lines[@]}" >&2
}

repr() {
	## Print reusable representation of value
	echo "[${0##*/}] $(declare -p $1)"
}
## ==========< /Functions >========== ##



## ==========< Defaults >========== ##
## Defaults if optional params are unset.
verbose='' ## Empty string means 0 verbosity.
sleep_interval="30" ## Seconds between reads.
## ==========< /Defaults >========== ##

## ==========< Handle CLI Parameters >========== ##
echo "[${0##*/}] Begin handling CLI parameters (at $(date -Is))" >&2

## Exit if no params:
if [[ "$#" == 0 ]]; then 
	echo "[${0##*/}] Error: Expected at least one parameter. Exiting." >&2
	print_usage
	exit 1 ## Nonzero status means failure.
fi

## Copy script argv / $@ into another array, so function params, shift,  etc. cant interfere.
argv=("$@") # Argument values
argc="${#argv[@]}" # Arugment count
echo "[${0##*/}] Starting (at $(date -Is))" >&2
echo "[${0##*/}] Running as: $(whoami)@$(hostname):$(pwd)" >&2
echo "[${0##*/}] Effective permissions: $(id)" >&2
echo "[${0##*/}] argc=${argc?}; argv=${argv[*]@Q};" >&2 ## Print params.
echo "[${0##*/}] Processing arguments:" >&2 ## Print params.
kv_pat='^--?[a-zA-Z0-9_-]+=' # Key-value split pattern.
for ((i = 0 ; i < ${argc?} ; i++)); do ## Loop over array by index - 0,1,2...
	arg="${argv[$i]}" # Current param value.
	echo "[${0##*/}] Processing arg: i=${i?}; arg=${arg@Q};" >&2 ## Print params.
	if [[ "${arg?}" =~ ^- && ! "${arg?}" == "--" ]]; then ## If flag type param
		case "${arg?}" in
			## Operational params ---------- 
			-d | -d=* | --device | --device=* )
			if [[ ${arg?} =~ ${kv_pat?} ]]; then 
				device="${arg#*=}"; ## Crop to after '='.
			else 
				i=$(($i + 1)); ## Value is next param in array.
				device="$argv[$i]"; 
			fi
			echo "[${0##*/}] device=${device@Q}" >&2 ## repr()
			;;

			-s | -s=* | --sleep | --sleep=* )
			if [[ ${arg?} =~ ${kv_pat?} ]]; then 
				sleep_interval="${arg#*=}"; ## Crop to after '='.
			else 
				i=$(($i + 1)); ## Value is next param in array.
				sleep_interval="$argv[$i]"; 
			fi
			echo "[${0##*/}] sleep_interval=${sleep_interval@Q}" >&2 ## repr()
			;;

			## Script meta params ---------- 
			-l | -l=* | --log | --log=* | --logfile | --logfile=* )
			if [[ ${arg?} =~ ${kv_pat?} ]]; then 
				log="${arg#*=}"; ## Crop to after '='.
			else 
				i=$(($i + 1)); ## Value is next param in array.
				log="$argv[$i]"; 
			fi 
			echo "[${0##*/}:${LINENO}] $(declare -p log)" >&2 ## repr()
			;;
			-v | --verbose ) ## Accumulator flag param.
			verbose="${verbose}v"
			echo "[${0##*/}] verbose=${verbose@Q}" >&2 ## repr()
			;;
			'-?' | '--help' ) ## Help message param.
			fn_print_usage ## Explain usage.
			exit 0 # Successfully printed help.
			;;
			'--' ) ## Stop handling params if '--' encountered (standard end of params indicator).
			echo "[${0##*/}] stop flag ('--') reached" >&2
			break ## Stop looping over params.
			;;
			?) ## Unhandled param.
			## Unexpected value, die.
			fn_print_invalid_param_msg ## Explain problem.
			fn_print_usage ## Explain usage.
			exit 1 ## Nonzero status means failure.
			;;
		esac; 
	fi;
done

## Allow optionally storing arguments to pass to some subprocess:
extra_args=() # Empty array, representing no arguments given after '--', or no '--' given.
if [[ "$argv[$i]" == '--' && "$i" -le "${#argv[@]}" ]]; then ## Given '-- and not after end of array?
	i=$(($i + 1)) ## Skip '--'
	extra_args=( "${argv[@]:$i:-1}" ) # Args left over after '--'
fi
echo "[${0##*/}] Arguments to pass onwards: count=${#extra_args[@]}; extra_args=(${extra_args[*]@Q});" >&2 ## Print params.

echo "[${0##*/}] Finished handling CLI parameters (at $(date -Is))" >&2
## ==========< Handle CLI Parameters >========== ##


## ==========< Main loop >========== ##
while true; do
	sleep ${sleep_interval?}
	
	## Access a small amount of data to keep disk awake
	offset=$((1 + $RANDOM % 100)) ## Random number below 100

	## https://www.man7.org/linux/man-pages/man1/dd.1.html
	## https://www.gnu.org/software/coreutils/manual/html_node/dd-invocation.html
	## Read 1K data from the disk:
	dd "if=${device?}" "of=/dev/null" "iflag=nocache" "ibs=1K" "iseek=${offset?}" "count=1"
	## Reasons for flags:
	## nocache - Re-read from disk instead of using cache, while not clobbering anything.
done
## ==========< Main loop >========== ##


## =========< Ending message >========== ##
echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
## =========< /Ending message >========== ##
exit
