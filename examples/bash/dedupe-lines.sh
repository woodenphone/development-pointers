#!/usr/bin/bash
## dedupe-lines.sh
## ========================================
## USAGE: $ ./$0 SOURCE_FILE DEST_FILE
## ========================================
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-04-01
## MODIFIED: 2023-04-01
## TESTED: TODO
## ========================================
# set -x ## Print statements as they are interpreted.

## ==========< Handle CLI parameters >========== ##
# source_path="${1?}"
# dest_path="${2?}"
## ==========< /Handle CLI parameters >========== ##


## ==========< Intermediate tempfiles >========== ##
# tmp_sort="$(mktemp)"
# tmp_uniq="$(mktemp)"
# onexit() {
# 	rm -fv ${tmp_sort} ${tmp_uniq}
# }
# trap onexit EXIT # Erase tempfile on script exit.
## ==========< /Intermediate tempfiles >========== ##


## ==========< Perform dedupe/uniquify >========== ##
# echo "#[${0##*/}] Deduplicate lines" >&2
# sort [option]… [file]…
# sort --output="${tmp_sort}" "${tmp_strip}" # Sort lines from file.
# echo "#[${0##*/}] Lines in tmp_sort: $(wc --lines "${tmp_sort}")" >&2
 # uniq [option]… [input [output]]
# uniq "${tmp_sort}" "${tmp_uniq}" # Remove adjacent duplicates.
# echo "#[${0##*/}] Lines in tmp_uniq: $(wc --lines "${tmp_uniq}")" >&2

sort "${1?}" | uniq > "${2?}"


exit
