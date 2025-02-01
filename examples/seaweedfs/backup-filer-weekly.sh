#!/usr/bin/env bash
## backup-filer-weekly.sh
## Backup seaweedfs filer.
## https://www.man7.org/linux/man-pages/man1/date.1.html
weed shell <<< "fs.meta.save -o /var/seaweedfs/backup/$(date +%Y-%m-%d).weed-filer.meta"
