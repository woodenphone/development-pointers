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
* 



## DOCMETA
Copypasta for writing this.
* ["QUESTION_TITLE" (stackoverflow)](ADDRESS)
* ["TITLE" (SITE)](LINK)
* ["" ()]()

