#!/bin/bash
## reallocate-file-objects.sh
## Replace the underlying objects of files without modifying the file contents or metadata.
## ========================================
## USAGE: # ./$0 
## ========================================
## Principle of operation
##   Given some path P on the SeaweedFS Filer, and some temp path T
##   Copy P to T
##   Verify P and T have identical data and metadata
##   Delete P
##   Copy T to P
##   Verify T and P have identical data and metadata
## ========================================
## Notes:
## * Beware of filesystems with inode limits, because this will create a whole lot of files and folders while it's running.
## * This is a dangerous script to run.
## * Run this script as root.
## ========================================
## LICENSE: BSD0
## AUTHOR: Ctrl-S
## CREATED: 2022-12-15
## MODIFIED: 2022-12-15
## ========================================
echo "[${0##*/}]" "Starting" "$(date -Is)"

original_dir="/weedmnt/filer-root/buckets/somebucket/foo/bar/" ## Absolute path ex: /weedmnt/root/buckets/asagi/img/000/
temp_dir="/media/scratch/weed-tmp" ## Absolute path ex: /media/scratch/weed-tmp

## $1 temp dir (absolute path) ex: /media/scratch/weed-tmp
## $2 original file (absolute path) ex: /weedmnt/root/buckets/asagi/img/000/00/00000001.jpg
reallocate_file() {
	echo "Juggling file: ${2}"
	cp -av "${2}" "${1}" # Clone out of weed.
	rm -v "${2}" # Remove original from weed filer.
	cp -av "${1}/${2}" "${2}" # Clone back into weed.
	rm -v "${1}/${2}" # Remove tempfile.
}

echo "Juggling clildren of: ${original_dir}"

## Using NUL-delimited filepaths, find all files in target and run function against them:
find -H "${original_dir}" -type f -not -newermt "2022-01-01" -print0 | xargs -0 reallocate_file

## Remove leftover temp dirs
find "${temp_dir}" -type d -empty -delete

echo "[${0##*/}]" "Finished" "$(date -Is)"
exit
## ========================================
## ===== < Links and references > =====
## * https://www.man7.org/linux/man-pages/man1/find.1.html
## * https://www.man7.org/linux/man-pages/man1/xargs.1.html
## https://stackoverflow.com/questions/17282148/can-rmdir-be-used-recursively
