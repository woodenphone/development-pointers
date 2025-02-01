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
## CREATED: 2023-10-26
## MODIFIED: 2023-10-26
## ==================================== ##
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}]" "Starting" "at $(date -Is)"
echo "#[${0##*/}]" "argv=${*[*]@Q}" # Print shellescaped invocation params.
echo "#[${0##*/}]" "Running as" "${USER}@${HOSTNAME}:${PWD}"
echo "#[${0##*/}]" "id:" "$(id)" # Current security context.


dl_dir="${HOME}/wget-dl/example-download-operation" # Where wget should write files to.


mkdir -vp "${dl_dir?}"
cp -v "${0}" "${dl_dir?}" ## Stash script used to do download.
cd "${dl_dir?}"

wget_cmd=(
	wget 
	--continue ## Permit resuming previous interrupted run.
	## Logging:
	--no-verbose ## Do not produce excessive progress messages.
	--append-output="${dl_dir?}/wget.log"
	## File timestamps
	--timestamping 
	## Throttling
	--limit-rate=500k 
	--wait=1s 
	--random-wait 
	--waitretry=10 
	## Restrict filenames:
	--restrict-file-names='windows,ascii' 
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
	"https://example.com/"
	"https://dummy.fake"
)
echo "${wget_cmd[*]@Q}" | tee "${dl_dir?}/wget_cmd.txt"
echo "#[${0##*/}]" "Starting wget" "at $(date -Is)"
"${wget_cmd[@]}"


echo "#[${0##*/}]" "Finished" "at $(date -Is)"
exit
