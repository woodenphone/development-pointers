#!/usr/bin/env bash
## yt-list-clean-b.sh
## Cleanup a list file for yt-dlp.
## ======================================== ##
## * Remove comment lines
## * Remove duplicate lines
## * Randomize line order
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-02-21
## MODIFIED:  2025-02-21
## ======================================== ##
echo "[${0##*/}] Starting (at $(date -Is))"
date -Is; 
orig_list_file="${1?}"
output_list_file="${orig_list_file?}.cleaned"


sort --unique "${orig_list_file?}" | grep -v -P -e '^#' | shuf - > "${output_list_file?}"

echo "[${0##*/}] Line counts of files:"
wc -l "${orig_list_file?}" "${output_list_file?}"

time --format='%Uuser %Ssystem %Eelapsed %PCPU (%Xtext+%Ddata %Mmax)k %Iinputs+%Ooutputs (%Fmajor+%Rminor)pagefaults %Wswaps' --  yt-dlp --batch-file "${output_list_file?}"

echo "[${0##*/}] Finished (at $(date -Is))"
exit
