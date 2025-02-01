#!/bin/bash
## yt-list-clean.sh
## Deduplicate and then shuffle youtube-dl todo list file.
echo "yt-list-clean.sh: START"

# Path to youtube-dl list file:
list_file="$HOME/youtube-dl.sh"
echo "## list_file=$list_file"

# Manage tempfile
tmp_file="`mktemp`" # Assign tempfile path
echo "## tmp_file=$tmp_file"
trap "rm -f $TMPFILE" EXIT # Erase tempfile on script exit.

rm -f "${list_file}.bak" # Backup list
cp "${list_file}" "${list_file}.bak"

uniq -cd "${list_file}" ## Deduplicate lines

## Randomize order of lines using tempfile
## linux.die.net/man/1/shuf
shuf --random-source=/dev/urandom "${list_file}" > "${tmp_file}"
rm -f "${list_file}"
mv "${tmp_file}" "${list_file}"

rm -f $TMPFILE # Cleanup tempfile explicitly.
echo "yt-list-clean.sh: END"

## Notes
## https://www.man7.org/linux/man-pages/man1/rm.1.html
## https://linux.die.net/man/1/shuf
