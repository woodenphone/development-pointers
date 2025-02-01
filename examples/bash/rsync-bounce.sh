#!/bin/bash
## rsync-bounce.sh
## Rsync via ssh using a proxy bounce server.
## AUTHOR: Ctrl-S
## CREATED: 2021-12-16
## MODIFIED: 2021-12-16

echo "#[${0##*/}]" "Start"

rsync_args=( # Complex args as array for readability + comments.
	## Log options:
	--verbose
	--progress
	--human-readable
	--itemize-changes
	## File options:
	--archive
	## Easy resume via partial-dir:
	--partial
	--partial-dir='.rsync-partial'
	--filter='R  .rsync-partial/'
	## Network options:
	--bwlimit="2000" # In KB/sec.
	## https://serverfault.com/questions/379411/ssh-tunnel-rsync-thru-two-proxy-firewalls
	--rsh='ssh -o ProxyCommand="ssh -W %h:%p PROXY_HOST" TARGET_HOST'
	## SRC/DEST:
	"USER@TARGET_HOST:/SRC"
	"/DEST"
	)

echo "#[${0##*/}] \$ rclone ${rsync_args[@]}" ## Print invocation.

rsync "${rsync_args[@]}" ## Run rsync using array of arguments.

echo "#[${0##*/}]" "End"
