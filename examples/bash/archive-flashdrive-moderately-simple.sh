#!/usr/bin/env bash
## archive-flashdrive-moderately-simple.sh
## Do a simple backup / archive of a flash drive
## ======================================== ##
## USAGE: $ ./$0
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-02-25
## MODIFIED: 2025-02-25
## ======================================== ##
script_argv=("$@") # Stash script's original CLI params.

## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit	# Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset	# Exposes unset variables
## Shell special vars:
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read.
set -o xtrace # Print a trace of simple commands. (Uses $PS4)
## See for special character meanings in prompt strings: https://www.man7.org/linux/man-pages//man1/bash.1.html#PROMPTING
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
PS4='+ ${BASH_SOURCE[0]}:${LINENO} ' ## Like: 'foo.sh:100 THE_TRACE_LINE'
PS4='+ [${BASH_SOURCE[0]}|${FUNCNAME[0]:--}@${BASH_LINENO[0]:--}() ln:${LINENO} \$] ' 
# PS1='\s\W\$'
# PS1="[\u@\h:\l \W]\\$ "
# BASH_XTRACEFD="${PWD}/${BASH_SOURCE[0]}.trace" # If set, FD to write trace to instead of STDERR.
## ==========< /Shell setup >========== ##


## ==========< Functions >========== ##
echo() {
	## Override echo to log output
	## echo given params, if verbose set to >= 1
	if [[ -n "${verbose?}" && "${#verbose}" -ge 1 ]]; then
		builtin echo $@ | tee -a "${log:-/dev/null}"
	fi
}
usage() {
	## Print help message for this script to STDERR.
	echo_v1 "[${0##*/}] print_usage()"
	printf '%s\n' "USAGE:" >&2
	local msg_lines=( ## Indented section.
		"[-l|--log | --logfile] - Path to write log to"
		"[-v|--verbose] - Enable verbose output."
		"[-d|--device] DEVICE - device file to use."
		"[-i|--input] - input file to use."
		"[-o|--output] output file to use."
		"[-?|--help] - Display this help text."
		"[--] - Signals any further parameters are to be passed onwards."
		"" # Seperator.
	)
	printf '\t%s\n' "${msg_lines[@]}" >&2
}
f_fs_slugify() {
	## Convert a string to a slug for prepending to tarball paths
	## Allowed chars: a-zA-Z0-9_-.
	## Restrict length to 128 bytes maximum.
	printf '%s\n' $(basename "${1?}") | tr --complement --delete '[:alnum:]-_.' | head -c 128
}
f_slugify_arg(){
    ## Sanitize $1 into a slug suitable for crossplatform filenames.
    ## e.g. $ safe_string="$( f_slugify "my-unsafe-string )"
    ## Remove any character not listed. i.e. [a-zA-Z0-9-_.]
    printf '%s\n' "${1?}" | tr --complement --delete '[:alnum:]-_.'
}
f_print_ls() {
	## Display ls command and its result:
	local pattern=${1?}
	## https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
	## https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
	: $( ## Scope changes to subshell via noop.
		## Configure for globbing
		shopt -s dotglob extglob globstar nullglob
		shopt -u failglob nocaseglob
		local list_of_results=(pattern)
		## Print command:
		# printf '$ ';
		# PS4=''; set -x;
		printf '$ ls -lahQZF (%s)' "${list_of_results[*]@Q}"
		ls -lahQZF "${list_of_results[@]}" ;
	); printf '\n';
}
## ==========< /Functions >========== ##


## ==========< Default values >========== ##
## Default values for variables:
verbose="" # String length represents verbosity level.
log="${0##*/}.$(date +%Y-%m-%d_%H%M%S%z).log.txt" # SCRIPT.sh.log.txt
# log="/dev/null" # Throw away log instead of writing it.
PIDFILE="/tmp/${0##*/}.pid"
## ==========< /Default values >========== ##

#
## ==========< Handle CLI Parameters >========== ##
echo "[${0##*/}]" "Begin handling CLI parameters (at $(date -Is))" >&2

## Exit if no params:
if [[ "$#" == 0 ]]; then 
	echo "[${0##*/}]" "Error: Expected at least one parameter. Exiting." >&2
	print_usage ## Explain usage.
	exit 1 ## Nonzero status means failure.
fi
## Copy script argv / $@ into another array, so function params, shift,  etc. cant interfere.
argv=("$@") # Argument values
argc="${#argv[@]}" # Arugment count
positional_params=() ## Array to fill with positional parameterss.
echo "[${0##*/}]" "Processing copied arguments:" "argc=${argc?};" "argv=${argv[*]@Q};" >&2 ## Print params.
equals_split_pattern='^--?[a-zA-Z0-9\-_]+='
## Loop over array via array index - integer.
for ((i = 0 ; i < ${argc?} ; i++)); do
	arg="${argv[$i]}" # Current param value.
	echo "[${0##*/}]" "Processing arg:"  "i=${i?};" "arg=${arg@Q};" >&2 ## Print params.
	if [[ "${arg?}" =~ ^- && ! "${arg?}" == "--" ]]; then ## If flag type param
		case "${arg?}" in
			-l | --log | --logfile )
			i=$(($i + 1)); log="$argv[$i]" # Value is next param in array.
			echo "[${0##*/}]" "log=${log@Q}" >&2 ## DEVEL; REMOVEME!
			;;
			
			-d | --device )
			i=$(($i + 1)); device="$argv[$i]" # Value is next param in array.
			echo "[${0##*/}]" "device=${device@Q}" >&2 ## DEVEL; REMOVEME!
			;;
			
			-i | --input )
			i=$(($i + 1)); device="$argv[$i]" # Value is next param in array.
			echo "[${0##*/}]" "device=${device@Q}" >&2 ## DEVEL; REMOVEME!
			;;
			-o | --output | -o=* | --output=* )
			if [[ $arg =~ ${equals_split_pattern?} ]]; then ## --key=value param?
				output="${arg#*=}"; ## Discard from start until after first '='.
			else # No equals in param, must be multi-string.
				i=$(($i + 1)); output="$argv[$i]" # Value is next param in array.
			fi
			echo "[${0##*/}]" "output=${output@Q}" >&2 ## DEVEL; REMOVEME!
			;;
			'-?' | '--help' ) ## Help message param.
			print_usage ## Explain usage.
			exit 0 #
			;;
			-v | --verbose ) ## Accumulator flag param.
			verbose="${verbose}v"
			echo "[${0##*/}]" "verbose=${verbose@Q}" >&2 ## DEVEL; REMOVEME!
			;;
			'--' ) ## End-of-args param.
			## Stop handling params if '--' encountered (standard end of params indicator).
			echo "[${0##*/}]" "stop flag ('--') reached" >&2 ## DEVEL; REMOVEME!
			break ## Stop looping over params.
			;;
			?) ## Unhandled param.
			## Unexpected value, die.
			print_invalid_param_msg ## Explain problem.
			print_usage ## Explain usage.
			exit 1 ## Nonzero status means failure.
			;;
		esac; 
	else ## If NOT flag-type param, then it gets to be positional.
		positional_params+=("${arg?}") # Store the positional param.
	fi;
done

## Positional arguments
echo "[${0##*/}]" "Positional parameters:" "count=${#positional_params[@]};" "positional_params=${positional_params[*]@Q};" >&2 ## Print collected positional params.

## Allow optionally storing arguments to pass to some subprocess:
extra_args=() # Empty array, representing no arguments given after '--', or no '--' given.
if [[ "$argv[$i]" == '--' && "$i" -le "${#argv[@]}" ]]; then ## Given '-- and not after end of array?
	i=$(($i + 1)) ## Skip '--'
	extra_args=( "${argv[@]:$i:-1}" ) # Args left over after '--'
fi
echo "[${0##*/}]" "Arguments to pass onwards:" "count=${#extra_args[@]};" "extra_args=${extra_args[*]@Q};" >&2 ## Print params.

echo "[${0##*/}]" "Finished handling CLI parameters (at $(date -Is))" >&2
## ==========< Handle CLI Parameters >========== ##
#


## ==========< Archive flash drive filesystem >========== ##
## Dummy declarations to be replaced with argument handling:
target_filesystem="/media/some-flash-drive" ## Path to root of target filesystem.
timestamp="$(date +%Y-%m-%d_%H%M%S%z=@%s)" ## current date and time, dirname-safe string.
filsystem_name_slug="$(f_fs_slugify "${target_filesystem?}" )" ## Readable idenifier for filesystem, dirname-safe string.
archive_name="${filsystem_name_slug?}.${timestamp?}" ## Readable idenifier for archive, dirname-safe string.
job_dir="${PWD?}/${archive_name?}" ## Dir to put files into

echo "[${0##*/}] Start making tarball (at $(date -Is))" >&2
## Tar target filesystem
tar_params=(
	## https://www.man7.org/linux/man-pages/man1/tar.1.html
	--create
	## Sanity parameters:
	--one-file-system
	## Informational parameters:
	--verbose ## Verbosely list files processed.
	--index-file="${job_dir?}/${archive_name?}.index-file" ## File to write filenames to.
	--totals ## Print total size and rate after operation completes.
	## --checkpoint-action(s) occur every --checkpoint=(NUM) files.
	--checkpoint="10000" # Tar gives an update on TTY every this many files.
	'--checkpoint-action=ttyout=%{%Y-%m-%d %H:%M:%S}t: %ds, %{read,wrote}T checkpoint #%u %*\r'
	## Handling of archive format and file metadata:
	--xattrs
	--acls
	--selinux
	--format=posix # Most flexable format and implied by --xattrs.
	--numeric-owner
	## Transform filepaths: (Behaves like sed's 's' command )
	## See:https://www.gnu.org/software/tar/manual/html_section/transform.html
	## See: https://www.gnu.org/software/sed/manual/
	--transform "s|^${target_filesystem?}|fsroot/|" ## Prepend 'fsroot/' to items in target filesystem.
	--transform="s|^${0?}\$|meta/${0##*/}|" ## Transform this script's path to '/meta/scriptname.sh'
	## Archive file:
	# --file="${archive_filepath?}"
	--file=- ## Write to STDOUT
	## Specify source(s):
	"${0?}" ## Include a copy of this script
	"${target_filesystem?}"
	# --directory="${target_filesystem?}" ## Affects arguments after.
	# '.'
)
echo "[${0##*/}] tar_params=${tar_params[*]@Q};" >&2
builtin echo "tar_params=( ${tar_params[*]@Q} )" > "${job_dir?}/${archive_name?}.tar-params"
## tar and hash simultaneously via pipeline and tee to fd subshell '>()'i.e.  'someprog | tee >(ms5sum > foo.md5) | gzip > foo.gzip'
## Run as root to avoid errors for special case permission files (e.g. shadow)
sudo time tar "${tar_params[@]}" \
	| tee >( md5sum > "${job_dir?}/${archive_name?}.tar.md5" ) \
	| tee >( sha256sum > "${job_dir?}/${archive_name?}.tar.sha256" ) \
	| gzip \
	| tee >( md5sum > "${job_dir?}/${archive_name?}.tar.gz.md5" ) \
	| tee >( sha256sum > "${job_dir?}/${archive_name?}.tar.gz.sha256" ) \
	> "${job_dir?}/${archive_name?}.tar.gz"
echo "[${0##*/}] Done making tarball (at $(date -Is))" >&2
## Display ls command and its result:
# : $(
# 	## https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# 	## https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
# 	shopt -s dotglob extglob globstar nullglob
# 	shopt -u failglob nocaseglob
# 	result_files=("${job_dir?}/${archive_name?}".*)
# 	printf '$ ';
# 	PS4=''; set -x;
# 	ls -lahQZF "${result_files[@]}" ;
# ); printf '\n'; # noop subshell to print command.
f_print_ls "${job_dir?}/${archive_name?}*"
## ==========< Archive flash drive filesystem >========== ##


echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
exit
