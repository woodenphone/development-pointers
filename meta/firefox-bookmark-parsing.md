# Tricks for dealing with bookmark list
Patterns here are for vscode `ctrl+shift+f` `Search and Replace` case insensitive, regexes enabled.


## Regexes
### Splitting at folder boundary
Did not really work out.


#### Try 1
^n\s+<DL>(.|\s|\n)+?</DL>

</DL><p>


#### Try 2
\n\s+<DL>.*>\n(.|\s|\n)+?


#### split for readability
(\n\s+<DL>)
(.|\s|\n)+?
(\n\s+</DL><p>)


#### Try 3 
(\n\s+<DL>).+?(\n\s+</DL><p>)


#### Try 4
<DL>.+?</DL>


#### Try 4
<DL>(.|\s|\n)+?</DL>


### Removing links for some site
Match bookmark entry, anything with URL string gets zapped.

AO3 `archiveofourown.org`
```regex
^.\s+<DT>.+archiveofourown.+$
```
Replace: (Empty)

Twitter `twitter.com/`
```regex
^.\s+<DT>.+?twitter\.com/.+$
```
Replace: (Empty)

Fanfiction.net `//www.fanfiction.net/`
```
^.\s+<DT>.+?fanfiction\.net/.+$
```
Replace: (Empty)


### Firefox bookmark metadata clutter
Bookmark icon:
Find:
```regex
ICON="[^"\n]+"
```
Replace: (Empty)


Find:
```
ADD_DATE="\d+"
```
Replace: (Empty)


Find:
```
LAST_MODIFIED="\d+"
```
Replace: (Empty)


Find:
```
ICON_URI="[^"\n]+"
```
Replace: (Empty)


### Clutter from my redaction
Trim whitespace after removing extra elements in a link entry:
Find:
```regex
"\s+>
```
Replace: `">`

Remove whitespace-only lines:
Find:
```regex
^\s+$
```
Replace: (Empty)

Remove extra newlines:
Match: 
```regex
\n{2,}
```
Replace: `\n`




## HTML to markdown
```regex
^(?:\s+)?<DT><A\sHREF="([^"]+)"[^>]*>([^<]+)<\/A>
```

```powershell
> get-content "INPUT_FILE" |  perl -nl -e'/^(?:\s+)?<DT><A\sHREF="([^"]+)"[^>]*>([^<]+)<\/A>/ && print "* DESCRIPTION \"$2\" - $1";' > "OUTPUT_FILE"
```

```powershell
> get-content "INPUT_FILE" |  perl -nl -e'/HREF="([^"]+)"[^>]*>([^<]+)</ && print "* DESCRIPTION \"$2\" - $1";' > "OUTPUT_FILE"
```


Join files:
```bash
## $ cat [FILE...] > OUTFILE
```
```bash
## See: $ man tail
## 'tail [OPTION]... [FILE]...'
## $ tail --verbose --lines=+0 FILES > OUTFILE
tail --verbose --lines=+0 meta\ff-bookmarks-out\*.md > OUTFILE
```
```powershell
## See: $ man tail
## 'tail [OPTION]... [FILE]...'
## $ tail --verbose --lines=+0 FILES > OUTFILE
wsl tail --verbose --lines=+0 meta/ff-bookmarks-out/*.md > meta/ff-bookmarks-out/cuataway.md
```
