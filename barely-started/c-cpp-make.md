# C, C++, and make / makefiles
This is a blob of notes and links as I git gud at building linux software from source. Maybe involving RPM and DNF as well.


## Goals
* [ ] - GOAL1: Build HPE LTFS StoreOpen from source.
* [ ] - GOAL2: Build into all-in-one executable.
* [ ] - GOAL3: Build into all-in-one executable that works.
* [ ] - GOAL4: Build into all-in-one executable that works across distros as long as kernel interfaces are stable.
* [ ] - GOAL5: Test suite of some kind.
* [ ] - GOAL6: Diff the HPE and IBM source code to evaluate viability of merging. (Is it just adding the drive to the list of known drives?)




## working-out
Figuring out what to do and how.

Install toolchain (WIP)
```bash
sudo dnf install -y git gcc cmake 
```

----------




## C compilation
Inclusive of compiling, linking, and preprocessing.

* ["The Book of C"](https://jsommers.github.io/cbook/index.html)
* ["9.1. The compilation process" ("The Book of C")](https://jsommers.github.io/cbook/programstructure.html#the-compilation-process)



## Makefiles
Anything related to `make foo`.

* ["Makefile Tutorial by Example"](https://makefiletutorial.com/) and its [document source](https://github.com/theicfire/makefiletutorial)

* vscode extention: `ms-vscode.makefile-tools`



## LTFS
Links specific to LTFS; particularly HPE LTFS.
* [Mirror of HPE LTFS on github](https://github.com/nix-community/hpe-ltfs)



### Dependancies for LTFS
Packages / libraries / etc. required for LTFS to build and run.

* Local file: </lto-tape.md>
* `icu4c-50_1_2-src.tgz` Actual file: <https://web.archive.org/web/20140815102357/http://download.icu-project.org/files/icu4c/50.1.2/icu4c-50_1_2-src.tgz>


## Unsorted links



* LINK
* ["TITLE"](LINK)

