#!/bin/bash
## wget-example.sh
## ==================================== ##
## Easymode copy/paste script to run a wget download of some site.
## 
## ==================================== ##
## SEE ALSO:
## * https://www.man7.org/linux/man-pages/man1/wget.1.html
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-11-03
## MODIFIED: 2024-11-01
## ==================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
# set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]} ${FUNCNAME[0]}@${BASH_LINENO[0]}:${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} ${FUNCNAME[0]}@${BASH_LINENO[0]} ln:${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO ln:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} func:${FUNCNAME[0]:-unset}@${BASH_LINENO[0]:-unset} ln:${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
# PS4='+ ${BASH_SOURCE[0]} func:${FUNCNAME[0]:-} ln:${LINENO} '
PS4='+ [${BASH_SOURCE[0]} | ln:${LINENO}] ' 
## ==========< /Shell setup >========== ##

## =========< Functions >========== ##
f_slugify() {
	## Basic slugify function intended for creating path segments.
	## - Coerce to ASCII.
	## - Constrained to [a-zA-Z0-9-_] 
	## - Slug size constrained to 255 bytes.
	## * https://www.man7.org/linux/man-pages/man1/tr.1.html
	## * https://www.man7.org/linux/man-pages/man1/cut.1.html
	for raw_val in "${*[@]}"; do
		printf "%s\n" "${raw_val?}" \
		| iconv -t 'ascii//TRANSLI' \
		| tr --complement --squeeze-repeats '[:alnum:]-_' \
		| cut -c1-255 -
	done
}
fn_print_script_duration(){
	printf '%s' "$((${SECONDS?}/86400))d $((${SECONDS?}/3600))h $(((${SECONDS?}/60)%60))m $((${SECONDS?}%60))s (${SECONDS?} seconds total)"
}
## =========< /Functions >========== ##


## ==========< Start message >========== ##
printf '%s\n' "[${0##*/}] Script starting (at $(date -Is))" >&2
argv=( "$@" ) ## Copy argv AKA $@ to an actual array.
printf '%s\n' "[${0##*/}] argc=${#argv[*]}; argv=(${argv[*]@Q});" >&2
printf '%s\n' "Running as ${USER?}@${HOSTNAME?}:${PWD?}" >&2
printf '%s\n' "Current security context (via \$ id): $(id)" >&2 # Current security context.
## ==========< /Start message >========== ##


## =========< Handle CLI Params >========== ##
## TODO
## =========< /Handle CLI Params >========== ##

## =========< Config >========== ##
max_retries=100 # Die after this many total attempts.
retry_delay_secs=30 # Sleep before retry.
archive_filepath="${job_dir?}/${archive_name?}"
hash_downloaded_files=0 ## 0=true, nonzero=false.
tarball_downloaded_files="0" ## 0=true, nonzero=false.
## =========< /Config >========== ##


## ==========< Prepare for work >========== ##
output_root="${HOME}/wget-dl" ## Dir download jobs are all inside
site_name="$(f_slugify ${1})" ## filename-safe slug of URL
timestamp="$(date +%Y-%m-%d)" ## Timestamp for this run
job_name="${site_name?}.${timestamp?}" ## Name for this specific download job.
job_dir="${output_root?}/${job_name?}" ## Dir script is in.
wget_dl_dir="${job_dir?}/wget-out" # Where wget should write files to.
tar_archive_filepath_pfx="${job_dir?}/${archive_name?}" ## Output filpath for tar.


mkdir -vp "${dl_dir?}" ## Ensure DL dest exists.
cp -v "${0}" "${dl_dir?}" ## Stash script used to do download.
cd "${job_dir?}"
## ==========< /Prepare for work >========== ##


## =========< Scrape via wget >========== ##
echo "[${0##*/}] Start of wget loop block (at $(date -Is))" >&2
for (( i=0; i<${max_retries?}; i++ )); do
	echo "[${0##*/}] loop: i=${i@Q}" >&2
	wget_cmd=( ## Prepare invocation params:
		## * https://www.man7.org/linux/man-pages/man1/wget.1.html
		wget 
		--continue ## Permit resuming previous interrupted run.
		## Logging:
		--no-verbose ## Do not produce excessive progress messages.
		--append-output="${dl_dir?}/wget.$(date '+%Y-%m-%dT%H%M%S%z').log"
		## File timestamps
		--timestamping 
		## Throttling
		--limit-rate=500k 
		--wait=2s 
		--random-wait 
		--waitretry=10 
		## Restrict filenames:
		--restrict-file-names='windows' 
		## Output dir
		--directory-prefix="${dl_dir?}"
		--force-directories ## Always store in directory structure.
		## Cookies:
		# --save-cookies="${dl_dir?}/cookies.txt" 
		# --keep-session-cookies 
		# --load-cookies 
		## Recursion and page requisites/embeds:
		--recursive 
		--level=5
		--page-requisites 
		--no-remove-listing
		--follow-ftp ## Alloow following FTP links from HTML pages.
		## Site compatability:
		--no-check-certificate ## Tolerate bad certificates.
		-e robots=off ## Ignore robots.txt
		-U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" ## Look like a browser
		## URLS:
		"$@"
	)
	echo "[${0##*/}] wget_cmd=${wget_cmd[*]@Q};" >&2
	echo "${wget_cmd[@]@Q}" | tee "${dl_dir?}/wget_cmd.txt" >&2
	echo "#[${0##*/}] Starting wget (at $(date -Is))" >&2
	## Execute prepared invocation:
	time "${wget_cmd[@]}"
	wget_exit_status=$? ## Record exit status for comparison.
	echo "[${0##*/}] wget_exit_status=${wget_exit_status@Q}" >&2 # Report exit status.
	## Decide if retry is appropriate based on exit status:
	case ${wget_exit_status?} in
		## Exit status found in manpage?
		0 ) ## "0 - Success" Finished.
			echo "[${0##*/}] 0 - Success" >&2
			break ## Done with loop.
			;;
		* ) ## Any other exit status: die for safety.
			echo "[${0##*/}] Unhandled exit status, script dies for safety. Modify script to handle this status." >&2
			break
			;;
	esac
	## Delay before retry:
	echo "[${0##*/}] Sleeping for ${retry_delay_secs?} secs (at $(date -Is))" >&2
	sleep ${retry_delay_secs?}
done
## Die if never succeeded.
if [[ ${i?} -ge ${max_retries?} ]]; then 
	echo "[${0##*/}] Error: Max retry limit reached, exiting script (at $(date -Is)) $(fn_print_script_duration)" >&2
	exit 1
fi
echo "[${0##*/}] End of wget loop block (at $(date -Is))" >&2
## =========< /Scrape via wget >========== ##


## =========< Hash files (hashdeep/md5deep) >========== ##
echo "[${0##*/}] Start of hashdeep block (at $(date -Is))" >&2
if [[ ${hash_downloaded_files?} -ne "0" ]]; then 
	echo "#[${0##*/}] Skipping hashlist creation" >&2
else
	hashlist_filepath="${job_dir?}/${archive_name?}.hashdeep"
	echo "#[${0##*/}] Scanning via hashdeep (at $(date -Is))" >&2
	time hashdeep -c "md5,sha1,sha256,tiger,whirlpool" -r "${rsync_dest?}" > "${hashlist_filepath?}"
	## Info on produced hashlist file:
	: $(set -x; ls -lahQZF "${hashlist_filepath}";) # noop subshell to print command.
fi
echo "[${0##*/}] End of hashdeep block (at $(date -Is))" >&2
## =========< /Hash files (hashdeep/md5deep) >========== ##


## =========< create tarball >========== ##
echo "[${0##*/}] Start of tar block (at $(date -Is))" >&2
if [[ ${tarball_downloaded_files?} -ne "0" ]]; then 
	echo "#[${0##*/}] Skipping tarball creation" >&2
else
	## Create gzipped tarball:
	tar_params=(
		## https://www.man7.org/linux/man-pages/man1/tar.1.html
		--create
		--gzip
		## Sanity parameters:
		--one-file-system
		## Informational parameters:
		--verbose ## Verbosely list files processed.
		--index-file="${tar_archive_filepath_pfx?}.tar-file-list" ## File to write filenames to.
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
		"${0?}" ## Include a copy of this script
		--directory="${job_dir?}" ## Affects arguments after.
		'wget-out/'
		'*.sh' # Stashed copy of this script

	)
	echo "[${0##*/}] tar_params=${tar_params[*]@Q};" >&2
	## tar and md5sum simultaneously via pipeline and tee to fd subshell '>()':
	## Run as root to avoid errors for special case permission files (e.g. shadow)
	time tar "${tar_params[@]}" | gzip | tee >( md5sum > "${tar_archive_filepath_pfx?}.tar.gz.md5" ) > "${tar_archive_filepath_pfx?}.tar.gz"

	## Display ls command and its result:
	: $(set -x; ls -lahQZF "${job_dir?}/${archive_name?}.tar.gz" "${job_dir?}/${archive_name?}.tar.gz.md5") # noop subshell to print command.
fi
echo "[${0##*/}] End of tar block(at $(date -Is))" >&2
## =========< /create tarball >========== ##


## Exit message:
echo "[${0##*/}] Script finished (at $(date -Is)), took $((${SECONDS?}/86400))d $((${SECONDS?}/3600))h $(((${SECONDS?}/60) % 60))m $((${SECONDS?}%60))s (${SECONDS?} seconds total) to complete." >&2
exit
