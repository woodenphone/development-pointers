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


## Pushing to multiple remotes
How to use one command to push to multiple remotes.
e.g. simultaneously push to homeserver, github, gitgud, etc.
* TODO: Figure this out.



gitlab suggested push:
```bash
git remote rename origin old-origin
git remote add origin git@ssh.gitgud.io:Ctrl-S/development-pointers.git
git push --set-upstream origin --all
git push --set-upstream origin --tags
```

git remote add github git@github.com:woodenphone/development-pointers.git


## Windows ssh push
First connect directly to host via putty to accept the host key, then retry git operation.

Message given:
```
The server's host key is not cached. You have no guarantee
that the server is the computer you think it is.
The server's ssh-ed25519 key fingerprint is:
ssh-ed25519 255 SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU
If you trust this host, enter "y" to add the key to
PuTTY's cache and carry on connecting.
If you want to carry on connecting just once, without
adding the key to the cache, enter "n".
If you do not trust this host, press Return to abandon the
connection.
Store key in cache? (y/n, Return cancels connection, i for more info)
```


## Push to multiple remotes at once
* WIP
* https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes#14290145



Push to all remotes with one command.
Use a special remote that points at all remote dests, both public and privately hosted ones.

```bash
git remote add 
```

### Examples
Methods to do the task I found.

Using a special remote with multiple URLs:
```bash
git remote add all git://original/repo.git
git remote -v ## List remotes.
git config -l | grep '^remote\.all' ## Show config for 'remote.all'
git remote set-url --add --push all git://another/repo.git
git remote -v  ## List remotes.
git config -l | grep '^remote\.all' ## Show config for 'remote.all'
git remote set-url --add --push all git://original/repo.git
```
* Based on: https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes#14290145





Useing a git alias:
```bash
git config alias.pushall '!git push origin devel && git push github devel'
```
* Based on: https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes#14290145



### setting up multiple push destinations via editing .git/config
This method I have tested.

Excerpt of the contents of `.git/config`
```git-config
[remote]
	## Override default to push to all remotes
	## i.e. Make '$ git push' behave like '$ git push pushall'
	## remote.pushDefault "The remote to push to by default" - git-config(1) manpage
	pushDefault = pushall
[remote "pushall"]
	## Convenience pseudoremote to push to all remotes at once
	## remote.<name>.url "first is used for fetching, and all are used for pushing" - git-config(1) manpage
	# url = git://original/repo.git
	## remote.<name>.pushurl - git-config(1) manpage
	pushurl = git@github.com:woodenphone/tmux-dump-session.git
	pushurl = git@ssh.gitgud.io:Ctrl-S/tmux-dump-session.git
	pushurl = ssh://git@PERSONAL_GIT_SERVER_IP_REDACTED:/~/tmux-dump-session.git
```
* [Configuration File git-config(1) manpage](https://git-scm.com/docs/git-config#_configuration_file)
* [`remote.<name>.url` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegturl)
* [`remote.<name>.pushurl` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegtpushurl)
* [`remote.pushDefault` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault)


To push to all remotes (explicitly referencing 'pushall' remote):
```bash
git push pushall -v
```
(`-v` increases verbosity)

To push to all remotes (implicitly due to `remote.pushDefault`):
```bash
git push -v
```

* [Example of ".git/config" file contents](examples/git/dot-git-slash-config.conf)


### Links
Links related to pushing to multiple remotes in one command.
* https://www.kernel.org/pub/software/scm/git/docs/git-config.html 
* https://git-scm.com/docs/git-config
* ["Configuration File" git-config(1) manpage](https://git-scm.com/docs/git-config#_configuration_file)
* [`remote.<name>.url` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegturl)
* [`remote.<name>.pushurl` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegtpushurl)
* [`remote.pushDefault` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault)
* https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes#14290145


----------


## Useful informational commands for troubleshooting 
Show the configuration specific to this repo:
```bash
git config --list --local ## Show configuration for this repo (local scope).
```

Show a list of remotes:
```bash
git remote --verbose ## Show remotes for this repo.
```

How to figure out where config values are coming from.
```bash
$ git config --list --show-scope --show-origin ## Show currently active configuration, explicitly listing scope and where the value came from.
>local   file:.git/config        core.repositoryformatversion=0
```

* Information on git scopes: https://git-scm.com/docs/git-config#SCOPES



## Related utils
Creating git repos from existing codebase history:
* ["esr/git-weave" "git-weave takes a tarball sequence and a metadata file and synthesizes a live repository. It can invert this, explode git repositories into sequences of per-commit tarballs. The DAG is expressed as a metadata file with mailbox-like entries." (by Eric S. Raymond) (gitlab.com)](https://gitlab.com/esr/git-weave)




## Files
Relevant files included in this repo.

* [Example of ".git/config" file contents](examples/git/dot-git-slash-config.conf)


## Links
*[""]()
*[""]()


### Official docs for git
*[""]()
*[""]()
*[""]()
*[""]()


### Manpages for git
*["git(1)" - "git - the stupid content tracker"](https://git-scm.com/docs/git)
*[""]()
*[""]()


### Guides for git
*[""]()
*[""]()
*[""]()





### Unsorted links
*[""]()
*["CRLF vs. LF: Normalizing Line Endings in Git"](https://www.aleksandrhovhannisyan.com/blog/crlf-vs-lf-normalizing-line-endings-in-git/)

https://docs.github.com/en/get-started/getting-started-with-git/configuring-git-to-handle-line-endings
https://docs.github.com/en/get-started/getting-started-with-git/managing-remote-repositories
* https://www.kernel.org/pub/software/scm/git/docs/git-config.html 
* https://git-scm.com/docs/git-config
* ["Configuration File" git-config(1) manpage](https://git-scm.com/docs/git-config#_configuration_file)
* [`remote.<name>.url` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegturl)
* [`remote.<name>.pushurl` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remoteltnamegtpushurl)
* [`remote.pushDefault` git-config(1) manpage](https://git-scm.com/docs/git-config#Documentation/git-config.txt-remotepushDefault)
* https://stackoverflow.com/questions/14290113/git-pushing-code-to-two-remotes#14290145

