# Misc. windows information
Assorted pieces of useful info.

## Windows equivalents to linux utils
Programs to do things on windows similar to ones you already have on linux.

### tree - Recursively print paths
`tree` on PWD.

Linux command:
```bash
tree 
```

Windows equivalent:
```powershell
tree
```

Print paths for a certain extention: 
```powershell
get-childitem . -recurse | where {$_.extension -eq ".txt"} | % { Write-Host $_.FullName }
```

Print full paths:
```powershell
Get-ChildItem -Path . -Force -Recurse| % { Write-Host $_.FullName }
```

Print relative paths:
```powershell
Get-ChildItem -Path . -Force -Recurse | Resolve-Path -Relative
```

Print relative paths in linux style using a regex replace:
```powershell
Get-ChildItem -Path . -Force -Recurse | Resolve-Path -Relative | % {$_ -replace '\\', '/'}
```
* <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-7.4>
* <https://learn.microsoft.com/en-us/dotnet/standard/base-types/regular-expression-language-quick-reference>
* <https://learn.microsoft.com/en-us/dotnet/standard/base-types/character-escapes-in-regular-expressions>
* https://ss64.com/ps/replace.html



Tree-related links:
* <https://stackoverflow.com/questions/13126175/get-full-path-of-the-files-in-powershell>
* <https://learn.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.4>
* <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem>
* <https://learn.microsoft.com/en-us/dotnet/api/system.io.fileinfo?view=net-9.0>
* <https://learn.microsoft.com/en-us/dotnet/api/system.io.directoryinfo?view=net-9.0>
* <https://stackoverflow.com/questions/30471988/get-relative-paths-of-all-the-folders-sub-folders-and-files-in-a-folder>
* https://stackoverflow.com/questions/12396025/how-to-convert-absolute-path-to-relative-path-in-powershell
* <https://askubuntu.com/questions/483326/equivalent-to-command-prompts-tree-command>
* ["Tree for Windows" (old - last updated ~2009)](https://gnuwin32.sourceforge.net/packages/tree.htm)
* ["dduan/tre" - " Tree command, improved." (github)](https://github.com/dduan/tre) and ["tre" - "A modern and improved alternative to the tree(1) command." (terminaltrove)](https://terminaltrove.com/tre/)
* <https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/tree>
* ["Pscx/Pscx" - " PowerShell Community Extensions module repository" (github)](https://github.com/Pscx/Pscx)
* ["Windows and Unix command line equivalents " "@carlessanagustin/carlessanagustin/win2ix.md" (github gist)](https://gist.github.com/carlessanagustin/266171818584b3880f72a625dfa2513b)

# Links


# Unsorted links
* <https://stackoverflow.com/questions/38082179/how-to-translate-a-windows-path-for-windows-subsystem-for-linux>
* <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/convert-path?view=powershell-7.4>
* <https://superuser.com/questions/1116771/how-can-i-convert-a-unc-windows-file-path-to-a-file-uri-without-using-any-3rd-pa>
