# Redaction
How I'm making sure nothing confidential accidentally gets into the repo.

## Mostly-manual checking
Create a list of files to inspect:
```
TODO
```

Manually read each file line by line looking for things needing redaction; deleting or replacing with dummy values as appropriate.

List all filepaths:
```bash
tree -a -Q -i -f -- $PWD
```
* https://man.archlinux.org/man/tree.1.en
* https://man.archlinux.org/man/du.1.en


Add prefixes for markdown checklist:
```perl
$_ =~ /^(?<filepath>[^\/]+?:)/ && printf("- [ ] `$filepath`\n");
```

Add prefixes for markdown checklist:
```bash
sed 's/^/- [ ] /'
```
* https://man.archlinux.org/man/sed.1.en
* https://stackoverflow.com/questions/2099471/add-a-prefix-string-to-beginning-of-each-line
* https://stackoverflow.com/questions/5254083/sed-to-wrap-lines-in-text-file


Bash pipeline to generate checklist:
```bash
tree -a -Q -i -f | sed 's/^/- [ ] /' > files-checklist.md
```

```powershell
Get-ChildItem -Path . -Force -Recurse | Resolve-Path -Relative | % {$_ -replace '\\', '/' -replace '^(.+)', '- [ ] "$1"'} > meta\file-checklist.md
```

## Automated methods


## Links
### Manpages
* https://man.archlinux.org/man/tree.1.en
* https://man.archlinux.org/man/du.1.en
* https://man.archlinux.org/man/sed.1.en
### Help with sed
* https://stackoverflow.com/questions/2099471/add-a-prefix-string-to-beginning-of-each-line
* https://stackoverflow.com/questions/5254083/sed-to-wrap-lines-in-text-file
