#!/usr/bin/bash
## make-compressed-disk-image.sh
## Simple script to write a basic disk image to file with compression.
## ========================================
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-03-17
## MODIFIED: 2023-03-17
## TESTED: TODO
## ========================================
# set -v ## Make shell print statements as they are executed for debugging.

echo "#[${0##*/}]" "Starting" "at $(date +%Y-%m-%dT%H%M%S%z=@%s)"
echo "#[${0##*/}]" "Running as: $(whoami)@$(hostname) $(realpath $PWD)"

output_dir="$PWD"
disk_id="ata-Samsung_SSD_860_EVO_1TB_SERIALNUM" ## (Name in /dev/disk/by_id)

device=$(realpath /dev/disk/by-id/${disk_id}) # Dereference symlink to actual device file.

output_filename="${disk_id}.$(date -u +%Y-%m-%dT%H%M%S=@%s).img.gz"

echo "#[${0##*/}]" "Saving image of ${device} to ${output_filename}"
dd if="${device}" conv=sync,noerror bs=64K status=progress | gzip -c > "${output_filename}"

echo "#[${0##*/}]" "Finished" "at $(date +%Y-%m-%dT%H%M%S%z=@%s)"
exit
