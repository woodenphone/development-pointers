# Git
Git is a popular Version Control Software (VCS) optimized for text files e.g. Software source code.

Git isn't good at handling binary files and it is considered best practice to avoid including big binary blobs like compiled binaries, firmware images, movies, and so on.


## Quickstart guides
* TOOD: git webguide(s).


## Configuration
* TODO: Mandatory config - username + email.
* TODO: Identity config.
* TODO: Keeping a global gitignore file in your homedir.
* TODO: Rename default branch back to 'master'.
* TODO: Moving config between machines.
* TODO: Scripting git config CLI. 
* TODO: templating git config file format.

## Scope
System: Systemwide for all users.

Global: For the system user.

Local: For the repo.


Example of file locations for different scopes
```
# Via: $ git --no-pager config --show-scope --show-origin --list
## SCOPE ORIGIN KEY=VALUE
system  file:C:/Program Files/Git/etc/gitconfig core.autocrlf=true
global  file:C:/Users/User/.gitconfig   core.autocrlf=false
local   file:.git/config        core.bare=false
```


## Setting configuration
Disabling CRLF conversion (`\n` <-> `\r\n`)
```bash
git config --global core.autocrlf=false
```
* https://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration


### repo-local configuration
Configuration specific to one git repository.
Create a file named `.gitattributes` in the repository root dir.

* https://www.git-scm.com/docs/gitattributes
* https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings#per-repository-settings


Setting config values to repo-local scope:
```bash
## $ git config --local KEY=VALUE
git config --local core.autocrlf=false
```

Listing only repo-local settings:
```bash
git config --local --list
```


### Listing config
Show active config values:
```bash
## KEY=VALUE
git --no-pager config --list
```

Show active config including scope:
```bash
## SCOPE ORIGIN KEY=VALUE
git --no-pager config --show-scope --list
```

Show active config including scope and origin:
```bash
## SCOPE ORIGIN KEY=VALUE
git --no-pager config --show-scope --show-origin --list
```


## Branching
* TODO: Guide on branching and at least one example viable development workflow using branching.

DESCRIPTION
```bash
TODO
```

## Remotes

Listing remotes on git a repository:
```bash
git remote --verbose
```

To add a remote:
```bash
git remote add home-server "ssh://git@10.1.1.69:/~/my-project.git"
```

To push to a remote:
```bash
git push home-server
```

To remove a remote:
```bash
git remote remove home-server
```

* https://git-scm.com/docs/git-remote


#### Setup basic homserver remote
To init and push an exisitng repository to a home git server:

Create bare repo to push to: (On server)
```bash
## As: dev@home-server:~$
## Init bare repo on git server:
## Alternative?: # sudo -u "git" git init --bare "/home/git/my-project.git"
dev@home-server:~$ sudo -u git /usr/bin/bash
git@home-server:~$ git init --bare development-pointers.public.git

## Ensure client's pubkey is present:
dev@home-server:~$ sudo -u "git" nano "/home/git/.ssh/authorized_keys"
```

Add reference to remote and push repo data: (On client / workstation)
```bash
## As dev@workstation:~/repos/my-project$
## Add reference to remote to local git repository:
git remote add home-server "ssh://git@10.1.1.69:/~/my-project.git"

## Push repo to remote:
git push home-server
```


----------



### Creating bare repo 
e.g. for lan server selfhosting

Init bare repo:
```bash
git init --bare "/home/git/my-project.git"
```

Example: sudo into git account to init bare repo on git server:
```bash
$ sudo -u "git" git init --bare "/home/git/my-project.git"
```

Add remote to reference server:
```bash
~/repos/my-project$ git remote add origin "ssh://git@10.1.1.69:/~/my-project.git"
```

----------


## Authentication
* TODO: ssh auth
* TODO: Env vars.
* TODO: GNUPG integration.
* TODO: Signing commits.
* TODO: 2FA.


## Basic git examples
Create a new empty repository in the current dir:
```bash
git init .
```

```bash
## git clone SOURCE_REPO [DEST]
git clone https://github.com/example/example.git
```

Pushing to default upstream:
```bash
git push
```

Pulling from default upstream (usually brings working files to latest upstream commit):
```bash
gut pull
```

Retrieving new changes from upstream without changing current working files:
```bash
git fetch
```

Stage file(s) for commit. (Record the state of the staged files in preparation for committing them.)
```bash
## $ git stage [FILE...]
git stage ./some-file
```

Commit staged changes: (Persist the state of the staged files to the repo.)
```bash
git commit -m "Some message from the commandline, as an example."
```


## Netowrk issue mitigation
Sometimes `git clone` errors out from network troubles; how to fix that?
To make git work even if network connection is unreliable.
* ["How to retry when git clone fail?" (stackoverflow)](https://stackoverflow.com/questions/37849519/how-to-retry-when-git-clone-fail)
* ["The cloning process can be interrupted due to unstable network condition and cannot be resumed. #7440" (github repo "desktop/desktop")](https://github.com/desktop/desktop/issues/7440)
* `GIT_HTTP_LOW_SPEED_LIMIT` and `GIT_HTTP_LOW_SPEED_TIME` ["10.8 Git Internals - Environment Variables" (git documentation - Book)](https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables)
* ["git-config - Get and set repository or global options"(git documentation - Reference)](https://git-scm.com/docs/git-config/2.22.0)

Set git config file values to configure git's HTTP mode to tolerate up to a minute of being under 1KiB/sec: (untested)
```bash
## https://git-scm.com/docs/git-config/2.22.0#Documentation/git-config.txt-httplowSpeedLimithttplowSpeedTime
## Control when git gives up when using curl: (Overriden by env vars)
git config --global http.lowSpeedTime=60 # Seconds.
git config --global http.lowSpeedLimit=1024 # Bytes per second.
```

Use env vars to tell git's HTTP mode to tolerate up to a minute of being under 1KiB/sec: (untested)
```bash
## See: https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
export GIT_CURL_VERBOSE="1" # Similar to 'curl -v'
export GIT_HTTP_LOW_SPEED_LIMIT="1024" # Bytes per second.
export GIT_HTTP_LOW_SPEED_TIME="60" # Seconds.

## After env vars are set git should tolerate low transfer rates.
git clone https://REPO_URL
```


## Files
Relevant files included in this repo.

<./examples/TODO>


## Links
*[""]()
*[""]()


### Official docs for git
*[""]()
*[""]()
*[""]()
*[""]()


### Manpages for git
*[""]()
*[""]()
*[""]()


### Guides for git
*[""]()
*[""]()
*[""]()





### Unsorted links
*[""]()
*[""]()

https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings
https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories


