#!/bin/bash
## dump-mariadb-bzip.sh
## example of how to do things.
## LICENSE: BSD0 - Go wild, I'm not your mom.
## AUTHOR: Ctrl-S
## CREATED: 2022-05-08
## MODIFIED: 2024-12-21
echo "#[${0##*/}]" "Dumping all databases to file..."
mysqldump --defaults-extra-file=~/.my.cnf --tz-utc --quick --opt --single-transaction --skip-lock-tables --all-databases | bzip2 > ~/"all-databases.$(hostname).$(date +%Y-%m-%dT%H%M%S%z=@%s).sql.bz2"
echo "#[${0##*/}]" "Finished."
exit
##=====< Notes >=====##
## See: https://mariadb.com/kb/en/configuring-mariadb-with-option-files/#options
## https://mariadb.com/kb/en/mysql-command-line-client/
