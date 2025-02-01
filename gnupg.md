# GNUPG / GPG


* This is the best guide I know of for getting GNUPG working: ["YubiKey-Guide" (drduh on github)](https://github.com/drduh/YubiKey-Guide)





See also: [Example config files and scripts for GNUPG (Local)](#./examples/gnupg)


## gpg-agent
TODO: Explain.


## Linux
### Installation- (Linux)
Distros that use `dnf` for package management:
```bash
sudo dnf install gnupg
```

Distros that use `apt` for package management:
```bash
sudo apt update && sudo apt upgrade
sudo apt install gnupg
```


### Configuration - (Linux)
* Config files
GPG on Linux stores config in `$HOME/./gnupg/`


### Key management - (Linux)


## Windows
### Installation - (Windows)
* TODO: Options on downloading and installing; automation of the same.


### Configuration - (Windows)
* Config files

GPG on Windows stores config in ``

* TODO: Determine if other locations are used.
* TODO: Determine if registry is used.
* TODO: Get list of related enf vars and functions of eacth.


### Key management - (Windows)


### Smartcard(s) - (Windows)
* Key on smartcard must be trusted absolutely to use it as your key, this must be set when you load the key into GPG.
* "Start/Startup" scripts to launch on user session initialization (login).
* Service to periodically recheck for smartcard association.


### Agent Env Var - (Windows)
User environment variable points to user gnupg-agent socketfile.
Socketfile located in user's temp dir
`%TEMP%/%USER%.gpg-socketfile.sock`

### Common solutions- (Windows)
Restart agent to make GPG load config:
```powershell
gpg-connect-agent killagent /bye
gpg-connect-agent /bye
```

## OS-independant
### Key management
Creation, modification, revocation, deletion, conversion, exporting, etc. of keys.

#### Creating a new secret key
* TODO: Write section
See [drduh guide](TODO: LINKHERE)
#### Learning a key from a file
```bash
gpg TODO
```


#### Editing a key GPG knows
```bash
gpg --edit-key KEY_HANDLE
```

```powershell
gpg --edit-key KEY_HANDLE
```

#### Writing a key to file
* TODO: Write section


#### Erasing a key
* TODO: Write section


#### Exporting to SSH authorized_keys format
Exporting a SSH/SSHD-compatible key string for a secret key GPG knows; as would go in `~/.ssh/authorized_keys`
* TODO: Write section


#### Exporting a key stub for a key residing on a smartcard
A key stub / pointer is needed to tell GPG to look for the secret key on connected smartcards. (Along with GPG learning the smartcard)
* TODO: Write section




## Links
* https://gnupg.org/
* https://github.com/gpg/gnupg
* [GNUPG downloads page (gnupg.org)](https://www.gnupg.org/download/)
* https://wiki.gnupg.org/GnuPG
* https://www.gnupg.org/gph/en/manual/book1.html
* https://wiki.gnupg.org/

### Yubikey utils - (links)
* [yubikey-personalization releases page (developers.yubico.com)](https://developers.yubico.com/yubikey-personalization/Releases/)
* [yubico-c releases page (developers.yubico.com)](https://developers.yubico.com/yubico-c/Releases/)

### Guides - (links)
Guides, tutorials, examples, ect.
* ["YubiKey-Guide" (drduh on github)](https://github.com/drduh/YubiKey-Guide)
* ["gpg.conf" example (drduh on github)](https://github.com/drduh/config/blob/master/gpg.conf)
* ["gpg-agent.conf" example (drduh on github)](https://github.com/drduh/config/blob/master/gpg-agent.conf)
* [Yubikey GnuPG and SSH Auth on Windows and WSL](https://blog.oxycode.one/blog/yubikey-gpg-ssh-auth-windows-wsl/)


### Unsorted - (links)
https://en.wikipedia.org/wiki/X.509
<https://www.gpg4win.org/doc/en/gpg4win-compendium_35.html>


### Packages - (links)
* [winget package definition for "GnuPG.Gpg4win" (SITE)](https://github.com/microsoft/winget-pkgs/tree/master/manifests/g/GnuPG/Gpg4win)
* [winget package definition for "GnuPG.GnuPG" (microsoft/winget-pkgs - github)](https://github.com/microsoft/winget-pkgs/tree/master/manifests/g/GnuPG/GnuPG)
