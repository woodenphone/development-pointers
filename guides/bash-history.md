# Bash history (remembering previous commands)
Bash includes various options to configure it's builtin history.


* TODO: Write this.
* TODO: Copypaste in files and docs.

## Recommendations
Backup history file before making history config changes
```bash
cp -v ~/.bash_history ~/".bash_history.$(date +%Y-%m-%dt%H-%M-%S%z).backup"
```

In-memory history size is generally fine being some low number like 500.
`export HISTSIZE="500"`

History file lines is better set to something very high or to be unlimited.
Controlled by: `HISTFILESIZE`

Configure bash to append commands to history immediately so they get reliably saved to file.
`export PROMPT_COMMAND="history -a; $PROMPT_COMMAND" ## Keep per-pane runtime history, but immediately update historyfile as commands are run.`


Set a timestamp string for the history file so that you can know when you ran a command.
`export HISTTIMEFORMAT="%Y-%m-%dT%H:%M:%S%z $ " # line prefix format (format string for strftime)`

Permit duplicate entries so that you can better see what you were doing in what order.
`export HISTCONTROL="" # Retain all commands.`

Always set bash to append to history file, to tolerate multiple shell sessions being open at once. 
`shopt -s histappend # Append to history file, for multi-session history handling.`




## Files in repo
* [Example dropin history config - "history.sh"](examples\bash\bashrc.d\history.sh)

## Links
* TODO: Add more links.

### Bash documentation
* ["HISTTIMEFORMAT" (bash manual) (Single-page HTML format)](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#index-HISTTIMEFORMAT)
* ["5.2 Bash Variables"](https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html)
* ["4.3.1 The Set Builtin"](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html)


### Guides, tuorials, etc.
* [](https://www.digitalocean.com/community/tutorials/how-to-use-bash-history-commands-and-expansions-on-a-linux-vps)


### Manpages
* ["bash(1)" "bash - GNU Bourne-Again SHell"](https://www.man7.org/linux/man-pages/man1/bash.1.html)
strftime manpage
* []()
* libc ["strftime(3)" "strftime - format date and time"](https://www.man7.org/linux/man-pages/man3/strftime.3.html)
* POSIX ["strftime(3p)" "strftime, strftime_l — convert date and time to a string"](https://www.man7.org/linux//man-pages/man3/strftime.3p.html)
* []()
* []()
* []()


### Unsorted links
* []()
* []()
* []()