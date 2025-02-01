#!/bin/bash
echo "Show use of JQ for pretty-print:" 
ip -j -p address | jq

echo "Show use of JQ filters:" 
ip -j -p address | jq '.[] | { ifindex: .ifindex, ifname: .ifname, ip_local: .addr_info[] | .local, ip_family: .addr_info[].family  }'
