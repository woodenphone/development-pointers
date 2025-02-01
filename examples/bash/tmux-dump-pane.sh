#!/bin/bash
## tmux-dump-pane.sh
## Save the history of a tmux pane
## USAGE: $0 SESSION [OUTFILE]
## AUTHOR: Ctrl-S 2022-06-06 to 2023-01-15.
## LICENSE: BSD-0
target_pane=$1
outfile=$2

if [[ -z "${target_pane}" ]]; then
	target_pane="" # "If the pane index is omitted, the currently active pane in the specified window is used."
fi

if [[ -z "${outfile}" ]]; then
	outfile="${HOME}/tmux-history.pane=${target_pane}.$(date -u '+%Y-%m-%dT%H%M%S%z=@%s').log"
fi

## Ensure dest dir exists
mkdir -vp $( dirname ${outfile} )

#byobu capture-pane -p -S '-' -E '-' -t "${target_pane}" > "${outfile}"

args=(
	capture-pane 
	-p 
	## ‘-’ to -S is the start of the history and to -E the end of the visible pane.
	-S '-' # Startpoint is earliest line in history.
	-E '-' # Endpoingt is latest line in history.
	-T # ignores trailing positions that do not contain a character.
	-t "${target_pane}" # Specify which pane to capture, e.g. 'mysession:mywindow.1'
)
tmux "${args[@]}" > "${outfile}"

exit
## * https://www.man7.org/linux/man-pages/man1/tmux.1.html
