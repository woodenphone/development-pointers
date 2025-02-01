# Cryptography
(Smartcards, GPG/GNUPG, )


* This is the best guide I know of for getting GNUPG working: ["YubiKey-Guide" (drduh on github)](https://github.com/drduh/YubiKey-Guide)




## Overview of cryptographic concepts
### Hashing
* TODO: Write brief explaination.
### Encryption / decryption
* TODO: Write brief explaination.
### Public key cryptography
* TODO: Write brief explaination.

## 

* TODO: copy in scripts as examples.
* TODO: gnupg guide links.

* TODO: qtpass+gnupg+yubikey - windows.
* TODO: qtpass+gnupg+yubikey - linux.

* TODO: Method to print out key backups.

* TODO: Copy in relevant bulk links


## SSH (Secure SHell)
Overwhelmingly popular and common method to remotely access computers.
* TODO: SSH - Maybe whole document on topic.

* Many CLI utils have an option that lets you run them over SSH. e.g. `rsync --rshell="ssh -p22" SRC DST` 


## password-store / pass / QTPass
Stores passwords using git + GNUPG.
QTPass is a convenient graphical frontend.
Git permits sync between multiple devices using a git server. (selfhosted of course)
* TODO: Links for QTPass.
* TODO: Guides for QTPass.
* TODO: Scripts for QTPass.



## Smartcards / Dongles
Just buy a Yubikey 5 or later equivalent, as feature-rich, many key slots, large keysize, wide compatability.

### GNUPG
Smartcard form-factor GPG cards are troublesome to source, just buy a Yubikey.

[Example config files and scripts for GNUPG (Local)](#./examples/gnupg)


### PIV Card
IDK it's a thing and maybe you can make it work.

I think US govt. likes to use this for their smartcard stuff.


### FIDO / U2F dongles
Each dongle has to be enrolled seperately for each thing.

PAM module exists to use as SSH auth.

Kind of disappointing level of support from businesses e.g. Amazon, Paypal, Ebay.

## Yubikey (made by Yubico)
Makes USB dongles providing various cryptographiic protocols with good configurability.



### Other removable keystorage
#### USB stick
Better used to stash an offline backup of your keys.




## Links
## Unsorted links
* <https://developers.yubico.com/pam-u2f/>
* <https://github.com/Yubico/pam-u2f>
* <https://developers.yubico.com/libfido2/>
* <https://github.com/Yubico/libfido2>

