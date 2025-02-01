#!/usr/bin/bash
## Low-dependancy Wake-On-Lan script
## USAGE: $0 MAC_ADDRESS
echo "Sending Wake-On-Lan to: $1"
## Copied from: https://stackoverflow.com/questions/31588035/bash-one-line-command-to-send-wake-on-lan-magic-packet-without-specific-tool
MAC=$1
Broadcast=255.255.255.255
PortNumber=4000
echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | nc -w1 -u -b $Broadcast $PortNumber

exit
