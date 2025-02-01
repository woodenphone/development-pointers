#!/usr/bin/env bash
## history.sh
## ~/.bashrc.d/history.sh
## Shell history preferences.
## Executed via ~/.bashrc
## ======================================== ##


## ==========< Shell history >========== ##
## Customize BASH history
## https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-HISTTIMEFORMAT
export HISTCONTROL="" # Retain all commands.
#export HISTFILESIZE=100000 # lines in file.
export HISTSIZE="500" # lines in RAM.
export HISTTIMEFORMAT="%Y-%m-%dT%H-%M-%S%z $ " # line prefix format (format string for strftime)
shopt -s histappend # Append to history file, for multi-session history handling.
## Immediately append commands to history as entered:
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" ## Single shared history between all sessions.
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" ## Keep per-pane runtime history, but immediately update historyfile as commands are run.
## ==========< /Shell history >========== ##

