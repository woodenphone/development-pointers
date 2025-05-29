#!/usr/bin/env bash
## smartctl-decode-return-code.sh
## The example from the smartctl manpage.
## ======================================== ##
## USAGE:
## ./$0 SMARTCTL_PARAMS...
## ======================================== ##
## * https://man.archlinux.org/man/smartctl.8#EXIT_STATUS
## * https://man.archlinux.org/man/smartctl.8.en.raw
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-05-18
## MODIFIED: 2025-05-18
## ======================================== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Shell special vars:
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value; (used for -x / XTRACE). Like: '+++ STATEMENT...'
# PS4='+ $LINENO: ' ## Like: '+++ <CURRENT_LINENO> STATEMENT...'
## ==========< /Shell setup >========== ##


## =========< Functions >========== ##
decode_smartctl_status() {
	## Decode smartctl return code to something more human-readable.
	## Constrain vars used to within function:
	local ret_code bit_messages_array bit_mask bit_num bit_value description
	## Function params:
	ret_code="${1?}" ## Return code from smartctl.
	## Decode based on manpage descriptions:
	echo "[${0##*/} decode_smartctl()] ret_code=${ret_code@Q}" >&2 ## Display return code.
	bit_messages_array=( ## From https://man.archlinux.org/man/smartctl.8.en.raw
		"Bit 0: Command line did not parse."
		"Bit 1: Device open failed, device did not return an IDENTIFY DEVICE structure, or device is in a low-power mode"
		"Bit 2: Some SMART or other ATA command to the disk failed, or there was a checksum error in a SMART data structure "
		"Bit 3: SMART status check returned "DISK FAILING"."
		"Bit 4: We found prefail Attributes <= threshold."
		"Bit 5: SMART status check returned "DISK OK" but we found that some (usage or prefail) Attributes have been <= threshold at some time in the past."
		"Bit 6: The device error log contains records of errors."
		"Bit 7: The device self-test log contains records of errors. [ATA only] Failed self-tests outdated by a newer successful extended self-test are ignored."
	)
	bit_mask="1" ## 1 == 0x01 == b00000001
	for ((bit_num = 0; bit_num < 8; bit_num++)); do
		## Example of desired output: '	0 - Bit 1: Command line did not parse.
		bit_value="$(( ${ret_code?} & ${bit_num?} ))" ## Bitwise AND to compare specific bit.
		bit_mask="$(( ${bit_mask?} << 1 ))" ## Shift value one position towards MSB.
		description="${bit_messages_array[${bit_num?}]}"
		printf '\t%s = %s\n' "${bit_value?}" "${description}" >&2
	done
	return
}
## =========< /Functions >========== ##


echo "[${0##*/}] Invoked by ${USER?} with argv=( ${*[*]@Q} ) (at $(date -Is))" >&2

smartctl "$@" ## Run smartctl with same params this script got.
ret_code=$? ## Capture return code to a variable.
echo "ret_code=${ret_code@Q}" >&2 ## Display return code.

decode_smartctl_status "${ret_code?}" ## Decode smartctl return code.

exit ## Exit script and pass back out most recent return code.
