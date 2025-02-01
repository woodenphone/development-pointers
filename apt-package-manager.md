apt-package-manager.md
# Apt - Package manager
Apt is a popular package manager; if you install a debian-like distro it's probably what you were given.


## Basic / frequent operations
Copypasta to bring installed packages to the most recent version
```bash
sudo apt update && sudo apt upgrade -y
```

Searching package database by keyword:
```bash
sudo apt search KEYWORD
```

Getting info from the package database about a package
```bash
sudo apt info PACKAGE
```

Installing package(s):
```bash
sudo apt install PACKAGE[...]
```

Removing package(s)
```bash
sudo apt remove PACKAGE[...]
```


## Managing repository sources (intermediate skill)
Apt uses the information in TODO to figure out what software repositories to use.
`/etc/apt/`
TODO: Paragraph on this with links to docs


## Less frequent apt commands
TODO: Paragraph on this with links to docs
TODO: history, whatprovides, etc.


## Upgrading your distribution to a later version
```bash
FIXME sudo apt dist-update
```
TODO: Paragraph on this with links to docs


## Automated install of high-importance updates
periodic unattended check for important updates (urgent fixes for security and such) and installation
TODO: Paragraph on this with links to docs


## Links

