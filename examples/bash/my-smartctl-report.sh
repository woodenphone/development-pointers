#!/usr/bin/env bash
## my-smartctl-report.sh
## Lazymode quick smartctl report.
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-11-24
## MODIFIED: 2023-11-29
## ==================================== ##
echo "[${0##*/}] Starting (at $(date -Is))"
exit 1







## =========< Functions >========== ##
fn_generate_report_filename(){
	## Create a filename for the report.
	local disk_path="${1?}"
	echo "[${0##*/}:${FUNCNAME[0]}():${LINENO:-}] Creating filename for disk report. disk_path=${disk_path@Q}; (at $(date -Is))" >&2
	## Gather device info into variables.
	read -r dname dmodel dserial dsize <<< $(lsblk --no-heading --output "NAME,MODEL,SERIAL,SIZE" "${target_disk?}" | tr --complement --squeeze-repeats "[:alnum:]-_\t\n " "-")
	timestamp="$(date -u +%Y-%m-%dT%H%M%S%z=@%s)"
	## Join values into filename.
	base_report_name=$( "${dname:}_${dmodel:}_${dserial}_${timestamp?}")
	report_name=$(printf '%s\n' "${base_report_name?}" | tr --squeeze-repeats "_") ## Discard possible extra underscores.
	outfile="smartctl-report. ${dname:} ${dmodel:}${dserial} ${timestamp?}.txt"
	echo "[${0##*/}:${FUNCNAME[0]}():${LINENO:-}] Creating filename for disk report. disk_path=${disk_path@Q}; (at $(date -Is))" >&2
	echo "${outfile?}"
}

fn_validate_is_disk() {
	## Attempt to detect non-disk device paths.
	local disk_path="${1?}"
	echo "[${0##*/}:${FUNCNAME[0]}():${LINENO:-}] Checking if given path looks like a disk device. disk_path=${disk_path@Q}; (at $(date -Is))" >&2
	device_regex='^/dev/[:alnum:]'
	if [[ ${target_disk?} ~= ${device_regex?} ]]; then
		echo "[${0##*/}:${LINENO:-}] Error: Given path does not start with '/dev/'" >&2
		return 1 ## False
	elif [[ -b ${target_disk?} ]]; then ## Is it a block device?
		echo "[${0##*/}:${LINENO:-}] Error: Given path is not a block device file." >&2
		return 1 ## False
	fi

	return 0 ## True
}

fn_create_report() {
	local disk_path="${1?}"
	local foo="${2?}"
	local foo="${3?}"
}

## =========< /Functions >========== ##






## ==========< Handle CLI params >========== ##
argv=( "$@" ) ## Create actual array variable to permit normal array behaviors.
echo "[${0##*/}] argc=${#argv[@]}; argv=( ${argv[@]@Q} );"

## Basic arg checking:
if [[ $# -eq 0 ]]; then
	echo "[${0##*/}:${LINENO:-}] Error: No drive specified"
	exit 1
elif [[ $# -gt 1 ]]; then
	echo "[${0##*/}:${LINENO:-}] Error: Expects only one parameter."
	exit 1
elif [[ $# -eq 1 ]]; then
	echo "[${0##*/}] Targeting disk: $"
fi

given_disk_path="${1?}"
target_disk="$(realpath "$given_disk_path?}" )" ## Unsymlink
# if [[ -h given_disk_path ]]; then
# 	target_disk="$(realpath "$given_disk_path?}" )" ## Unsymlink
# fi

## Verify it's a disk:
device_regex='^/dev/[:alnum:]'
if [[ ${target_disk?} ~= ${device_regex?} ]]; then
	echo "[${0##*/}:${LINENO:-}] Error: Given path does not start with '/dev/'"
	exit 1
elif [[ -b ${target_disk?} ]]; then ## Is it a block device?
	echo "[${0##*/}:${LINENO:-}] Error: Given path is not a block device file."
	exit 1
fi
## ==========< /Handle CLI params >========== ##

## Get values about specified disk. | Alphanumerics only.
read -r dname dmodel dserial dsize <<< $(lsblk --no-heading --output "NAME,MODEL,SERIAL,SIZE" | tr --complement --squeeze-repeats "[:alnum:]-_\t\n " "-")
timestamp="$(date -u +%Y-%m-%dT%H%M%S%z=@%s)"
base_report_name=$( "${dname:}_${dmodel:}_${dserial}_${timestamp?}")
report_name=$(printf '%s\n' "${base_report_name?}" | tr --squeeze-repeats "_") ## Discard possible extra underscores.
outfile="smartctl-report. ${dname:} ${dmodel:}${dserial} ${timestamp?}.txt"
smartctl_cmd=(
	smartctl 
	--xall
	"${1?}"
)


## Run smartctl
"${smartctl_cmd[@]}" > 
