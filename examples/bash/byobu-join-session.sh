#!/bin/bash
## byobu-join-session.sh
## Connect or create byobu session.
## USAGE: $ $0 SESSION_NAME
## By: Ctrl-S, 2022-06-30 - 2022-06-30.
##====================================##
SESSION=$1

## Startup message indicating script run details:
echo "#[${0##*/}]" "Joining session '${SESSION}' on $(hostname)" "$(date +%Y-%m-%dT%H%M%S%z=@%s)" >&2

byobu-tmux new-session -A -s "${SESSION}"
## man TMUX(1) >The -A flag makes new-session behave like attach-session if session-name already exists; in this case, -D behaves like -d to attach-session.

# ## Test if session already exists:
# if byobu-tmux has-session -t "${SESSION}"; then
# 	## If session exists, attach to it:
# 	echo "#[${0##*/}]" "Attaching session '${SESSION}'" >&2
# 	byobu-tmux attach-session -t "${SESSION}"
# else
# 	## If session does not exist, create it:
# 	echo "#[${0##*/}]" "Creating session '${SESSION}'" >&2
# 	byobu-tmux new-session -s "${SESSION}"
# fi
