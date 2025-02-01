#!/usr/bin/env bash
## dedupe_array-002.sh
## Functions to dedupe an array.
## ======================================== ##
## Reference:
## * https://www.man7.org/linux/man-pages/man1/grep.1.html
## * https://www.man7.org/linux/man-pages/man1/sort.1.html
## * https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-read
## ======================================== ##
## Based on:
## Source: https://stackoverflow.com/questions/54797475/how-to-remove-duplicate-elements-in-an-existing-array-in-bash
## RETRIEVED: 2025-01-18
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-01-18
## MODIFIED: 2025-01-19
## ! WIP !
## ======================================== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Shell special vars:
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
## ==========< /Shell setup >========== ##




fn_dedupe_array_long() { ## UNTESTED
	## Take the values in input array variable; dedupe items in array; store results in new array variable.
	## Should be fine to specify same input and output variable name, as temp copy is used to dedupe.
	## Does not preserve order due to use of 'sort'.
	## ======================================== ##
	local source_array_name="${1?}" ## Variable name of array to read from.
	local result_array_name="${2?}" ## Variable name to create new deduped array in.
	## ===== Validate input ===== ##
	local regex_varname='^[a-zA-Z_][a-Z0-9_]*$' ## Match any valid bash 'name' AKA 'identifier'.
	if ( typeset -p "${source_array_name?}" | grep '^declare -a [a-zA-Z_][a-Z0-9_]*=(.*)$' >&2 ); then
		## Typeset used above to identify variable type, below to print exact contents.
		printf '%s\n' "[${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}] ERROR: Not an array variable: source_array_name${source_array_name} contains:" "$( typeset -p "${source_array_name?}" || /bin/true )" >&2
		exit 1 ## Invalid input variable type.
	elif [[ ! ${result_array_name?} =~ ${regex_varname} ]]; then
		printf '%s\n' "[${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}] ERROR: Invalid identifier: result_array_name=${result_array_name@Q}:" >&2
		exit 1 ## Invalid destination variable name.
	fi
	## ===== /Validate input ===== ##
	## ===== Dedupe array ===== ##
	local newArr=()
	local x
	while IFS= read -r -d '' x
	do
		newArr+=("$x")
	done < <(printf "%s\0" "${${source_array_name}[@]}" | sort --unique --zero-terminated)
	## ===== /Dedupe array ===== ##
	
	## Pretty info message: ( difference="$(( ${big} - ${small} ))" )
	printf '%s Removed %s duplicate array entries\n' "[${BASH_SOURCE[0]}:${FUNCNAME[0]}:${LINENO}]" $(( ${#source_array_name} - ${#newArr} )) >&2

	## Put the resultant array in the specified variable name:
	local i
	for ((i=0; i<${#values[@]}; ++i)) ; do
		read "$result_array_name[$i]" <<< "${values[i]}"
	done
}

fn_dedupe_array_short() { ## UNTESTED
	## Take the values in input array variable; dedupe items in array; store results in new array variable.
	## Should be fine to specify same input and output variable name, as temp copy is used to dedupe.
	## Does not preserve order due to use of 'sort'.
	## ======================================== ##
	local source_array_name="${1?}" ## Variable name of array to read from.
	local result_array_name="${2?}" ## Variable name to create new deduped array in.
	## ===== Dedupe array ===== ##
	eval "${result_array_name?}=()"
	local x
	while IFS= read -r -d '' x
	do
		eval "${result_array_name?}+=(\"$x\")" #
	done < <(printf "%s\0" "${${source_array_name}[@]}" | sort --unique --zero-terminated)
	eval "${result_array_name?}+=(\"$x\")"
	## ===== /Dedupe array ===== ##

}

fn_dedupe_array_inplace() { ## UNTESTED
	## Take the values in input array variable; dedupe items in array; store results in new array variable.
	## Should be fine to specify same input and output variable name, as temp copy is used to dedupe.
	## Does not preserve order due to use of 'sort'.
	## ======================================== ##
	local target_array="${1?}" ## Target array to dedupe.
	## ===== Dedupe array ===== ##
	local temp_array=( ${source_array_name[]} )
	local current_value
	while IFS= read -r -d '' current_value
	do
		eval "${result_array_name?}"+=("$current_value") #
	done < <(printf "%s\0" "${${source_array_name}[@]}" | sort --unique --zero-terminated)
	## ===== /Dedupe array ===== ##

}

fn_dedupe_array_stdout() { ## UNTESTED
	## Take the values in input array variable; dedupe items in array; store results in new array variable.
	## Should be fine to specify same input and output variable name, as temp copy is used to dedupe.
	## Does not preserve order due to use of 'sort'.
	## ======================================== ##
	local source_array_name="${1?}" ## Variable name of array to read from.
	local result_array_name="${2?}" ## Variable name to create new deduped array in.
	## ===== Dedupe array ===== ##
	printf "%s\0" "${${source_array_name}[@]}" | sort --unique --zero-terminated
	## ===== /Dedupe array ===== ##

}


fn_generate_random_words(){
	## Emit some number of random words.
	local total_strings="${1:-16}" ## First argument or default to 16
	local delimiter="${2:-\n}" ## Second argument or default to newline.
	local result=
	local results=()
	local i
	for i in {1..${total_strings?}} ; do
		result= # Clear value.
		if [[ $(( ${1?} % 4 )) -eq 0 ]]; then
			## Duplicate a previous entry in array
			result="${expressions[ $RANDOM % ${#results[@]} ]}"
			results+="${result?}"
		else 
			## Append a random word:
			result="$(shuf -n 1 /usr/share/dict/words)" ## Easy to understand.
			# result="$(sh -c 'help' | tr --complement --squeeze-repeats '[:alnum:]' '\n' | sort --unique | grep '.\{4,\}' | shuf -n 1 )" ## Portable.
			results+="${result?}"
		fi 
	done
	## Output results to caller:
	printf "%s${delimiter?}" "${results[@]}" >&1
}


## ==========< Demo and test >========== ##
if [[ $# -eq 0 ]]; then
	echo "[${0##*/}] No argv, generating own demo array contents" >&2
	demo_source=( $(fn_generate_random_words 16 "\n") )
else
	demo_source=( "$@" )
fi
typeset -p demo_source	 >&2


echo "[${0##*/}] Deduping arguments..." >&2
time fn_dedupe_array demo_source demo_results

typeset -p demo_results	 >&2
## ==========< /Demo and test >========== ##


echo "[${0##*/}] Finished. Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete (at $(date -Is))" >&2
exit
