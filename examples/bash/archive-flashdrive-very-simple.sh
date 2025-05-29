#!/usr/bin/env bash
## archive-flashdrive-very-simple.sh
## Do a simple backup / archive of a flash drive
## ======================================== ##
## USAGE: $ ./$0 -t FSROOT [-n FSNAME] [-o OUTDIR]
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-02-25
## MODIFIED: 2025-02-25
## ======================================== ##


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
# set -o xtrace # Print a trace of simple commands. (Uses $PS4)
## See for special character meanings in prompt strings: https://www.man7.org/linux/man-pages//man1/bash.1.html#PROMPTING
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
PS4='+ ${BASH_SOURCE[0]}:${LINENO} ' ## Like: 'foo.sh:100 THE_TRACE_LINE'
# PS4='+ [${BASH_SOURCE[0]}|${FUNCNAME[0]:--}@${BASH_LINENO[0]:--}() ln:${LINENO} \$] ' 
# PS1='\s\W\$'
# PS1="[\u@\h:\l \W]\\$ "
# BASH_XTRACEFD="${PWD}/${BASH_SOURCE[0]}.trace" # If set, FD to write trace to instead of STDERR.
## ==========< /Shell setup >========== ##


## ==========< Job parameters >========== ##
echo "[${0##*/}] Start handling CLI options (at $(date -Is))" >&2
while getopts "t:on" flag; do
	case ${flag} in
	t ) # Target filesystem
		target_filesystem="${OPTARG}"
		echo "-t : target_filesystem=${target_filesystem@Q}" >&2
	;;
	n ) ## Name (Optional)
		filesystem_name="${OPTARG}"
		echo "-t : filesystem_name=${filesystem_name@Q}" >&2
	;;
	o ) # Output dir (Optional)
		output_dir="${OPTARG}"
		echo "-t : output_dir=${output_dir@Q}" >&2
	;;
	? )
		echo "Invalid option: -${OPTARG}." >&2
		exit 1
	;;
	esac
done
echo "[${0##*/}] Finished handling CLI options (at $(date -Is))" >&2
## Required values must be set:
if [[ -z ${target_filesystem+x} ]]; then; "[${0##*/}] Error: target_filesystem not set!" >&2 ; exit 1; fi
## Runtime-generated values:
timestamp="$(date +%Y-%m-%d_%H%M%S%z=@%s)" ## current date and time, dirname-safe string.
fs_dirname_slug="$(basename "${target_filesystem?}" | tr --complement --delete '[:alnum:]@()[]-_.' | head -c 128 )" ## Readable idenifier for filesystem, dirname-safe string.
archive_name="${filesystem_name:-$fs_dirname_slug}.${timestamp?}" ## Readable idenifier for archive, dirname-safe string.
job_dir="${output_dir:-PWD?}/${archive_name?}" ## Dir to put files into
mkdir -v "${job_dir?}" || :
## ==========< /Job parameters >========== ##


## ==========< Archive flash drive filesystem >========== ##
echo "[${0##*/}] Start making tarball (at $(date -Is))" >&2
## Tar target filesystem
tar_params=(
	## https://www.man7.org/linux/man-pages/man1/tar.1.html
	--create
	## Sanity parameters:
	--one-file-system
	## Informational parameters:
	# --verbose ## Verbosely list files processed.
	# --index-file="${job_dir?}/${archive_name?}.index-file" ## File to write filenames to.
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
	## Archive file:
	# --file="${archive_filepath?}"
	--file=- ## Write to STDOUT
	## Specify source(s):
	--directory="$( dirname ${0?} )" ## Affects arguments after.
	"${0?}" ## Include a copy of this script
	--directory="${target_filesystem?}"/.. ## Affects arguments after.
	"$( basename "${target_filesystem?}" )" ## Toss FS root in named subdir
	# '.'
)
echo "[${0##*/}] tar_params=${tar_params[*]@Q};" >&2
builtin echo "tar_params=( ${tar_params[*]@Q} )" > "${job_dir?}/${archive_name?}.tar-params"
## tar and hash simultaneously via pipeline and tee to fd subshell '>()'i.e.  'someprog | tee >(ms5sum > foo.md5) | gzip > foo.gzip'
## Run as root to avoid errors for special case permission files (e.g. shadow)
sudo time tar "${tar_params[@]}" \
	| tee >( md5sum > "${job_dir?}/${archive_name?}.tar.md5" ) \
	| gzip \
	| tee >( md5sum > "${job_dir?}/${archive_name?}.tar.gz.md5" ) \
	> "${job_dir?}/${archive_name?}.tar.gz"
echo "[${0##*/}] Done making tarball (at $(date -Is))" >&2
## ==========< Archive flash drive filesystem >========== ##


echo "[${0##*/}] Finished (at $(date -Is)). Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
exit
