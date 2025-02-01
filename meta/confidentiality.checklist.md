# Confidentiality checklist
Checklist of every file, to each be checked manually from start to end.

## Generating checklist
```bash
tree | sed 's/^/[_] -"/'
```
[todo](/bin/todo.sh)
[todo](/bin/todo.ps1)

```powershell
Get-ChildItem -Attributes !Directory -Path . -Force -Recurse | Resolve-Path -Relative | % {$_ -replace '\\', '/' -replace '^(.+)', '- [ ] "$1"'} > meta\file-checklist.md
```
* <https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem>


## md-store (Meta)
* [_] - <filepath>
* [x] - ""
