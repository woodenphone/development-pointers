#!/bin/bash
date; lsblk --paths --output "NAME,MODEL,SERIAL,SIZE" | tee >(head -n1 1>&2) | grep -e'^/dev/' | tee >(t="$(wc -l) drives"; echo $t)

# date; lsblk --paths --output "NAME,MODEL,SERIAL,SIZE" | tee >(head -n1 >/dev/tty) | grep -e'^/dev/' | tee >(t="$(wc -l) drives"; echo $t)
