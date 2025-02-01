# backup_firefox_appdata.ps1
# By Ctrl-S
# USAGE: 
#   Place this script in the base folder you want your firefox backups to be saved.
#   Run the following command:
#   > C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy UnRestricted -File "backup_firefox_appdata.ps1"
#
# ===== DEBUG SETUP =====
# Set up logging / debug message stuff.
#Set-PSDebug -Trace 1 # "1: Trace script lines as they run."
$DebugPreference = "Continue" # Enable console debug messages.
$run_timestamp = Get-Date -UFormat "%Y-%m-%d_t%H-%M_UTC%Z" # Create timestamp for dirname.
# Place to put log files
$log_dir = "$PSScriptRoot\$run_timestamp"
New-Item -Path "$log_dir" -ItemType Directory # Create new folder.
# Write a log file
$log_file_path= Join-Path -Path $log_dir -ChildPath "ps_transcript.txt"
Start-Transcript -Path $log_file_path -NoClobber -IncludeInvocationHeader
Write-Debug "log_file_path=$log_file_path"
# Backup the script as it was at time of execution.
$script_filename= Split-Path -Path $PSCommandPath -Leaf -Resolve
Write-Debug "script_filename=$script_filename"
$script_duplicate_path = "$log_dir\$script_filename.backup" 
Copy-Item "$PSCommandPath" "$script_duplicate_path"
Write-Debug "Finished setting up debug things, now doing actual work."
# ===== /DEBUG SETUP =====

# == config ==
# Set where this script will copy things to.
$base_output_dir = "$PSScriptRoot\backups\$run_timestamp"
Write-Debug "base_output_dir=$base_output_dir"

# == /config ==

function Copy-Folder {
    param( [string]$Src, [string]$Dst )
    Write-Debug "Copying $Src to $Dst"
    New-Item -Path $Dst -ItemType Directory # Create new folder.
    Copy-Item $Src -Recurse $Dst
   }


Write-Output "Now backing up Firefox dirs..."

Copy-Folder "$env:LOCALAPPDATA\Mozilla\" "$base_output_dir\local\Mozilla\"
Copy-Folder "$env:APPDATA\Mozilla\" "$base_output_dir\roaming\Mozilla\"

Write-Output "Finished backing up Firefox dirs."