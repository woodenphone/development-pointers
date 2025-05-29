# Bash commands and basic scripting



### repr style variable printing
Outputting a variable in a manner where you can copy-paste the output and recereate tha original value

Declaring some arbitrary vars for the examples:
```bash
my_var="example"
my_string="The quick brown fox jumps over the lazy dog."
my_array=( 'fib()' 1 1 2 3 5 8 13 21 34 55 '...')
tar_args=(
  --extract
  --gzip
  --file=example.tar.gz
)
```

----------

Builtin command `declare -p VAR_NAME`, most portable and reliable for unknown vars, but doesn't convert tabs and newlines to \t and \n:

Note that `declare -p VAR_NAME` and `typeset -p VAR_NAME` are Just two names for the same thing.

* https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-declare

Examples
```bash
declare -p my_string
declare -p my_array
declare -p tar_args
```

Builtin vars can be hit or miss
```bash
declare -p PS1 # Works
declare -p @ # Fails
```

Maybe best used for stashing complicated or troublesome variables to file for analysis:
```bash
declare -p my_troublesome_var > 'vars.my_troublesome_var'
```

Example: Stashing script parameters or environemt to file
```bash
script_argv=($@) # Copy to array variable to permit variable operations and behaviors.
declare -p script_argv > 'vars.script_argv.declare-p' # Record argv to file
declare -p > 'environment.declare-p' # Record ENV to file
```

----------

Simple array expansion:

e.g. `"${VAR_NAME}" "${VAR_NAME@Q}" "${VAR_NAME[*]@Q}"`

Note: `${var[*]}` and `"${var[@]}"` behave differently.

* https://www.gnu.org/software/bash/manual/html_node/Arrays.html

Can choke on complex cases, but easier to get pretty and easy to reqad outputs for script log messages.
```bash
echo "my_string=${my_string@Q}"  # Generic string case.
echo "my_array=${my_array[*]@Q}"  # Generic array case.

echo "my_string=${my_string@Q};" # Semicolon to indicate end.
echo "my_array=(${my_array[*]@Q});" # Brackets and semicolon to indicate array.

echo "[${0##*/}] tar_args=(${tar_args[*]@Q});" # Scriptname message prefix followed by name=value.
```

----------


Printf `%q` format option with array expanded to become parameters of printf
```bash
builtin printf '"%q" ' "$tar_args[@]" # TESTME
builtin printf '"%q" ' $tar_args[@] # TESTME
echo "#[${0##*/}]" "tar_args:" "$( builtin printf '"%q" ' "$tar_args[@]" )"
```

* https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf

----------


### Check bash version (to validate assumptions)
Test if bash version is recent enough for your script:
```bash
echo "Bash version is ${BASH_VERSINFO:-0}" >&2
if [[ ! "${BASH_VERSINFO:-0}" -le 4 ]]; then { 
	echo "Error: Bash version below minimum supported; requires 4, found ${BASH_VERSINFO:-0}." >&2; 
	exit 1; 
}; else { 
	echo "Bash version is ok." >&2; 
}; fi

```

As a oneliner:
```bash
if [[ ! "${BASH_VERSINFO:-0}" -le 4 ]]; then { echo "Error: Bash version below minimum supported; requires 4, found ${BASH_VERSINFO:-0}." >&2; exit 1; }; else { echo "Bash version is ok." >&2; }; fi

```
----------



### Tolerate nonzero status
Useful if you want to use `set -o errexit` in your script.

Using a lazy-or and a noop:
```bash
smartctl --info /dev/sda || :
```

Using a lazy-or and `/bin/true`:
```bash
smartctl --info /dev/sda || /bin/true
```

Using a lazy-or and `true`:
```bash
smartctl --info /dev/sda || true
```



### Print commands via subshell
Way to record the invocation for a command alongside its output.

```bash
:  $( set -x; ls -lahQF $PWD ) 2>&1 | tee -a "${log:/dev/null}" >&2
```

Explaination:
- `:`  Noop so subshell result does not get interpreted as command.
- `$( set -x; ls -lahQF $PWD )` Subshell that passes back out its STDOUT
 - ` 2>&1 | ` Redirecing STDERR into STDOUT so messages can travel through pipe.
- `COMMAND | tee -a "${log:/dev/null}" >&2` Record STDOUT sent into pipe to logfile and STDERR
 - `tee -a FILE` to append a copy of STDIN to a file, creating it if it does not exist.
 - `${log:/dev/null}"` to use contents of variable `$log`, or if that is unset/null/empty, use `/dev/null` as the value to safely discard the data instead of crashing script.
 - `COMMAND >&2` Redirecting STDOUT of tee to STDERR so it can propogate out to user and keep STDOUT available for sending data around.


Real example:
```bash
## Display ls command and its result:
: $(set -x; date -Is; ls -lahQZF "${archive_pathpfx?}"* ) # noop subshell to print command.
```


More complex real example:
```bash
## (noop xtrace Subshell used to display actial commands and their output for capture.)
: $( PS4=' $ '; set +x; 
	date +@%s; 
	date; 
	date -u -Is; 
	date -Is; 
	date -u '+%Y-%m-%dT%H-%M-%S%z'; 
	date '+%Y-%m-%dT%H-%M-%S%z'; 
	date '+%Z %z';
) 2>1 > "${hostinfo_dir?}/date.txt"
```


### printf tricks

- https://www.man7.org/linux/man-pages/man1/printf.1.html
- https://www.man7.org/linux/man-pages/man3/printf.3.html
- https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf


Setting a var using bash builtin printf:
```bash
## printf [-v var] format [arguments]
$ printf -v my_var '$s $s $s\n' "" "$SECONDS" "" ## Implicitly using builtin.
$ builtin printf -v my_var '$s $s $s\n'  ## Explicitly using builtin.

$ echo "${my_var}"
```

### Padding

```bash
bar="$(dd if=/dev/zero bs=1 count=40 | tr '\0' '=') ##" ## Bar.
```

```bash
bar="$(head -n 40 /dev/zero | tr '\0' '=') ##" ## Bar.
```

----------


### Creating a slug / slugification

Simple removal of invalid chars:
```bash
disk_name_slug="$( printf '%s\n' "${raw_disk_name_string?}" | tr --complement --delete '[:alnum:]-_.' )" ## Slugify (remove unsafe chars)
```

Remove invalid chars and truncate to no longer than 255 bytes:
```bash
disk_name_slug="$( printf '%s\n' "${raw_disk_name_string?}" | tr --complement --delete '[:alnum:]-_.' )" | cut -c1-255 - ## Slugify (remove unsafe chars)
```


Example use in semiautomated disk image creator.
```bash
## ===== Autoname ===== ##
## Info about disk:
## ex: '$ findmnt --noheadings --output=FSTYPE,LABEL,PARTLABEL,UUID --source=/dev/sdh1'
raw_disk_name="$(findmnt --noheadings --output='FSTYPE.LABEL.PARTLABEL.UUID' --source=${target_partition_device})"

disk_name_slug="$( printf '%s\n' "${raw_disk_name_string?}" | tr --complement --delete '[:alnum:]-_.' )" ## Slugify (remove unsafe chars)

outfile="${disk_name_slug?}.${run_timestamp?}.dd-img.gz"
## ===== /Autoname ===== ##

echo "Imaging source_device=${source_device@Q} to outfile=${outfile@Q}" >&2

## Create compressed partition image:
dd if="${source_device?}" | gzip | tee >(md5sum > "${outfile?}.md5") > "${outfile?}"
```

----------


Create a slug for one path segment (dir/file name):
```bash
fn_slugify_example() {
	## Basic slugify function intended for creating path segments.
	## - Coerce to ASCII.
	## - Constrained to [a-zA-Z0-9-_] 
	## - Slug size constrained to 255 bytes.
	## * https://www.man7.org/linux/man-pages/man1/tr.1.html
	## * https://www.man7.org/linux/man-pages/man1/cut.1.html
	printf "%s\n" "${1?}" \
		| iconv -t 'ascii//TRANSLI' \
		| tr --complement '[:alnum:]-_' \
		| cut -c1-255 -
}
my_input="some_arbitrary_string...%#@ exec exit 1; }..." # Untrusted input.
dir_name="$(fn_slugify_pathseg ${my_input})" # Convert to slug.
```
----------


### End of script total duration message

```bash
echo "[${0##*/}] Script finished (at $(date -Is)) and took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete" >&2
```

`${0##*/}` gives the script's filename by 'slicing' the path to the script at the rightmost '/'.

`$(date -Is)` gives the ISO-8601 standard date and time to a 1-second precision.

`$SECONDS` is a shell builtin variable which counts up from when the script/shell was started.

Dividing `$SECONDS` can be used to produce minutes, hours, days, etc.
----------


## Files in this repo
Dirs and files to check out in this same repo.
* ["/examples/bash/" Example bash scripts.](/examples/bash/)


## Links

### GNU Bash manual
The Bash manpage is a different document from the full GNU Bash manual.
* Bash manpage: ["bash(1) — Linux manual page"](https://www.man7.org/linux/man-pages/man1/man.1.html)
* List of GNU Bash manual formats: ["GNU Bash manual" ](https://www.gnu.org/software/bash/manual/)
* One page per node HTML format: ["Table of Contents", "Bash Reference Manual"](https://www.gnu.org/software/bash/manual/html_node/index.html)
* Single-page HTML format ["Bash Reference Manual"](https://www.gnu.org/software/bash/manual/bash.html)
* `$parameter` and `${parameter/pattern/string}` - ["3.5.3 Shell Parameter Expansion" ("Bash Reference Manual", Single-page HTML format)](https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion)
* Tests like `[[ -f file ]]` - ["6.4 Bash Conditional Expressions" ("Bash Reference Manual", Single-page HTML format)](https://www.gnu.org/software/bash/manual/html_node/Bash-Conditional-Expressions.html)
----------
* https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html
* https://www.gnu.org/software/bash/manual/html_node/Arrays.html
* https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-declare
* https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html#index-printf


### Regex
Regular expressions in BASH
* ["A Complete Guide to Bash Regex"](https://linuxsimply.com/bash-scripting-tutorial/string/regex/)
* ["How do I use a regex in a shell script?" (stackoverflow)](https://stackoverflow.com/questions/35919103/how-do-i-use-a-regex-in-a-shell-script)
* ["Regular expressions" (computing.stat.berkeley.edu)](https://computing.stat.berkeley.edu/tutorial-using-bash/regex.html) from ["Bash shell tutorial" (computing.stat.berkeley.edu)](http://berkeley-scf.github.io/tutorial-using-bash/)



### Useful techniques
Useful blocks of code people made, that sort of thing.
* Dedupe array: ["How to remove duplicate elements in an existing array in bash? [duplicate]" (stackoverflow)](https://stackoverflow.com/questions/54797475/how-to-remove-duplicate-elements-in-an-existing-array-in-bash)
* ["How to sleep for 1 second between each xargs command?" (stackoverflow)](https://stackoverflow.com/questions/15153240/how-to-sleep-for-1-second-between-each-xargs-command) (see also example script: [xargs-ghorg-example-bravo.sh](/examples/bash/xargs-ghorg-example-bravo.sh))


### Exmpainations of shell features
Explainations of harder to grasp features and functionality.
e.g. WTF does indirection do and how can it help me?

* ["What is indirect expansion? What does ${!var*} mean?" (stackoverflow)](https://stackoverflow.com/questions/8515411/what-is-indirect-expansion-what-does-var-mean)
* ["Is it possible to use indirection for setting variables?" (stackoverflow)](https://unix.stackexchange.com/questions/68346/is-it-possible-to-use-indirection-for-setting-variables)
* ["Approach Bash Like a Developer - Part 34 - Indirection"](https://www.binaryphile.com/bash/2018/10/28/approach-bash-like-a-developer-part-34-indirection.html)


### Manpages
* ["xargs(1) manpage" "xargs - build and execute command lines from standard input"](https://www.man7.org/linux/man-pages/man1/xargs.1.html)
* ["PAGE manpage" "SYNPOPSIS"](LINK)
* ["PAGE manpage" "SYNPOPSIS"](LINK)
* ["PAGE manpage" "SYNPOPSIS"](LINK)
*

### Guides at mywiki.wooledge.org
Useful level of detail.
- [""]()

* Cheatsheet ["Bash Reference Sheet"](https://mywiki.wooledge.org/BashSheet)
* [BashGuide/Arrays](https://mywiki.wooledge.org/BashGuide/Arrays)
- [BashFAQ - "BASH Frequently Asked Questions"](https://mywiki.wooledge.org/BashFAQ)
- [BashFAQ/005 - "How can I use array variables?"](https://mywiki.wooledge.org/BashFAQ/005)
- [BashPitfalls - "Bash Pitfalls"](https://mywiki.wooledge.org/BashPitfalls)
- [BashProgramming - "Bash Programming"](https://mywiki.wooledge.org/BashProgramming)
- [UnixFaq- "Unix Frequently Asked Questions"](https://mywiki.wooledge.org/UnixFaq)


### Unsorted links
* ["List of applications" (Arch wiki)](https://wiki.archlinux.org/title/List_of_applications)
* [](https://www.linuxlinks.com/links/Software/)
* [What are the rules for valid identifiers (e.g. functions, vars, etc) in Bash?"" (stackoverflow)](https://stackoverflow.com/questions/28114999/what-are-the-rules-for-valid-identifiers-e-g-functions-vars-etc-in-bash)
* ["Differences between declare, typeset and local variable in Bash" (stackoverflow)](https://stackoverflow.com/questions/4419704/differences-between-declare-typeset-and-local-variable-in-bash)
* ["9.2. Typing variables: declare or typeset" (tldp.org)](https://tldp.org/LDP/abs/html/declareref.html)
* ["retrieve bash array by referencing its name as a variable" (unix.stackexchange)](https://unix.stackexchange.com/questions/638775/retrieve-bash-array-by-referencing-its-name-as-a-variable)
* ["Does bash provide support for using pointers?" (unix.stackexchange)](https://unix.stackexchange.com/questions/413449/does-bash-provide-support-for-using-pointers)
* ["Create array in bash with variables as array name"(unix.stackexchange)](https://unix.stackexchange.com/questions/189293/create-array-in-bash-with-variables-as-array-name)
* ["Dynamically create array in bash with variables as array name" (unix.stackexchange)](https://unix.stackexchange.com/questions/199348/dynamically-create-array-in-bash-with-variables-as-array-name?rq=1)
* [GNU findutils - Provides `find`, `locate`, `updatedb`, and `xargs` programs](https://www.gnu.org/software/findutils/); and associated [Manual list](https://www.gnu.org/software/findutils/manual/find.html), [single-page manual](https://www.gnu.org/software/findutils/manual/html_mono/find.html), and [page-per-node manual](https://www.gnu.org/software/findutils/manual/html_node/find_html/index.html); along with their manpages: [xargs(1)](https://www.man7.org/linux/man-pages/man1/xargs.1.html), [find(1)](https://www.man7.org/linux/man-pages/man1/find.1.html), [updatedb(1)](https://www.man7.org/linux/man-pages/man1/updatedb.1.html), [locate(1)](https://www.man7.org/linux/man-pages/man1/locate.1.html).
* ["FOO"](LINK)
* ["envsubst(1) manpage" "envsubst - substitutes environment variables in shell format strings" (man7.org)](https://www.man7.org/linux/man-pages/man1/envsubst.1.html)
  [GNU "gettext" project workpage](https://savannah.gnu.org/projects/gettext)
  [GNU "gettext" homepage](https://www.gnu.org/software/gettext/)
  [GNU "gettext" manual (One page per node HTML format)](https://www.gnu.org/software/gettext/manual/html_node/index.html>
  [GNU "gettext" manual (single-page HTML)](https://www.gnu.org/software/gettext/manual/gettext.html)



## DOCMETA
Copypasta for writing this.
* ["QUESTION_TITLE" (stackoverflow)](ADDRESS)
* ["TITLE" (SITE)](LINK)
* ["" ()]()

