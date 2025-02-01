#!/bin/bash
## backup-file-minimal.sh
sudo cp -va "${1?}"{,.$(date -u +%Y-%m-%dT%H%M%S%z).backup} # Backup the file
exit
