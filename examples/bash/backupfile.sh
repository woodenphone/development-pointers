#!/usr/bin/env bash
## backupfile.sh
## ==================================== ##
## Functions to quickly stash a backup of file(s).
## i.e. attmpts at a more polished alternative to:
## $ sudo cp "/etc/ssh/sshd_config"{,.t`date -u +%s`.backup} # Backup the file.
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2024-04-14
## MODIFIED: 2024-08-11
## ==================================== ##



backupfile() {
	cp -av "${1?}" "${1?}.$(date +@%s).backup"
}

backupfiles() {
	local args=( "$@" ) # Make actual array to permit array operations.
	echo "backupfiles() args=${args[*]@Q}" >&2
	local timestamp="$(date +@%s)"
	for filepath in "${args[@]}" do
		cp -av "${filepath?}" "${filepath?}.${timestamp?}.backup"
	done
}
