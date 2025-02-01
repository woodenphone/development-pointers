gnupg-ssh-git-qtpass.windows.md
# GNUPG + SSH + git + QTPass (on Windows)
The term 'smartcard' is inclusive of dongles such as yubikeys.

* TODO



## Troubleshooting resources
Kleopatra GUI has selftest functionality for it and related GPG systems. (`Menu Bar` > `Settings` > `Perform Self-Test`)

In `%APPDATA%\gnupg`
Try clearing `scdaemon.conf` as bad values can prevent recognition of smartcard.




## Links
### Guides
* https://wiki.bibanon.org/QTPass_Guide
* https://wiki.bibanon.org/GPG_Guide
* https://developers.yubico.com/PGP/SSH_authentication/Windows.html


### gnupg / gpg
Core cryptographic engine and CLI.
* config file option index ["Option Index" - ("GNU Privacy Guard Manual")](https://www.gnupg.org/documentation/manuals/gnupg/Option-Index.html)
* This is the good one, look at it. ["Using the GNU Privacy Guard" A.K.A. "GNU Privacy Guard Manual" (Intro/Table of Contents) - ("GNU Privacy Guard Manual"](https://www.gnupg.org/documentation/manuals/gnupg/index.html#SEC_Contents)


### gpg4win
Windows port , installer, Kleoptra GUI.
* https://www.gpg4win.org/documentation.html
* https://files.gpg4win.org/doc/gpg4win-compendium-en.pdf
* https://www.gpg4win.org/get-gpg4win.html
* "The Gpg4win Compendium" (HTML version) <https://www.gpg4win.org/doc/en/gpg4win-compendium.html>
* "C Automatic installation of Gpg4win" <https://www.gpg4win.org/doc/en/gpg4win-compendium_35.html>
* "Contents" <https://www.gpg4win.org/doc/en/gpg4win-compendium_4.html>
* "22 Files and settings in Gpg4win" <https://www.gpg4win.org/doc/en/gpg4win-compendium_28.html>


### scripting examples
Examples of using gpg in scripts.
* https://github.com/woodenphone/gpg-automation/blob/master/linux-apt/stepn.generate-key.sh


## Unsorted links








