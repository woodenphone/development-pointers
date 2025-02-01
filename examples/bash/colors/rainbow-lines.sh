#!/bin/bash
## rainbow-lines.sh
## Colorize STDIN.
## LICENSE: BSD0
## AUTHOR: Ctrl-S, mk:2022-05-20 mod:2022-05-20.
RAINBOW_COLORS=(
	30 # black
	31 # red
	32 # green
	33 # yellow
	34 # blue
	35 # purple
	36 # cyan
	37 # white
)

RAINBOW_COUNTER_MIN=1
RAINBOW_COUNTER_MAX=6
RAINBOW_COUNTER=$RAINBOW_COUNTER_MIN

while read -r LINE;
do
	# terminfo setaf "${COLOR}"
	## red: '\e[0;31m'
	printf '\e[3%um%s\e[0m\n' "${RAINBOW_COUNTER}" "${LINE}"
	# printf '%s\n' "${LINE}"
	let RAINBOW_COUNTER++ ; # Cyclic counter.
	if [[ $RAINBOW_COUNTER > $RAINBOW_COUNTER_MAX ]]; then
		RAINBOW_COUNTER=$RAINBOW_COUNTER_MIN; # Overflow
	fi
done
exit
