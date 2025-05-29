#!/usr/bin/env bash
## gitarchive.sh
## ======================================== ##
## USAGE:
## ./$0 REPO_URL...
## ======================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-03-04
## MODIFIED: 2025-05-11
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


## ==========< Functions >========== ##
## Functions share parent scope for variables; 
## 'local' keyword is required to prevent overwriting variables outside the function.

fn_dedupe_string_array(){
	## Dedupe a specified array of strings, outputting the deduped values to a specified array.
	## ---------------------------------------- ##
	## Function USAGE:
	## argv=() ## Allocate dest array in parent scope.
	## fn_dedupe_string_array script_argv argv ## Call function with varnames of two arrays.
	## ---------------------------------------- ##
	## SOURCES:
	## * https://stackoverflow.com/questions/10582763/how-to-return-an-array-in-bash-without-using-globals
	## * https://stackoverflow.com/questions/54797475/how-to-remove-duplicate-elements-in-an-existing-array-in-bash
	## ---------------------------------------- ##
	local -n srcArray="${1?}" ## Name of array variable to read from. (via nameref)
	local -n destArray="${2?}" ## Name of array variable to create. (via nameref)
	echo "[${0##*/}] Deduping array named ${1@Q} to dest named ${2@Q}" >&2
	local x ## Prevent clobbering other scopes.
	while IFS= read -r -d '' x
	do
		destArray+=("${x?}") ## Append element to results.
	# done < <(printf "%s\0" "${srcArray[@]}" | sort -uz)
		## https://unix.stackexchange.com/questions/131217/how-to-remove-duplicate-lines-with-awk-whilst-keeping-all-empty-lines
		## https://stackoverflow.com/questions/1444406/how-to-delete-duplicate-lines-in-a-file-without-sorting-it-in-unix
		## Discard lines not added to array 'seen'
	done < <(printf "%s\0" "${srcArray[@]}" | gawk 'BEGIN { RS="\0"; ORS = "\0"; } !seen[$0]++')
	
}

fn_sleep_between_jobs() {
	## Contain logic to do sleep between jobs.
	## ---------------------------------------- ##
	## If not first item, sleep before running:
	if [[ -z "${timer_pre:-}" ]]; then 
		## Is it first cycle?
		sleep_duration="0" ## Don't sleep before first task.
	elif [[ -z "${SLEEP_FOR_LAST_TASK_DURATION:-}" ]]; then
		## If $SLEEP_FOR_LAST_TASK_DURATION is not set to a number then use duration of previous task as inter-task delay.
		## Sleep however long last task took, plus 10 seconds, max 10 mins:
		sleep_duration=$(( ${timer_post?} - ${timer_pre?} )) ## Calculate duration of previous task.
	else
		## Sleep fixed duration from config var:
		sleep_duration="${interval_between_jobs:-30}"
	fi
	## Restrict sleep time to within boundaries:
	if [[ ${sleep_duration?} -lt ${SLEEP_MINIMUM:-10} ]] then sleep_duration=$SLEEP_MINIMUM; fi
	if [[ ${sleep_duration?} -gt ${SLEEP_MAXIMUM:-10} ]] then sleep_duration=$SLEEP_MAXIMUM; fi
	echo "[${0##*/}] sleeping for ${sleep_duration@Q} secs" >&2
	sleep "${sleep_duration:-30}"
}

pfx() {
	## Message prefix function.
	## USAGE: $ echo "$(pfx) message text goes here"
	## value at index 0 is current scope, we want parent (caller) scope so use index 1:
	printf '[%s:%s] ' ${BASH_SOURCE[1]##*/} ${FUNCNAME[1]:-} ## i.e. '[gitarchive:fn_prep_tempdir] '
	# printf '[%s:%s()] ' ${BASH_SOURCE[1]##*/} ${FUNCNAME[1]:-} ## i.e. '[gitarchive:fn_prep_tempdir()] '
}

func_cleanup_tempdir() {
	## Remove tempdir and its contents.
	# rm --one-file-system --recursive --verbose --force "${tmpdir?}"
	rm --one-file-system --recursive --force "${tmpdir?}"
}

fn_prep_tempdir() {
	## Prepare temporary dir for working in
	## ====< Prep tempdir >===== ##
	echo "[${0##*/}] Preparing tempdir (at $(date -Is))" >&2
	# tmpdir="$(mktemp --directory || exit 1;)" ## Die if error.
	tmpdir="$(mktemp --directory "${0##*/}.pid=$$.$(date +@%s).tmp.XXXXXXXXXX" || exit 1;)" ## Script, date, and process -specific tempdir.
	echo "[${0##*/}] tmpdir=${tmpdir@Q}" >&2
	# echo $"{func_cleanup_tempdir} ;\n $(trap -p EXIT) ;\n"
	# trap $"{func_cleanup_tempdir} ; $(trap -p EXIT)" EXIT # Add signal handler whule preserving any existing handlers.
	## ====< Prep tempdir >===== ##
}

fn_naming_logic() {
	## ====< /Naming and directory logic >===== ##
	## Extract values from CLI params and do naming logic
	echo "[${0##*/}] Generating names and paths (at $(date -Is))" >&2
	timestamp="$(date -u +%Y-%m-%dT%H%M%S%z)"

	## Attempt to extract values from repo URL:
	## Possible URL formats:
	## https://github.com/tmux-plugins/tmux-open.git
	## git@github.com:tmux-plugins/tmux-open.git
	## https://github.com/hack-gpon/hack-gpon.github.io
	## https://github.com/hack-gpon/hack-gpon.github.io.git
	site_name=$(printf '%s\n' "${repo_url?}" | perl -n -e'/(?!http)?s?[:\/]*([\w_\.-]+)\.([\w_\.-]+)\/([\w_\.-]+)\/([\w_\.-]+)/ && print $1')
	user_name=$(printf '%s\n' "${repo_url?}" | perl -n -e'/(?!http)?s?[:\/]*([\w_\.-]+)\.([\w_\.-]+)\/([\w_\.-]+)\/([\w_\.-]+)/ && print $3')
	repo_name=$(printf '%s\n' "${repo_url?}" | perl -n -e'/(?!http)?s?[:\/]*([\w_\.-]+)\.([\w_\.-]+)\/([\w_\.-]+)\/([\w_\.-]+)/ && print $4')
	# reponame_string=$(perl -n -e'/(?!http)?s?[:\/]*(\w+)\.(\w+)\/(\w+)\/(\w+)/ && print $1."\.".$3."\.".$4')
	echo "[${0##*/}] timestamp=${timestamp@Q}" >&2
	echo "[${0##*/}] site_name=${site_name@Q}" >&2
	echo "[${0##*/}] user_name=${user_name@Q}" >&2
	echo "[${0##*/}] repo_name=${repo_name@Q}" >&2

	## Optional name override
	if [[ -n "${custom_name}" ]]; then ## If string contains not empty
		## Custom name was given, use that:
		echo "[${0##*/}] Using manually specified name" >&2
		reponame_string="${custom_name?}.${timestamp?}"
	else
		## Default to autoname:
		echo "[${0##*/}] Generating name from URL" >&2
		job_name="git_repo.${site_name?}.${user_name?}.${repo_name?}.${timestamp?}"
	fi
	echo "[${0##*/}]" "This job is named: ${job_name@Q}" >&2

	## Format values into paths:
	job_dir="${tmpdir?}/${job_name?}"
	archive_file="${output_basedir?}/${job_name?}.tar.gz"
	archive_hash_file="${output_basedir?}/${job_name?}.tar.gz.md5"
	## ====< Naming and directory logic >===== ##
}

fn_git_download() {
	## Download git repo
	## Scope func-local vars:
	local attempt_counter
	local base_delay
	local last_attempt_duration
	local exponential_backoff
	local sleep_time
	local clone_timer_pre
	local clone_timer_post
	local git_exit_status
	## ====< Download >===== ##
	echo "[${0##*/}] Download repo to local disk (at $(date -Is))" >&2
	## Env vars
	## See: https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
	## * https://git-scm.com/docs/git#Documentation/git.txt-codeGITTRACEcode
	## * https://git-scm.com/docs/api-trace2
	# export GIT_CURL_VERBOSE="1" # Similar to 'curl -v'
	export GIT_HTTP_LOW_SPEED_LIMIT="1024" # Bytes per second.
	export GIT_HTTP_LOW_SPEED_TIME="60" # Seconds
	# export GIT_CURL_VERBOSE=1 ## "This is similar to doing curl -v on the command line."
	# export GIT_TRACE=true 
	# export GIT_TRACE="${tmpdir?}/git-clone.trace"
	# GIT_TRACE_SETUP=true 
	local git_params=(
		clone 
		--mirror
		--verbose
		"${repo_url?}" 
		"${job_dir?}" 
	)
	echo "[${0##*/}] git_params=( ${git_params[*]@Q} )" | tee "${tmpdir?}/git-clone.args" >&2
	## Retry download on failure:
	for ((attempt_counter=0; attempt_counter < ${CLONE_MAX_ATTEMPTS:-10}; attempt_counter++)); do
		echo "[${0##*/}] attempt ${attempt_counter@Q} of max ${CLONE_MAX_ATTEMPTS@Q}." >&2
		if [[ ${attempt_counter} -gt 0 ]]; then
			## Logical components as simpler formulae to be added together:
			base_delay=${BASE_RETRY_DELAY_SECONDS:-60}
			last_attempt_duration=$(( ${clone_timer_post?} - ${clone_timer_pre?} ))
			exponential_backoff=$(( (2 ** ${attempt_counter?}) % ${CLONE_MAX_EXPONENTIAL_BACKOFF_SECONDS:-600} ))
			# echo "[${0##*/}] base_delay=${base_delay@Q}; last_attempt_duration=${last_attempt_duration@Q}; exponential_backoff=${exponential_backoff@Q};" >&2
			## Sum components to produce sleep time:
			sleep_time=$(( ${base_delay?} + ${exponential_backoff?} +  ${last_attempt_duration?} ))
			echo "[${0##*/}] Pausing before retry for sleep_time=${sleep_time@Q}" >&2
			sleep ${sleep_time?}
		fi
		clone_timer_pre=${SECONDS}
		git "${git_params[@]}"
		git_exit_status=$?
		echo "[${0##*/}] git_exit_status=${git_exit_status@Q}" >&2
		clone_timer_post=${SECONDS}
		## ====< Check exit status >===== ##
		case ${git_exit_status?} in
			0 ) ## "0 - Success" -> Finished.
				echo "[${0##*/}]" "0 - Success" "(break from loop)" >&2
				break ## Done with loop.
			;;
			* ) ## Any other exit status -> die for safety.
				echo "[${0##*/}]" "Unhandled exit status" "exit code was ${git_exit_status@Q}" "(Retry)" >&2
				if [[ ${attempt_counter?} -ge ${CLONE_MAX_ATTEMPTS?} ]]; then
					echo "[${0##*/}] Maximum attempts reached, aborting. ( attempt_counter=${attempt_counter@Q}; CLONE_MAX_ATTEMPTS=${CLONE_MAX_ATTEMPTS@Q}; repo_url=${repo_url?};" >&2
					exit 1 ## Give up and exit script.
				else
					continue ## Retry download.
				fi
			;;
		esac
		## ====< /Check exit status >===== ##
	done
	## ====< /Download >===== ##
}

fn_stash_info() {
	## ====< Stash info >===== ##
	## Record info about the job being done:
	echo "[${0##*/}] Stashing job info (at $(date -Is))" >&2
	local info_file_lines=(
		"## info.txt"
		"## Informational values about repo archive."
		"unixtime=$(date +@%s)"
		"iso_8601_time=$(date -Is)"
		"timestamp=${timestamp@Q}"
		"repo_url=${repo_url@Q}"
		"job_name=${job_name@Q}"
		# "git_version=$(git --version | head --lines 1)"
		# "tar_version=$(tar --version | head --lines 1)"
		# "perl_version=$(perl -v | head --lines 1)"
		# "BASH_VERSION=${BASH_VERSION@Q}"
	)
	printf '%s\n' "${info_file_lines[@]}" > "${tmpdir?}/info.txt"
	## Stash script used to make archive:
	cp "$0" "${tmpdir?}/${0##*/}"
	## ====< Stash info >===== ##
}

fn_bundle_results() {
	## Bundle results into single compressed tarball and hash
	## ====< Bundle >===== ##
	echo "[${0##*/}] Bundle repo to archive file (at $(date -Is))" >&2
	## Bundle repo
	local tar_params=(
		## ## https://www.man7.org/linux/man-pages/man1/tar.1.html
		## $ tar
		--create
		## Format params:
		--gzip
		--format=posix
		--sparse ##  Handle sparse files efficiently
		## Omit info about host machine:
		--owner=:1000 ## Generic owner value (Default linux first created user).
		--numeric-owner
		--no-acls
		--no-selinux
		--no-xattrs
		## Informational params:
		--totals ## Print total size and rate after operation completes.
		--checkpoint="10000" # Tar gives an update on TTY every this many files.
		'--checkpoint-action=ttyout=%{%Y-%m-%d %H:%M:%S}t: %ds, %{read,wrote}T checkpoint #%u %*\r'
		## File selection options:
		--recursion
		--one-file-system
		## Archive file:
		--file "${archive_file?}"
		## Source files:
		--directory="${tmpdir?}" ## Affects arguments after. 
		'.' # Wildcard to match all contents of dir.
		
	)
	echo "[${0##*/}] tar_params=( ${tar_params[@]@Q} )" >&2
	tar "${tar_params[@]}"
	md5sum --tag "${archive_file?}" | tee -a "${archive_hash_file?}" >&2
	## ====< /Bundle >===== ##
}

fn_gitarchive() {
	## $1 - REPO_URL
	## Name params for readability
	repo_url=${1?}
	custom_name="${2:-}" # Empty string if unset
	local stopwatch_begin=$SECONDS ## Time function duration (Stopwatch).
	echo "[${0##*/}:fn_gitarchive] repo_url=${repo_url@Q} at $(date -Is)" >&2
	## Prepare temporary dir for working in
	fn_prep_tempdir
	## Naming and directory logic
	fn_naming_logic
	## Record info about the job being done
	fn_stash_info
	## Download git repo
	fn_git_download
	## Bundle results into single compressed tarball and hash
	fn_bundle_results
	## Remove tempdir and its contents.
	func_cleanup_tempdir 
	## Record successful job:
	echo "timestamp_finished=$(date -u +%Y-%m-%dT%H%M%S%z); repo_url=${repo_url@Q}; archive_file=${archive_file@Q};" | tee -a "${GITARCHIVE_HISTORY_COMPLETED_FILE:-/dev/null}" > /dev/null
	local stopwatch=$((${SECONDS?} - ${stopwatch_begin?})) ## Time function duration (Stopwatch).
	echo "[${0##*/}:fn_gitarchive] Finished saving repo (at $(date -Is)). Function took $((${stopwatch?} / 86400))d $((${stopwatch?} / 3600))h $(((${stopwatch?} / 60) % 60))m $((${stopwatch?} % 60))s (${stopwatch?} seconds total) to complete" >&2
}
## ==========< /Functions >========== ##


## ==========< Welcome message >========== ##
echo "[${0##*/}] Starting (at $(date -Is))" >&2
echo "[${0##*/}] Running as: $(whoami)@$(hostname):$(pwd)" >&2
echo "[${0##*/}] Effective permissions: $(id)" >&2
orig_argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#orig_argv[@]}; argv=(${orig_argv[@]@Q});" >&2
## ==========< /Welcome message >========== ##


## ==========< Config >========== ##
## Persistant user config for this script:
GITARCHIVE_HISTORY_ARGS_FILE="${HOME?}/.gitarchive.sh.history.invokations" ## Log of invocations.
GITARCHIVE_HISTORY_COMPLETED_FILE="${HOME?}/.gitarchive.sh.history.completed" ## Log of completed downloades.
output_basedir="$HOME/git-archiving"
interval_between_jobs=120
SLEEP_FOR_LAST_TASK_DURATION=0 # If not null then use duration of previous task as inter-task delay.
SLEEP_MINIMUM=10 ## Minimum delay between jobs (Time in seconds).
SLEEP_MAXIMUM=600 ## Maximum delay between jobs (Time in seconds).
BASE_RETRY_DELAY_SECONDS=120
CLONE_MAX_ATTEMPTS=10
CLONE_MAX_EXPONENTIAL_BACKOFF_SECONDS=600
## ==========< /Config >========== ##


## ==========< Main loop >========== ##
script_argv=("$@") # Argument values.
script_argc=$#
## Recoord script params:
echo "timestamp=$(date -u +%Y-%m-%dT%H%M%S%z); script_argv=(${script_argv[*]@Q});" | tee -a "${GITARCHIVE_HISTORY_ARGS_FILE:-/dev/null}" > /dev/null
## Dedupe script params:
echo "[${0##*/}] Deduping script params" >&2
argv=() ## Populated by dedupe func.
fn_dedupe_string_array script_argv argv
## Iterate over params:
argc="${#argv[@]}" ## Arugment count.
echo "[${0##*/}] Processing copied arguments: argc=${argc?}; argv=(${argv[*]@Q});" >&2 ## Print params.
for ((argn = 0 ; argn < ${argc?} ; argn++)); do
	arg_value="${argv[$argn]?}" # Current param value.
	fn_sleep_between_jobs
	echo "[${0##*/}] Processing arg: argn=${argn?};" "arg_value=${arg_value@Q};" >&2 ## Print params.
	timer_pre="${SECONDS}"
	fn_gitarchive "${arg_value?}"
	timer_post="${SECONDS}"
done
## ==========< Main loop >========== ##


## =========< Ending message >========== ##
echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
## =========< /Ending message >========== ##
exit
