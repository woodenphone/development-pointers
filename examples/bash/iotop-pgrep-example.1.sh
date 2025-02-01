#!/bin/bash
## iotop-pgrep-example.1.sh
sudo iotop --pid=$(pgrep -f '-d,' 'weed.+mount.+root')
exit

## pgrep uses extended regex patterns
## pgrep -f is used to match against the full command line instead of just the executables name.
## iotop uses comma-delimited PIDs while pgrep normally uses newlines as the delimter, so pgrep '-d,' is used to set the delimiter explicitly to comma.
## iotop needs superuser privs to function
