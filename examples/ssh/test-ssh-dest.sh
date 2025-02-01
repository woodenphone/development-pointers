#!/usr/bin/bash
## test-ssh-dest.sh
## Test if some remote host can be connected to
## ==================================== ##
## See also:
##  https://www.man7.org/linux/man-pages/man1/ssh.1.html
##  https://www.man7.org/linux/man-pages/man5/sshd_config.5.html
##  https://man.openbsd.org/ssh_config.5#TOKENS
##  https://www.gnu.org/software/bash/manual/html_node/Invoking-Bash.html
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-11-13
## MODIFIED: 2023-11-13
## ==================================== ##
# set -x ## Print statements as they are interpreted.

## Accept params
dest_addr="${1?}"
dest_name="${2?}"
caller_file="${3?}"

## Test destination
if ping -W 1 "${dest_addr?}"; then 
	exit 0 ## Successs.
fi
echo "#[${0##*/}] (via ${caller_file}): ${dest_name} ${dest_addr} unavailable"
exit 1 ## Failure.
