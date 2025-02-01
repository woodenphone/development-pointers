#!/usr/bin/env bash
## xargs-ghorg-example-alfa.sh
## run 'ghorg' git-hoster organization downloader for many organizations.
## (Copypasta)
## ======================================== ##
## USAGE: $ ./$0
## (Just run the script.)
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2025-01-19
## MODIFIED: 2025-01-19
## ======================================== ##
printf '%s\0' "$@" | xargs --null --verbose --no-run-if-empty -- ghorg clone --clone-type org {};
