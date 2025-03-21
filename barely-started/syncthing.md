# Syncthing - Inter-computer folder and file sync utility
* TODO: Write guide.
* TODO: Write ansible scripting to setup syncthing.
* TODO: Add annotated links.
* TODO: Validate guide works.


## Syncthing in WSL (Windows Subsystem for Linux)
Running syncthing inside Windows Subsystem for Linux.

Intended to go along with ansible development using WSL vscode remote, syncthing between Windows User homedir and location inside WSL user homedir.

* See headless setup but point it at WSL.

Assuming WSL is listening for SSH traffic on host port 10022:

Either:

Creating tunnel with portforward:
```powershell
ssh "ssh://WSL_USER@127.0.0.1:10022" "-L" "18384:127.0.0.1:8384"
```
For info on parameters see the [ssh(1) manpage](https://www.man7.org/linux/man-pages/man1/ssh.1.html)

or

Just use PuTTY portforwarding.




## Syncthing setup on Linux (headless) (Debian)
Setting up Syncthing on a Debian-like Linux distro purely from the command line.

### Install
Bring package DB up to date and upgrade installed packages to the latest version:
```bash
sudo apt-get update -y && sudo apt-get upgrade -y
```

Install dependancies:
```bash
sudo apt-get install apt-transport-https ca-certificates curl gnupg 
```

----------

* TODO: Syncthing - packages + binaries

Install syncthing repo and in turn syncthing: (For distros using apt package manager e.g. Debian) 
```bash
# Add the release PGP keys:
sudo mkdir -p /etc/apt/keyrings
sudo curl -L -o /etc/apt/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg

# Add the "stable" channel to your APT sources:
echo "deb [signed-by=/etc/apt/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list

# Update and install syncthing:
sudo apt-get update
sudo apt-get install syncthing
```
* From: [Installation guide and apt repository for syncthing](https://apt.syncthing.net/)


----------


* TODO: Syncthing - service
```bash

```

----------
### Config
* TODO: WIP: Syncthing - config and auth

#### Remote headless configuration - WebGUI via portforwarding
Configuring Syncthing using its WebGUI using portforwarding over a ssh tunnel.

Forward port 8384 of target to you master workstation to access the WebUI of syncthing.
i.e. (http://localhost:8384/)

Creating tunnel with portforward:
```bash
## -L [bind_address:]port:host:hostport
## Local:  -L port:host:hostport
ssh "ssh://USER@10.1.1.69:22" "-L" "18384:10.1.1.69:8384"
```
For info on parameters see the [ssh(1) manpage](https://www.man7.org/linux/man-pages/man1/ssh.1.html)

* You would then use your web browser to connect to: http://localhost:18384/

* https://docs.syncthing.net/users/config.html


#### Remote headless configuration - pure CLI 
Configuring Syncthing on the headless machine while avoiding the use of a web browser entirely.

* TODO: pure CLI config

* https://docs.syncthing.net/users/config.html
* https://docs.syncthing.net/users/config.html#config-file-format


----------



# Links
## Syncthing general
* https://docs.syncthing.net/users/introducer.html
* https://github.com/syncthing
* https://github.com/syncthing/syncthing
* https://docs.syncthing.net/intro/getting-started.html
* https://docs.syncthing.net/users/contrib.html#contributions
* https://apt.syncthing.net/
* https://github.com/syncthing/syncthing/releases


## Configuration
* https://docs.syncthing.net/users/config.html
* https://docs.syncthing.net/users/config.html#config-file-format


### Unsorted links
* foo
*[""]()
*[""]()
*[""]()
*[""]()
