# Sed
Sed - Stream EDitor, has own expression language to alter text stream (or file)

Examples and links for 'sed'

`sed [OPTION]... {script-only-if-no-other-script} [input-file]... `


## Examples
Most common use pattern:
```bash
sed "s/PATTERN/REPLACEMENT/g"
sed "s|PATTERN|REPLACEMENT|g" # Equivalent to previous, just using '|' as delimiter.
```

Using sed to perform basic text substitution:
```bash
table="k_images"
sed "s/qa_images/${table}/g" < enable-compression.template.sql > enable-compression.table-name.sql
```

Trivial example 2:
```bash
curl "http://example.com/dummy_feed.tab" | sed "s|Cloud comput|Unreliable comput|g" | text2speech
```

Edit a file in-place using sed's in-place option.
```bash
## Example of [-i|--in-place] option.
sed --in-place PATTERN FILE
sed -i PATTERN FILE
```


### Multiple patterns together (Examples)
Multiple patterns:
```bash
sed "s/PATTERN_1/REPLACEMENT_1/; s/PATTERN_2/REPLACEMENT_2/;" 
sed "s/PATTERN_1/REPLACEMENT_1/; s|PATTERN|REPLACEMENT|;" # Equivalent to previous, just using '|' as delimiter.
```
* ["sed with multiple expression for in-place argument" (stackexchange)](https://unix.stackexchange.com/questions/174609/sed-with-multiple-expression-for-in-place-argument)


### Lazy SQL templating (Examples)
(Don't ever do this for values you did not input yourself, because that would permit SQL injection attacks.)

Sed can be handy for simple SQL templating

Replacing a placeholder with a value:
```bash
sed "s|%%site_name%%|SuperDuperWebBoards|g" < "some-task.template.sql" > "statement.sql"
```

Replacing a placeholder with a the contents of a shell variable (Good for use in shell scripts).
```bash
sed "s|%%site_name%%|${site_name?}|g" < "some-task.template.sql" > "statement.sql"
```

Assuming we already have a SQL template `create-board.template.sql` and have declared values in the shell:
```bash
## Values to substitute:
site_name="SuperDuperWebBoards"
board_name="AdministratorHelp"
board_desc="Adminsitrator Help Desk"
```

Multiple processes in a pipeline
```bash
sed "s|%%site_name%%|${site_name?}|g" < "create-board.template.sql" \
	| sed --expression="s|%%board_name%%|${board_name?}|g" \
	| sed --expression="s|%%board_desc%%|${board_desc?}|g" \
	> "create-board.sql"
```

Single process with multiple expressions
```bash
sed --expression="s|%%site_name%%|${site_name?}|g" \
	--expression="s|%%board_name%%|${board_name?}|g" \
	--expression="s|%%board_desc%%|${board_desc?}|g" \
	"create-board.template.sql" > "create-board.sql"
```

Expression(s) from file:
```bash
sed --file="create-board.sed" "create-board.template.sql" > "create-board.sql"
```

Contents of `create-board.sed`
```sed
#!/usr/bin/env sed -f
# This substitutes placeholders in a template with the actual values.

s|%%site_name%%|SuperDuperWebBoards|g
s|%%board_name%%|AdministratorHelp|g
s|%%board_desc%%|Adminsitrator Help Desk|g
```


### Quick shell refresher
Bash syntax refresher:
`STATEMENT1 | STATEMENT2` feeds STDOUT of `STATEMENT1` to the STDIN of `STATEMENT2`
`< FILE` feeds contents of FILE to STDIN.
`> FILE` feeds STDOUT to FILE.
`${VAR_NAME}` replaced with contents of variable $VAR_NAME; curly braces `{` `}` remove string name ambiguity.
e.g. `chlorides="tetra";` `"carbon$chlorideschloride"` vs. `"carbon${chlorides}chloride"`.


### Executable sed scripts (Examples)
Essentially just use the standard style shebang header.
```sed
#!/usr/bin/env sed -f
# Hash symbol as comment
```

Show current PATH value quoted for copypasting:
```bash
echo "PATH=${PATH@Q}; (at $(date -Is))"
```


Persistantly add dir to PATH:
```bash
echo "PATH=${PATH@Q}; (at $(date -Is))" ## Show value before making changes (to prove it works).

printf '%s\n' 'export PATH="$PATH:$HOME/bin"' | tee -a ~/.bashrc ## 'tee' appends lines more reliably than '>>'.
source ~/.bashrc ## Reload .bashrc, now with the statement adding our dir to PATH. 

echo "PATH=${PATH@Q}; (at $(date -Is))" ## Show value after making changes (to prove it works).
```

Or just use an editor to alter `.bashrc` to modify PATH: `$ nano ~/.bashrc`
```bash
## Add my custom scripts dir to my PATH:
export PATH="$PATH:$HOME/bin" ## This make my scripts get ignored in favor of systemwide programs with the same name.
export PATH="$HOME/bin:$PATH" ## This makes my scripts run innstead of any systemwide programs with the same name.
```

Or even make it optional whether scripts override systemwide executables of the same name.
```bash
## Add my custom scripts dir to my PATH:
export PATH="$PATH:$HOME/bin" ## These executables should be overridden by normal systemwide ones if the names are the same.
export PATH="$HOME/bin/overrides:$PATH" ## These executables should override the normal systemwide ones for me.
```


To add a dir for user-specific executables:
```bash
## Create a dir for personal scripts to go in:
mkdir -v "$HOME/bin"

## Append dir to PATH:
export PATH="$PATH:$HOME/bin"

## Place script in personal scripts dir:
cp -v my-script.sed $HOME/bin

## Set script executable:
chmod -v +x "$HOME/bin/my-script.sed"

## Run the script
my-script.sed input.txt > output.txt
```


## Development
Obtaining source from [Offifical GNU sed git repo](git://git.sv.gnu.org/sed)
```bash
git clone git://git.sv.gnu.org/sed`
```


## Local manuals
Distros expecting human users typically come with the packages containing manuals for installed software - e.g. `man-utils` 

Manpage:
```bash
man sed
```

Longform manual (via Texinfo):
```bash
info sed
```


## Links
* Official GNU sed site with links to other resources: <https://www.gnu.org/software/sed/>
* [sed on GNU FTP server (HTML view)](http://ftp.gnu.org/gnu/sed/)


### Manuals
* Manpage, shorter and more concise than full manual: https://www.man7.org/linux/man-pages/man1/sed.1.html
* Official manual: [GNU sed - Links to different formats of the manual](https://www.gnu.org/software/sed/manual/)
* Official manual: ["sed, a stream editor" - GNU sed manual (one web page per node)](https://www.gnu.org/software/sed/manual/html_node/index.html)
* Official manual: ["sed, a stream editor" - GNU sed manual (single-page HTML)](https://www.gnu.org/software/sed/manual/sed.html)


### Cheatsheets
* ["Sed Cheat Sheet" ("sergeyklay/sed-cheatsheet.md" on github)](https://gist.github.com/sergeyklay/4641c7665b262680f8b9cf38de923af1)


### Further reading
* [List of 3rd-party guides](https://sed.sourceforge.io/#docs)
* [List 3rd-party print books](https://sed.sourceforge.io/#books)
* [List 3rd-party example scripts](https://sed.sourceforge.io/#script)

* ["THE SED FAQ"](https://www.pement.org/sed/sedfaq.html)
* [elflord's sed tutorial](http://www.panix.com/~elflord/unix/sed.html)
* https://github.com/adrianlarion/useful-sed
* https://github.com/adrianlarion/text-processing-recipes-linux


### Source code
* GNU sed source code: ["sed - GNU stream editor" (GNU Savannah git repo html viewer)](https://git.savannah.gnu.org/gitweb/?p=sed.git)
* GNU sed source code: ["index : sed.git"](https://git.savannah.gnu.org/cgit/sed.git)
* GNU sed source code mirror (comfy) (github has fancy web interface with keyword/symbol refernce linker wiget): ["sed" (github mirror)](https://github.com/mirror/sed) 
* GNU sed source code direct git repo link: (git://git.sv.gnu.org/sed)


### Sed for windows
* https://gnuwin32.sourceforge.net/packages/sed.htm


### Online tools
* Online expression tester: https://sed.js.org/


### POSIX
Parts of POSIX relating to sed.
* POSIX sed specification: ["sed" (The Open Group Base Specifications Issue 6) (IEEE Std 1003.1, 2004 Edition)](https://pubs.opengroup.org/onlinepubs/009695399/utilities/sed.html)
* POSIX regular expression specification: ["9. Regular Expressions" (The Open Group Base Specifications Issue 6) (IEEE Std 1003.1, 2004 Edition)](https://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html)
* POSIX front page: ["POSIX.1-2008"](https://pubs.opengroup.org/onlinepubs/9699919799.2008edition/) ["POSIX.1-2017"](https://pubs.opengroup.org/onlinepubs/9699919799/) ["POSIX.1-2024"](https://pubs.opengroup.org/onlinepubs/9799919799/)


### Questions and answers
FAQs, forum threads, mailing list excerpts, stackoverflow, etc.
* ["sed with multiple expression for in-place argument" (stackexchange)](https://unix.stackexchange.com/questions/174609/sed-with-multiple-expression-for-in-place-argument)
* ["" ()]()


### Examples

