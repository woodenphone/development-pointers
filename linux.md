# Linux
Assorted links relating to linux.


## Using manpages
Manpages are short manuals, typically for specific programs.

Manpages are divided into 8 sections, often denoted like `progname(1)` which would be reached like:
```bash
man sudo 8
```
If you do not specify a section numer then man will just pick one from any matches available.

Brief commandline help for man util itself.
```bash
man --help
```

Basic man invocation format: ` man [man options] [[section] page ...] ...` 
```bash
man
man man
man man 1
```

Introductions to manpage sections.
```bash
man into

man into 1
man into 5
man into 8
```

About manpages.
```bash
man man-pages
```


### Startingpoints
Suggested reading and experimentation starting-points.
Places to begin browsing from.

man(1) "man - an interface to the system reference manuals"
```bash
## Try running these commands in your terminal:
man man
```

apropos(1) "apropos - search the manual page names and descriptions"
```bash
man apropos ## "apropos - search the manual page names and descriptions"

apropos man ## Will return a lot of useless results.
apropos -e man ## [-e|--exact] exact keyword match, much more managable results.
apropos -e '^man' ## [-r|--regex] regex search (default mode),
```

info(1) "info - read Info documents"
```bash
man info ## "info - read Info documents"

info
```

whatis(1) "whatis - display one-line manual page descriptions"
```bash
man whatis ## "whatis - display one-line manual page descriptions"

whatis whatis
whatis man
whatis openssl
whatis curl
whatis cups
```


### Online manpages
Some sites exist that provide HTML versions of manpages you can view in your web browser.
* Online equivalent to `$ man intro` ["intro - introduction to user commands"](https://man.archlinux.org/man/intro.1)
* ["Linux man pages online" (man7.org)](https://www.man7.org/linux/man-pages/)
* ["Linux manual pages: section 1" (man7.org)](https://www.man7.org/linux/man-pages/dir_section_1.html)
* ["Linux manual pages: section 5" (man7.org)](https://www.man7.org/linux/man-pages/dir_section_5.html)
* ["Linux manual pages: section 8" (man7.org)](https://www.man7.org/linux/man-pages/dir_section_8.html)
* ["Linux manual pages: alphabetic list of all pages" (man7.org)](https://www.man7.org/linux/man-pages/dir_all_alphabetic.html)
* ["Linux manual pages: directory by project" (man7.org)](https://www.man7.org/linux/man-pages/dir_by_project.html)
* <https://man.archlinux.org/man/man.7.en>
* ["Online man pages" - "Man page" (ArchWiki)](https://wiki.archlinux.org/title/Man_page#Online_man_pages)
* ["Noteworthy man pages" - "Man page" (ArchWiki)](https://wiki.archlinux.org/title/Man_page#Noteworthy_man_pages)
* ["man page" (Gentoo wiki)](https://wiki.gentoo.org/wiki/Man_page)
* <https://www.mankier.com/>


### Manpage-related
Not manpages nor listings of manpages; but still somehow related to manpages. History, etc.
* <https://manpages.bsd.lv/index.html>
* <https://manpages.bsd.lv/history.html>


## Listings of software
List of software for linux.
* ["Linux Links Directory"](https://www.linuxlinks.com/links/Software/)
* ["List of applications" (ArchWiki)](https://wiki.archlinux.org/title/List_of_applications)
* ["The Linux Alternative Project"](https://www.linuxalt.com/)


## Manuals, handbooks, wikis
Longer manuals and other informative resources.
* ["man page" (ArchWiki)](https://wiki.archlinux.org/title/Man_page)
* Online equivalent to `$ man intro` ["intro - introduction to user commands"](https://man.archlinux.org/man/intro.1)
* Online equivalent to `$ man man-pages 7` ["man-pages - conventions for writing Linux man pages"](https://man.archlinux.org/man/man-pages.7)
* Useful wiki: ["Main Page" (ArchWiki)](https://wiki.archlinux.org/title/Main_page)
* ["Handbook:Main Page" ("Gentoo Handbook") (Gentoo wiki)](https://wiki.gentoo.org/wiki/Handbook:Main_Page)
* ["Main Page" (Gentoo wiki)](https://wiki.gentoo.org/wiki/Main_Page)
* ["Info" (Gentoo wiki)](https://wiki.gentoo.org/wiki/Info)


## Manpages
Short manuals. If it's here it's probably deserved inclusion for being useful.
* <https://www.man7.org/linux/man-pages/man1/tmux.1.html>


## Linux distros
Mint
------
* ["Linux Mint"](https://linuxmint.com/)

Alma
------
* ["Alma linux"](https://almalinux.org/) and ["AlmaLinux ISOs links"](https://mirrors.almalinux.org/isos.html) and [Alma Release notes](https://wiki.almalinux.org/release-notes/) and ["AlmaLinux Howto Guides (external)"](https://wiki.almalinux.org/Howto.html)
* ["AlmaLinux Howto Guides (external)" (AlmaLinux Wiki)](https://wiki.almalinux.org/Howto.html)
* ["Howto Series: AlmaLinux Tutorials  (AlmaLinux Wiki)](https://wiki.almalinux.org/series/)
* ["AlmaLinux Migration Guide" (AlmaLinux Wiki)](https://wiki.almalinux.org/documentation/migration-guide.html) and ["almalinux-deploy" - "EL to AlmaLinux migration tool" (github)](https://github.com/AlmaLinux/almalinux-deploy)
* ["Firewalld: A Beginner's Guide" (AlmaLinux Wiki)](https://wiki.almalinux.org/series/system/SystemSeriesA02.html)
* ["Multimedia Codecs Installation Guide" (AlmaLinux Wiki)](https://wiki.almalinux.org/series/system/SystemSeriesA05.html)
* ["Frequently asked questions" (AlmaLinux Wiki)](https://wiki.almalinux.org/FAQ.html)

Fedora
------
* TODO: Fedora links


## Unsorted links



* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
* [""]()
