#!powershell
## Delete-EmptyFiles.ps1
## https://www.winhelponline.com/blog/find-and-delete-zero-byte-files-recursively-windows/
## ======================================== ##
Get-ChildItem -Path "D:\some-base-path" -Recurse -Force | Where-Object { $_.PSIsContainer -eq $false -and $_.Length -eq 0 }  | remove-item
