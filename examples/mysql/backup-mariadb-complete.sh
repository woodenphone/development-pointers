#!/bin/bash
## backup-mariadb-complete.sh
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2023-04-04
## MODIFIED: 2023-05-20
## TESTED: TODO:
## ==================================== ##
# set -x ## Print statements as they are interpreted.
echo  "#[${0##*/}]" "Starting" "$(date -Is)"
echo  "#[${0##*/}]" "Running as: $(whoami)@$(hostname) $(pwd)"

dump_name="$(hostname)_mariadb_all-databases_$(date -u +%Y-%m-%d_%H-%M-%S%z=@%s)" ## Shared output filename
echo  "#[${0##*/}]" "dump_name: ${dump_name}"

echo  "#[${0##*/}]" "before mysqldump" "$(date -Is)"
sudo /usr/bin/time -- mysqldump --tz-utc --quick --opt --single-transaction  --skip-lock-tables --comments --dump-date --routines --triggers --all-databases \
  | gzip \
  | tee >(md5sum > "${dump_name}.sql.gz.md5") \
  > "${dump_name}.sql.gz"
echo  "#[${0##*/}]" "after mysqldump" "$(date -Is)"

## List files with their size in KiB:
ls -lnskQ --time-style=iso ${dump_name}* > ${dump_name}.ls

## Bundle together so there's only one file to pass around:
#tar --create --file "${dump_name}.tar" --no-recursion ${dump_name}*

echo  "#[${0##*/}]" "Finished" "$(date -Is)"
exit
