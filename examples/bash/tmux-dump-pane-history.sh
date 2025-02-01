#!/usr/bin/bash
## tmux-dump-pane-history.sh
## Dump the history of the current tmux pane into a file.

echo "## ========== ========== ========== ========== ##"
echo "Saving tmux window/pane"
## Info on when dump was made:
echo "Logged in as: $(whoami)@$(hostname) $(pwd)"
echo "ISO time is: $(date -Is)"
echo "uname: $(uname -a)"
echo "uptime: $(uptime)"
hostnamectl
echo "RAM:"
free -g -h -t

## Write address of current pane:
tmux display-message -p 'tmux://#{user}@#{host}/#{session_id}:#{session_name}/#{window_id}:#{window_name}/#{pane_id}:#{pane_name}/'

# tmux display-message -p '#{session_name}:#{window_index}.#{pane_index}'

## Dump pane to file:
tmux capture-pane -p -S '-' -E '-' > "tmux-pane.$(date -u '+%Y-%m-%dT%H-%M-%S%z').log"

exit

## https://www.man7.org/linux/man-pages/man1/tmux.1.html