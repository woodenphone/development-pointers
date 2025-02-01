#!/bin/bash
## bkupfile.sh
## Stash away some config file.

bkupfile() {
	echo "##[bkupfile] backing up file:" "${1?}"
	pathslug=$( printf '%s' "${1?}" | sed -E -e 's|[/\s]+|-|g' )
	sudo mkdir -vp /root/backup
	sudo cp -av "${1}" "/root/backup/${pathslug?}-$(date +@%s)"
}

bkupfile "${1?}"
exit

