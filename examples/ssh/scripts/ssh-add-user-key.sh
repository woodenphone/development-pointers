#!/bin/bash
## ssh-add-user-key.sh
## Run as root

##--<arguments>--##
username=$1
pubkey=$2
## TODO: Validate args
##--</arguments>--##

##--<functions>--##
function appendkey(){
	## Append a SSH pubkey line to authorized_keys
	## (Run as target user)
	username=$1
	pubkey=$2
	## SSH dir exists:
	mkdir -vp "/home/${username}/.ssh"
	## Add key to end of authorized_keys
	echo "${pubkey}" >> /home/${username}/.ssh/authorized_keys
	## TODO: Validate files before write, via tmpfile
}
##--</functions>--##


## Add key to end of authorized_keys
sudo -u "${username}" appendkey "${username}" "${pubkey}"


##--<permissions>--##
## If permissions of ssh dir or files are not correct, ssh attempts will fail.
## SSH dir permissions:
chown -v "${username}" "/home/${username}/.ssh/"
chown -v "${username}" "/home/${username}/.ssh/authorized_keys"
chmod -v "u=rwx,g=,o=" "/home/${username}/.ssh/"
chmod -v "u=rw,g=,o=" "/home/${username}/.ssh/authorized_keys"
##--</permissions>--##

exit 0 # Success
