#!/bin/bash
## filer-tail.sh
## /var/lib/seaweedfs/scripts/filer-tail.sh

weed filer.meta.tail | jq --from-file "$(dirname $0)/filer-tail.jq"
exit
