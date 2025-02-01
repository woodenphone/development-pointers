#!/usr/bin/bash
## test-drive-with-badblocks.sh
## Run badblocks against given device
## ==================================== ##
## USAGE:
##   $ ./$0 DISK_DEVICE
## e.g. badblocksrunner.sh /dev/sdxx
## ==================================== ##
## LICENSE: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2024-03-03
## MODIFIED: 2024-03-03
## ==================================== ##
# set -x ## Print statements as they are interpreted.
echo "#[${0##*/}]" "Starting" "$(date -Is)"


## ==========< Accept and validate params >========== ##
echo "#[${0##*/}]" "Now validating parameters"
echo "#[${0##*/}]" "CLI params are equivalent to" "${@@A}"

## -----< Handle param: $1 (DISK_DEVICE) >----- ## 
## Abort if parameter absent or zero length.
if [[ ! -n ${1}  ]]; then # -n = true if string of nonzero length
  echo "#[${0##*/}]" "Error: Not given a device path:" "${disk_device@Q}"
  exit 1
fi

## Resolve potential symlink to absolute real path.
given_disk_path=${1?}
disk_device="$( realpath ${given_disk_path?} )"

## Abort if not path to some /dev/sdX disk device file.
pattern_is_disk_device="^/dev/sd" 
if [[ ! "${disk_device?}" =~ ${pattern_is_disk_device?} ]]; then
  echo "#[${0##*/}]" "Error: Does not resolve to some /dev/sd* :" "${disk_device@Q}"
  exit 1
fi

## Abort if not block special file - i.e. a disk.
if [[ ! -b "${disk_device?}" ]]; then
  echo "#[${0##*/}]" "Error: Does not look like a disk device:" "${disk_device@Q}"
  exit 1
fi
## -----< /Handle param: $1 (DISK_DEVICE) >----- ##
echo "#[${0##*/}]" "Finished validating parameters"
## ==========< /Accept and validate params >========== ##


## ==========< Make name for run >========== ##
timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
model="$(lsblk --noheadings --ascii --output 'MODEL' "${disk_device?}" )"
serial_num="$(lsblk --noheadings --ascii --output 'SERIAL' "${disk_device?}" )"
run_name="${model}_${serial_num}_${timestamp}" # Unique name describing this run.
output_dir="${run_name?}" # Dir to put output files
mkdir "${output_dir?}"
output_file_prefix="${output_dir?}/${run_name?}" # First part of all output files
log="${output_file_prefix?}.log"
## ==========< /Make name for run >========== ##


## ==========< Record disk info >========== ##
echo "#[${0##*/}]" "Recording disk info" "at $(date -Is)" | tee -a "${log?}"
lsblk --json --output-all "${disk_device?}"  > "${output_file_prefix?}.lsblk.json"
sudo smartctl --xall "${disk_device?}" > "${output_file_prefix?}.smartctl--xall.txt"
sudo smartctl --json=n --xall "${disk_device?}" > "${output_file_prefix?}.smartctl--xall.json"
## ==========< /Record disk info >========== ##


## ==========< Run badblocks >========== ##

## Prep command so it can be noted to file:
badblocks_params=( 
  ## Workaround for large drives:
  ##   badblocks: Value too large for defined data type invalid end block (4394582016): must be 32-bit 
  ##   Resolved by using larger blocksize: -b $((16*1024*1024))
  -b 16777216 # block_size
  # -c 256 # number of blocks tested at a time; default is 64.
  -o "${output_file_prefix?}.badblocks.outputfile"
  -wsv 
  ${disk_device?} 
)
## Note command to file:
builtin printf '"%q" ' "$cmd[@]" | tee -a  "${output_file_prefix?}.badblocks.cmd"

echo "#[${0##*/}]" "Running badblocks with params" "$( builtin printf '"%q" ' "${badblocks_params[@]}" )" | tee -a  "${log?}"

echo "#[${0##*/}]" "10 seconds to abort with ctrl-c"
sleep 10

echo "#[${0##*/}]" "Starting badblocks" "at $(date -Is)" | tee -a "${log?}"
## Run badblocks to test disk:
sudo badblocks "${badblocks_params[@]}" | tee -a "${output_file_prefix?}.badblocks.cmd"

printf '\n' | tee -a "${log?}" ## Ensure trailing newline.
echo "$(date +@%s)" > "${output_file_prefix?}.badblocks-finished"

echo "#[${0##*/}]" "Finished badblocks" "at $(date -Is)" | tee -a "${log?}"
## ==========< /Run badblocks >========== ##


## ==========< Post-run bundling >========== ##
echo "#[${0##*/}]" "Bundling results" "at $(date -Is)"
## Checksums:
md5sum "${output_file_prefix?}."* > "${output_file_prefix?}.files.md5"

## Tarball:
tar_params=(
	--create
	--gzip
	--one-file-system # Don't follow mountpoints.
	--format=posix # Most flexable format and implied by --xattrs.
	## DEST:
	--file="${run_name?}.tar.gz"
	## SOURCE(s):
	"${0}" # Include this script.
	"${output_file_prefix?}."* # Glob all results
)
echo "#[${0##*/}]" "tar_params:" "$( builtin printf '"%q" ' "$tar_params[@]" )" ## Print variable shell-quoted.
tar $tar_params[@]
## ==========< /Post-run bundling >========== ##

echo "#[${0##*/}]" "Finished" "$(date -Is)"
exit
