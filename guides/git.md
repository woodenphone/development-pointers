## Git


### Basic git config
[--global is per-user, stored in `~/.gitconfig` (git-config manual)](https://git-scm.com/docs/git-config#Documentation/git-config.txt---global)

Linux:
```bash
# $ git config --global SECTION.SETTING VALUE
git config --global init.defaultbranch=master
git config --global user.email "doej@example.com"
git config --global user.name "John Doe"
```


Windows:
```powershell
# > git config --global SECTION.SETTING VALUE
git config --global "init.defaultbranch=master"
git config --global user.email="doej@example.com"
git config --global user.name="John Doe"
git config --global core.autocrlf="input" ## Cross-platform compatability RE newlines.
```


### Shared gitgnore
Windows:
```powershell
git config --global core.excludesfile "${env:USERPROFILE}\.gitignore_global"
```

Linux:
```bash
git config --global core.excludesfile "${HOME}\.gitignore_global"
```

### Intermediate level git config


## Repos on a private server
* TODO: Web-based GUI options
### Plain ssh + git-server



## Command snippets
List current config values:
```powershell
git config --list
```

List current config values with their scope:
```powershell
git config --list --show-scope
```


Traditional master branch name 'master' because compsci heritage.
```powershell
# > git config --global SECTION.SETTING VALUE
git config --global init.defaultbranch=master
```


## Links
* [git-config](https://git-scm.com/docs/git-config/)
