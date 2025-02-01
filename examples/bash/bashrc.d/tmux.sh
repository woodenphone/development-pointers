#!/usr/bin/env bash
## tmux.sh
## ~/.bashrc.d/tmux.sh
## tmux related env setup / config.
## Executed via ~/.bashrc
## ======================================== ##


## ==========< Script: dump-tmux-session.sh >========== ##
## Customize behavior of script 'dump-tmux-session.sh'
##
## Set env var to override default output dir from '$PWD' :
export TMUX_HISTORY_DUMP_DIR="${HOME?}/tmux_history_dumps"
mkdir "${TMUX_HISTORY_DUMP_DIR?}" # Create dir if absent.
## ==========< /Script: dump-tmux-session.sh >========== ##
