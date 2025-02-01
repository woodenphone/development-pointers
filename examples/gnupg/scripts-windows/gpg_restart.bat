@echo off 
rem gpg_restart.bat
rem Kill GPG agent and then restart it.
rem # Kill GPG. 
gpg-connect-agent killagent /bye
rem # Start GPG.
gpg-connect-agent /bye