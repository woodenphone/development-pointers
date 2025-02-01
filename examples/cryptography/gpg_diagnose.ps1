## gpg_diagnose.ps1
## Basic diagnostic/troubleshooting script for GPG
## By: "Ctrl-S"
## Created: 2020-10-20
## Modified: 2020-10-21
## == DIAGNOSE ==
Write-Host("== DIAGNOSE ==")
Write-Host("DIAGNOSE: Resolve abspaths of noteworthy files")
# Display path of GPG and other likely relevant programs
where.exe gpg
where.exe git
where.exe putty

Write-Host("DIAGNOSE: Check content of GPG conf files")
# Check if certain files exist:
# GNUPG config files
Get-Content -Path "%APPDATA%\gnupg\gpg-agent.conf"
Get-Content -Path "%APPDATA%\gnupg\scdaemon.conf"


Write-Host("DIAGNOSE: List smartcards")
gpg --card-status # Inspect smartcard.


# List keys
Write-Host("DIAGNOSE: List host public keys")
gpg --list-keys
Write-Host("DIAGNOSE: List host secret keys")
gpg --list-secret-keys


Write-Host("== /diagnose ==")
## == /DIAGNOSE ==
##
## == REPAIR ==
## Try to fix things
Write-Host("== REPAIR ==")

Write-Host("REPAIR: Resstart GPG")
# Kill GPG.
gpg-connect-agent killagent /bye
# Start GPG.
gpg-connect-agent "/bye"
Start-Sleep -s 2 # Let task complete before anything else


Write-Host("REPAIR: Associate with smartcard")
# Associate with smartcard if present
gpg-connect-agent "scd serialno" "learn --force" /bye
Start-Sleep -s 2 # Let task complete before anything else

## == /REPAIR ==
Write-Host("== End of script ==")