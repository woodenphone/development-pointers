#!/usr/bin/env bash
## backup-all-databases.sh
## Expects user credentials to be provided via 'backups.my.cnf' file.
## https://mariadb.com/kb/en/mariadb-dump/
mysqldump --defaults-extra-file="backups.my.cnf" --tz-utc --quick --opt --single-transaction  --skip-lock-tables  --comments --dump-date --triggers --routines --gtid --all-tablespaces --all-databases | gzip > mariadb_backup.$(hostname).all-databases.$(date +%Y-%m-%d_%H-%M%z=@%s).sql.gz"
