#!/usr/bin/bash
## decode-tape-log-page.sh
## ! UNFINISHED !
## ==================================== ##
## SEE ALSO:
## * https://man.archlinux.org/man/extra/sg3_utils/sg_logs.8.en
## * https://github.com/jpmens/jo
## * https://jpmens.net/2016/03/05/a-shell-command-to-create-json-jo/
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-10-29
## MODIFIED: 2023-10-30
## ==================================== ##
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}]" "Starting" "at $(date -Is)"
echo "#[${0##*/}]" "argv=${*[*]@Q}" # Print shellescaped invocation params.
echo "#[${0##*/}]" "Running as" "${USER}@${HOSTNAME}:${PWD}"
echo "#[${0##*/}]" "id:" "$(id)" # Current security context.


## =========< Defaults >========== ##
## (Overridden by CLI params)
tape_device="/dev/nst0"
volume_stats_file="volume_log_page.page" # log page data tempfile
output_json_file="volume_info.json" # log page data tempfile
## =========< /Defaults >========== ##


## =========< Parse CLI params >========== ##
## Read script CLI parameters and assign vars based on them.
echo "#[${0##*/}]" "Parsing params"  "at $(date -Is)"
echo "#[${0##*/}]" "argv=${*[*]@Q}" ## Print params.
## Values from args:
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
	--volume_stats_file )
	shift; volume_stats_file=$1
	;;
	-d | --device )
	shift; tape_device=$1
	;;
	-o | --output )
	shift; tape_device=$1
	;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi
## =========< /Parse CLI params >========== ##


## Fetch log page:
## --page="vs,0" = Volume Statistics page zero - contains serial numbers, sizes, etc. (may be empty values if no media loaded).
sg_logs --page vs,0 "${tape_device?}" > "${volume_stats_file?}"

## =========< Parse log page >========== ##
## Parse out relevant values:
json_result_values=(
	"timestamp=$(date -%@s)" ## Seconds since epoch.
	"type=tape" ## As opposed to a drive
	"device=${tape_device}"
	"barcode=$(gawk "/^Volume barcode:()$/ print $1" "${volume_stats_file?}")" # UNTESTED
	"serialnum=$(gawk "/^Volume serial number:()$/ print $1" "${volume_stats_file?}")" # UNTESTED
	"total_native_capacity=$(gawk "/^Total native capacity [MB]:()$/ print $1" "${volume_stats_file?}")" # UNTESTED
)
jo "${json_result_values[@]}" | tee "${output_json_file?}"
## * https://jpmens.net/2016/03/05/a-shell-command-to-create-json-jo/
## =========< /Parse log page >========== ##


echo "#[${0##*/}]" "Finished" "at $(date -Is)"
exit
