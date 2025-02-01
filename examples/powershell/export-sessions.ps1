#!powershell
## export-sessions.ps1
## Export PuTTY saved sessions to file.
## Save all keys in the session to a .reg file named after the session.
## AUTHOR: Ctrl-S, 2022-07-10 - 2022-07-10.
## LICENSE: BSD0
##========================================

## Where PuTTY keeps saved sessions, in powershell format:
$RegSessionsPath = "HKCU:\Software\SimonTatham\PuTTY\Sessions"

$OutputDir = "putty-sessions"

Write-Host "Beginning exporting PuTTY sessions from $RegSessionsPath to $OutputDir";

New-Item -Path "$OutputDir" -ItemType Directory ## Create output dir.

Get-ChildItem -Path "HKCU:\Software\SimonTatham\PuTTY\Sessions" | ForEach-Object {
  $Session = $_ # Incoming piped object from loop

  $SessionPath = $Session.Name ## Registry path of the session.
  $SessionNameRaw = $Session.PSChildName ## Name of the session.

  ## URLDecode
  $SessionNameDecoded = [uri]::UnescapeDataString($SessionNameRaw)
  ## Sanitize
  [System.IO.Path]::GetInvalidFileNameChars() | % {$SessionName = $SessionNameDecoded.replace($_,'-')}
  ## Filepath
  $SessionFilePath = "$OutputDir\$SessionName.reg"

  Write-Host "Exporting $SessionName from $SessionNameRaw to $SessionFilePath";
  ## Export session to file
  reg export "$Session" "$SessionFilePath"
}

Write-Host "Done exporting PuTTY sessions";
