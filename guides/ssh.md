# SSH
SSH is assigned the Well-known port `22` by default.


## SSH (client)
Simple SSH URL format: `ssh://USER@HOST:PORT`

More complex SSH URL format explaination: `ssh://[[USER][:PASSWORD]@]HOST[:PORT]/PATH`

Example simple ssh invocation connecting using a SSH URL:
```bash
ssh "ssh://bob@tty-portal.catcorp.net:22:~/quick-links/"
```


### SSH pubkey authentication
To create a new passwordless 4096b length RSA keypair for the current user account:
```bash
ssh-keygen -b 4096 -C "$USER@$(hostname), key created $(date -u +%Y-%m-%d)" -N "" -f ~/.ssh/id_rsa
```
Annotated version of this invocation is stored in ["ssh-mk-key.sh"](/examples/bash/ssh-mk-key.sh)

User secret and public key files take the form:
- `~/.ssh/id_ALGO` 
- `~/.ssh/id_ALGO.pub`

e.g. 
- `~/.ssh/id_rsa`
- `~/.ssh/id_rsa.pub`

User-specific file controlling keys permitted to login to that account:
- `~/.ssh/authorized_keys`


### ssh destination config files
Per-user config lives in: `~/.ssh/config` by default.

You can include a line consisting of `include config.d/*.conf` in `~/.ssh/config` to use dropin config files like `~/.ssh/config.d/sitename.conf`

See the included example files in ["examples/ssh/"](/examples/ssh/) such as ["ssh-config"](/examples/ssh/ssh-config) which is an example of using a directive to utilize a droping config files dir.

* https://www.man7.org/linux/man-pages/man1/ssh.1.html
* https://www.man7.org/linux/man-pages/man5/ssh_config.5.html


## Required file and directory permissions
The `~/.ssh` directory and contents have specific requirements for their ownership, permissions, and possibly SELinux tagging.

The same applies to other `ssh` and `sshd` related files.

SSH will refuse to work if permissions are not correct (for security reasons).

`~/.ssh` needs matching `USER:GROUP` value with permissions `u=rwx,g=,o=` (User can read, write, and list the dir).

Config files within `~/.ssh` such as `~/.ssh/authorized_keys` need matching `USER:GROUP` `u=rw,g=,o=` (User can read and write, cannot execute.)



## SSHD (server)
`/etc/sshd/sshd_config`
`sshd.service`
* https://www.man7.org/linux/man-pages/man5/sshd_config.5.html


## Links
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
* https://www.man7.org/linux/man-pages/man1/ssh.1.html
* https://www.man7.org/linux/man-pages/man5/ssh_config.5.html
* https://www.man7.org/linux/man-pages/man5/sshd_config.5.html
* https://man.openbsd.org/ssh_config.5


### Windows SSH
* https://learn.microsoft.com/en-us/windows/terminal/tutorials/ssh
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh-server-configuration
* https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
* Historical repo https://github.com/PowerShell/Win32-OpenSSH
* Modern repo https://github.com/PowerShell/openssh-portable
* https://github.com/openssh/openssh-portable