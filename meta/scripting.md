# Scripting relating to development of this document repo


```powershell
```


```powershell
Get-ChildItem -Path . -Force -Recurse | Resolve-Path -Relative | % {$_ -replace '\\', '/' -replace '^(.+)', '- [ ] "$1"'} > meta\file-checklist.md
```

More complex thing: (WIP)
```powershell
$outfile = "meta\file-checklist.testing.md"

## Header:
write-Output @"# Files checklist
Read the whole file and remove anything confidential before marking off any file.
"@  | Add-Content -Path $outfile

## Checklist of files:
Get-ChildItem -Path . -Force -Recurse  -Attributes '!Directory+Normal' | Resolve-Path -Relative | % {$_ -replace '\\', '/' -replace '^(.+)', '- [ ] "$1"'} | Add-Content -Path $outfile

## Footer:
write-Output @"

"@  | Add-Content -Path $outfile

```

* basically like `$ foo > DEST` and `$ foo >> DEST` and `$ foo | tee DEST > /dev/null` but powershell: <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content>

* <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem>
* Attribute meanings: <https://learn.microsoft.com/en-us/dotnet/api/system.io.fileattributes>
* `$myPowershellStyleHereString = @" foo bar baz "@` https://devblogs.microsoft.com/scripting/powertip-use-here-strings-with-powershell/


```powershell

```

