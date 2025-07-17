# pwgen - Windows password generator

Windows GUI-based random password / passphrase generator.


## Rules of thumb

- More entropy means harder to guess / crack the passphrase.

- Words are easier to keep in your memory and to type than letters.

- Entropy from one alphanumeric character is ~36
- Entropy from a word is ~
- 8 character password is considered trivial to bruteforce in 2025.

- You should be able to enter whatever you choose on a regular US keyboard, on a US phone on-screen keyboard.
- Non-special ASCII characters are much less likely to misbehave.



Adding words together makes for a passphrase that a human can practically remember and type


## Character behavior
Not all characters are created equal.

When in doubt, stick to ASCII printable and ascii space; lowest common denominator.

UTF opens a whole can of worms and means more places for incompatability to occur.


Avoid any form of control character, including newline and carriage return.


### Least-naughty characters
- Base-10 arabic numeral digits. i.e. `1234567890` i.e. `[0-9]` i.e. `[:digit:]`
- Best-behaving character set Alphanumerics i.e. `[:alnum:]` i.e. `a-zA-Z0-9` 
- Spaces, hyphens, underscores. i.e. ` -_`  i.e. `[ _-]`


## Common requirements
Restrictions may be placed on your password.
- Length: 8 to 20 characters.
- At least one capital letter. `[A-Z]`
- At least one digit. `[0-9]`
- At least one punctuation symbol e.g. `!@#$%^&*()-=_+[]{}\|:;"'<>,.?/`
- No forbidden words. e.g. Names, swear words, months, usernames.
- No dates.
- Not identical to a previous password you used. (Indicates they retain previous passwords in some form.)
- Not similar to previous password(s). (Indicates they use insecure non-hashed password storage!)


## Pattern examples
Format of `3[w-]hh` produces:
```text
2 passwords generated.
Entropy of the first password: 47.0 bits.
Maximum entropy of the entire list: 94.0 bits.

slice-morel-1992-d7
hobo-addle-ipso-30
```


Format of `HH-3[w-]hh` produces:
```text
2 passwords generated.
Entropy of the first password: 55.0 bits.
Maximum entropy of the entire list: 110.0 bits.

6A-mask-sully-marsh-de
CD-11th-4e-rabat-03
```


Format of `5[w-]hh` produces:
```text
2 passwords generated.
Entropy of the first password: 73.0 bits.
Maximum entropy of the entire list: 146.0 bits.

ingot-sachs-lux-x9-sb-72
hued-aspire-czar-soap-guise-c4
```


Format of `3[w-hh-]hh` produces:
```text
2 passwords generated.
Entropy of the first password: 71.0 bits.
Maximum entropy of the entire list: 142.0 bits.

angel-b5-bevy-00-steve-75-ee
muzo-a7-rhode-50-route-f7-46
```


Format of `3[w-]ds` produces:
```text
2 passwords generated.
Entropy of the first password: 47.3 bits.
Maximum entropy of the entire list: 94.6 bits.

ask-smile-bluet-9}
jeep-tale-abort-6>
```


Format of `5[w-]ds` produces:
```text
2 passwords generated.
Entropy of the first password: 73.3 bits.
Maximum entropy of the entire list: 146.6 bits.

aaa-bird-made-tor-craw-8;
suave-qr-marlin-fx-shrug-2_
```


Format of `5[w-]dp` produces:
```text
2 passwords generated.
Entropy of the first password: 70.3 bits.
Maximum entropy of the entire list: 140.6 bits.

pion-ww-wheel-we're-breed-1.
addict-rs-zinc-bethel-s9-8;
```


Format of `w` produces:
```text
2 passwords generated.
Entropy of the first password: 13.0 bits.
Maximum entropy of the entire list: 26.0 bits.

blimp
beef
```
(Demonstration of entropy for a randomly-chosen english word, assuming attacker knows password format.)

Format of `a` produces: (`[a-z]`)
```text
5 passwords generated.
Entropy of the first password: 5.2 bits.
Maximum entropy of the entire list: 25.8 bits.

g
e
r
h
q
```


Format of `A` produces: (`[a-zA-Z0-9]`)
```text
5 passwords generated.
Entropy of the first password: 6.0 bits.
Maximum entropy of the entire list: 29.8 bits.

z
e
M
d
I
```


Format of `S` produces: (`[a-zA-Z0-9]` + special chars)
```text
5 passwords generated.
Entropy of the first password: 6.6 bits.
Maximum entropy of the entire list: 32.8 bits.

R
u
g
4
1
```


Format of `E` produces: (`[a-zA-Z0-9]` without ambiguous chars)
```text
5 passwords generated.
Entropy of the first password: 5.6 bits.
Maximum entropy of the entire list: 27.8 bits.

J
p
h
R
e
```


Format of `PATTERN` produces:
```text
RESULT
```



## Links
- https://pwgen-win.sourceforge.io
- https://pwgen-win.sourceforge.io/download/


