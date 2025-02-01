#!/usr/bin/env bash
## bashrc-d-dropins.snippet.sh
## Example code snippet copied from a Fedora bashrc file.
## To use, just copypaste block into your ~/.bashrc file.
## ======================================== ##

## ==========< Dropin bashrc modules >========== ##
# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc
## ==========< /Dropin bashrc modules >========== ##
