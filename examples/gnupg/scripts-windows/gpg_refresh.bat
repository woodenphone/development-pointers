@echo off 
rem gpg_refresh.bat
rem Check if our key is on an attached smartcard and associate it if so.
gpg-connect-agent "scd serialno" "learn --force" /bye