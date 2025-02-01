#!/bin/bash
## my-ip.sh
## Display brief info about your outgoing internet connection's IP address.
## AUTHOR: Ctrl-S
## CREATED: 2022-05-15
echo "#[${0##*/}]" "$(date '+%Y-%m-%dT%H:%M:%S%Z=@%s')"
echo "ifconfig.co:" 
curl "ifconfig.co/json"
echo "" # curl omits newline
