# Making a table of repo layous

## Basic listing of repo contents
git-ls seems to work alright, since it understands gitignore rules.


```powershell
git ls-files > FILE.txt
```

```bash
git ls-files > FILE.txt
```

Example output:
```text
examples/ansible-inventory/example-windows.yml
examples/ansible-inventory/testing-vm-thinkpad.yml
examples/ansible-inventory/thinkpad.yml
examples/ansible.practical-example.init-from-repo.md
examples/autohotkey/ctrls-collection.ahk
examples/autohotkey/date_prefix.ahk
examples/autohotkey/datetime_prefix.ahk
examples/bash/accept-env-var-example-a.sh
examples/bash/archive-flashdrive-moderately-simple.sh
examples/bash/archive-flashdrive-very-simple.sh
```


## Converting list of contents into markdown

```powershell
```


Create a file of `- \`some/path/\` "DirDescriptionHere"` lines for each dir with files in it in the repo:
```bash
cd REPO_ROOT_DIR
git ls-files | perl  -lan -e '/(.*\/)[^\/]*/i && print "- \`$1\` \"DirDescriptionHere\" ";' > OUTFILE.md
```



```perl
#!/usr/bin/env -S perl -lan
## Script to wrap filepaths in markdown.
## Input:
## examples/ansible-inventory/example-windows.yml
## Output:
## - `examples/ansible-inventory/` "DirDescriptionHere"

## Match up to last forwardslash:
/(.*\/)[^\/]*/i && print "- \`$1\` \"DirDescriptionHere\" ";
```



## Deciding on a format for the final list

```markdown


```




## Links

### Misc. possible-useful links
- has scripting: https://stackoverflow.com/questions/23989232/is-there-a-way-to-represent-a-directory-tree-in-a-github-readme-md
- meh: https://gist.github.com/EhsanulHaqueSiam/ceda13af0da9589d2f43fdae4ad6fdb1
- looks like pseudo tree for markdown output: https://github.com/aceamarco/repo-structure-generator
- https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes

### manpages
- https://man.archlinux.org/man/tree.1.en




