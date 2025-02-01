#!/usr/bin/env bash
## gitarchive.sh
## ========================================
## USAGE:
## ./$0 REPO_URL...
## ========================================
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-03-04
## MODIFIED: 2024-11-16
## ========================================


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit	# Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset	# Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} ln${LINENO} ' 
## ==========< /Shell setup >========== ##



## ==========< Functions >========== ##
## Functions share parent scope for variables; 
## 'local' keyword is required to prevent overwriting variables outside the function.

pfx() {
	## Message prefix function.
	## USAGE: $ echo "$(pfx) message text goes here"
	## value at index 0 is current scope, we want parent (caller) scope so use index 1:
	printf '[%s:%s] ' ${BASH_SOURCE[1]##*/} ${FUNCNAME[1]:-} ## i.e. '[gitarchive:fn_prep_tempdir] '
	# printf '[%s:%s()] ' ${BASH_SOURCE[1]##*/} ${FUNCNAME[1]:-} ## i.e. '[gitarchive:fn_prep_tempdir()] '
}

fn_prep_tempdir() {
	## Prepare temporary dir for working in
	## ====< Prep tempdir >===== ##
	echo "[${0##*/}] Preparing tempdir (at $(date -Is))" >&2
	tmpdir="$(mktemp --directory || exit 1;)" ## Die if error.
	echo "[${0##*/}] tmpdir=${tmpdir@Q}" >&2
	func_cleanup_tempdir() {
		## Remove tempdir and its contents.
		rm --one-file-system --recursive --verbose --force "${tmpdir?}"
	}
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
	job_dir="${tmpdir:-$PWD}/${job_name?}"
	archive_file="${output_basedir?}/${job_name?}.tar.gz"
	archive_hash_file="${output_basedir?}/${job_name?}.tar.gz.md5"
	## ====< Naming and directory logic >===== ##
}

fn_git_download() {
	## Download git repo
	## ====< Download >===== ##
	echo "[${0##*/}] Download repo to local disk (at $(date -Is))" >&2
	## Clone repo
	git_params=(
		clone 
		"${repo_url?}" 
		"${job_dir?}" 
		--mirror
	)
	echo "#[${0##*/}] git_params=( ${git_params[@]@Q} )" >&2
	git "${git_params[@]}"
	## ====< /Download >===== ##
}

fn_stash_info() {
	## ====< Stash info >===== ##
	## Record info about the job being done:
	echo "[${0##*/}] Stashing job info (at $(date -Is))" >&2
	info_file_lines=(
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
	cp --verbose "$0" "${tmpdir?}/${0##*/}"
	## ====< Stash info >===== ##
}

fn_bundle_results() {
	## Bundle results into single compressed tarball and hash
	## ====< Bundle >===== ##
	echo "[${0##*/}] Bundle repo to archive file (at $(date -Is))" >&2
	## Bundle repo
	tar_params=(
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
	echo "#[${0##*/}] tar_params=( ${tar_params[@]@Q} )" >&2
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

	local stopwatch=((${stopwatch_begin} - ${SECONDS})) ## Time function duration (Stopwatch).
	echo "[${0##*/}:fn_gitarchive] Finished saving repo (at $(date -Is)). Function took $((${stopwatch?} / 86400))d $((${stopwatch?} / 3600))h $(((${stopwatch?} / 60) % 60))m $((${stopwatch?} % 60))s (${stopwatch?} seconds total) to complete" >&2
}
## ==========< /Functions >========== ##


## ==========< Welcome message >========== ##
echo "[${0##*/}] Starting (at $(date -Is))"
echo "[${0##*/}] Running as: $(whoami)@$(hostname):$(pwd)"
echo "[${0##*/}] Effective permissions: $(id)"
argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#argv[@]}; argv=${argv[@]@Q};"
## ==========< /Welcome message >========== ##


## ==========< Config >========== ##
## Persistant user config for this script:
output_basedir="$HOME/git-archiving"
interval_between_jobs=120
## ==========< /Config >========== ##


## ==========< Main loop >========== ##
argv=("$@") # Argument values.
argc="${#argv[@]}" # Arugment count.
echo "[${0##*/}] Processing copied arguments: argc=${argc?}; argv=${argv[*]@Q};" >&2 ## Print params.
for ((argn = 0 ; argn < ${argc?} ; argn++)); do
	arg_value="${argv[$argn]?}" # Current param value.
	echo "[${0##*/}] Processing arg: argn=${i?};" "arg_value=${arg_value@Q};" >&2 ## Print params.
	( ## Subshell to isolate vars used from each task.
		fn_gitarchive "${arg_value?}"
		sleep "${interval_between_jobs:-30}"
	)
done
## ==========< Main loop >========== ##


## =========< Ending message >========== ##
echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
## =========< /Ending message >========== ##
exit
