# Bash snippets - Notes


### Timestamps
Filename safe timestamps:
```bash
## Timestamp for filenames equals epoch. (pseudo-ISO)
"$(date +%Y-%m-%dT%H-%M-%S%z=@%s)"

## Timestamp for filenames underscore epoch. (pseudo-ISO)
"$(date +%Y-%m-%dT%H-%M-%S%z_@%s)"

## '[+-]HHMM' style timestamp for filenames. (pseudo-ISO)
"$(date +%Y-%m-%dT%H-%M-%S%z)"

## Zulu timestamp for filenames. (pseudo-ISO)
"$(date -u +%Y-%m-%dT%H-%M-%SZ)"

## Minimum strict ISO, UTC; plus unixtime. (Filename-safe)
"$(date -u +%Y%m%dT%H%M%SZ=@%s)"
```

Strict ISO compliant timestamps:
```bash
## Minimum strict ISO, local timezone. (Filename-safe)
"$(date +%Y%m%dT%H%M%S%z)"

## Minimum strict ISO, UTC. (Filename-safe)
"$(date -u +%Y%m%dT%H%M%SZ)"

## ISO timestamp, UTC.
"$(date -uIs)"

## ISO timestamp, local timezone.
"$(date -Is)"
```

Seconds-since-epoch / unixtime:
```bash
## At-sign to indicate value is point-in-time (Preferred for filenames, logs, etc.):
date +@%s

## Minimal numeric seconds-since-epoch (better for arithmatic):
date +%s
```

Trivial unixtime maths example:
```bash
ts_a=$(date +%s) ## Period start (timestamp a).
sleep 10 ## Simulate something that takes time / make period non-zero..
ts_b=$(date +%s) ## Period end (timestamp b).

ts_delta=$(( $ts_b - $ts_a )) ## Calculate difference (larger minus smaller).
echo "Period was ${ts_delta} seconds long."

## Convert units for readability for longer periods (Example of arithmatic)
echo "Period was $((${ts_delta?} / 86400))d $((${ts_delta?} / 3600))h $(((${ts_delta?} / 60) % 60))m $((${ts_delta?} % 60))s (${ts_delta?} seconds total).
```

Using shell builtin variable `$SECONDS` representing seconds elapsed since script started.
```bash
echo "[${0##*/}] Finished. Script took $((${SECONDS?} / 86400))d $((${SECONDS?} / 3600))h $(((${SECONDS?} / 60) % 60))m $((${SECONDS?} % 60))s (${SECONDS?} seconds total) to complete (at $(date -Is))"
```


## Maths
Maths, arithmatic, numeric calculations, etc.

BASH provides some arithmatic functionality.

The `$ dc` caculator program is mandated by POSIX so should be pretty safe to rely on.

Complex maths is better to do in Python due to stricter syntax and variable handling (bash basically just gives strings, python has various complex numeric datatypes available) and having extensive range of libraries.


### Simple bash arithmatic
```bash
a="2"


b="256"
c="$(( $a * $b ))"
d=$((1 + 2 + 3 + 4))
minutes_since_script_started="$(((${SECONDS?} / 60) % 60))"
hours_since_script_started="$((${SECONDS?} / 3600))"
```


### dc (arbitrary precision calculator) (POSIX)
From dc(1) manpage: `dc - an arbitrary precision calculator`
* TODO: WRITE SECTION



## Handy tricks
Script filename as message prefix:
```bash
echo "[${0##*/}] foo bar baz"
## > [example.sh] foo bar baz

echo "[${0##*/}] Indicating some logical event is occuring (at $(date -Is))"

## Send messages for humans to STDERR to avoid polluting STDOUT:
echo "[${0##*/}] foo bar baz" >&2
## '>/dev/stderr ' is equivalent to '>&2'
echo "[${0##*/}] foo bar baz" >/dev/stderr 
```


### Print reusable representation of variable
Variable substitution for simple value:
```bash
foo="example string"
echo "foo=${foo@Q}"
```

Variable substitution for array:
```bash
bar=("example" "array" 1 2 3 "bar")
echo "bar=${bar[*]@Q}"
```

Print reusable representation of ARGV, e.g. to confirm to user script got expected parameters:
```bash
#!/usr/bin/env bash
local args=( "$@" ) # Make actual array to permit array operations. The 'local' keyword prevents variable back-propogation out of functions.
echo "args=${args[*]@Q}" >&2
```

Example as beginning of script:
```bash
#!/usr/bin/env bash

## Display and record the script name, start time, and arguments:
script_argv=( "$@" ) # Make actual array to permit array operations. Regular variable used so functions can access the value.
echo "[${0##*/}] Starting (at $(date -Is)) with script_argv=(${script_argv[*]@Q});" | tee "${log:-log.txt}" >&2
## If we set $log that would be the file the message is recorded to, otherwise it goes to 'log.txt'.
## This lets us copy-paste 'script_argv=...' from the log or terminal to reuse the value.

## <SCRIPT CODE WOULD GO HERE>
```


Example script:
```bash
#!/usr/bin/env bash
## argv-log.sh
## Simple example of argument printing, logging to a file, etc.
## ======================================== ##
## DESCRIPTION:
## Example script showing method to:
## - Print to both console via STDERR and to a log file.
## - Print script argv
## - Print function argv
## - Use a functions STDOUT for returning data to caller.
## - Use default values if a variable isn't set.
## - Pass values into and outof functions.
## ======================================== ##
## USAGE: 
##   $ ./$0 [INTEGER_1] [INTEGER_2]
## Examples:  
##   $ ./$0
##   $ ./$0 1 1
##   $ ./$0 128 1024
## ======================================== ##

## ===== Logfile filename generation: =====
## (Comment and uncomment to test example of handling unspecified logfile.)
# log= ## Null.
# log="" ## Empty string.
# log="mylog.txt" ## Simple string literal.
# log="${0##*/}.$(date +%Y-%m-%dT%H-%M-%S%z).log" ## String generated at runtime.


## ===== Script startup message =====
## Display and record the script name, start time, and arguments:
script_argv=( "$@" ) # Make actual array to permit array operations. Regular variable used so functions can access the value.
echo "[${0##*/}] Starting (at $(date -Is)) with script_argv=(${script_argv[*]@Q});" | tee "${log:-log.txt}" >&2
## If we set $log that would be the file the message is recorded to, otherwise it goes to 'log.txt'.
## This lets us copy-paste 'script_argv=...' from the log or terminal to reuse the value.



example_func() {
	## Demonstration of function args compared to script args.
	## We print messages to STDERR, so function can use STDOUT to send data back out.
	##
	## Store function args into an array variable:
	local function_argv=( "$@" ) # Make actual array to permit array operations. The 'local' keyword prevents variable back-propogation out of functions.
	echo "[${0##*/}.example_func()] function_argv=(${function_argv[*]@Q}); and script_argv=(${script_argv[*]@Q});" | tee "${log:-log.txt}" >&2
	## Trivial example of the function doing some task that requires returning a value to the caller via STDOUT:
	local result="$(( ${1:-16} * ${2:-32} ))" ## If params unset use default values
	echo "${result}" ## STDOUT being used for data back to caller.
}


## Call the function several times:
my_first_result=$(example_func ${1} ${2}) ## First two arguments given to this script.
echo "[${0##*/}] Final result is: ${my_critical_result?}." | tee "${log:-log.txt}" >&2

my_second_result=$(example_func 1 2) ## Arbitrary demo constants.
echo "[${0##*/}] Final result is: ${my_critical_result?}." | tee "${log:-log.txt}" >&2

my_final_result=$(example_func "${my_first_result?}" "${my_second_result?}") ## Use previous results.
echo "[${0##*/}] Final result is: ${my_final_result?}." | tee "${log:-log.txt}" >&2

echo "[${0##*/}] Exiting (at $(date -Is))." | tee "${log:-log.txt}" >&2
exit
```


Builtin `(declare|typeset) -p` command (Both are equivalent) takes the name of variable to print:
```bash
## Simple string:
foo="example string"
declare -p foo
typeset -p foo

## Simple array:
bar=("example" "array" 1 2 3 "bar")
declare -p bar

## Write value file; just redirecting output of 'declare -p' to a file:
declare -p bar > bar.declare

## Append value to new line of file and print STDOUT:
declare -p bar | tee -a bar.declare

## Append value to new line of file and print STDERR:
declare -p bar | tee -a bar.declare >&2

## Append value to new line of file and do not print:
declare -p bar | tee -a bar.declare >/dev/null
```

Builtin `(declare|typeset) -p` command (Both are equivalent) without a variable name specified just prints all variables visible to current scope:
```bash
## Print variables
declare -p 

## Write vars to file; just redirecting output of 'declare -p' to a file:
declare -p > vars.declare
```


### Quick shell refresher
Bash syntax refresher:
`STATEMENT1 | STATEMENT2` feeds STDOUT of `STATEMENT1` to the STDIN of `STATEMENT2`
`< FILE` feeds contents of FILE to STDIN.
`> FILE` feeds STDOUT to FILE.
`${VAR_NAME}` replaced with contents of variable $VAR_NAME; curly braces `{` `}` remove string name ambiguity.
e.g. `chlorides="tetra";` `"carbon$chlorideschloride"` vs. `"carbon${chlorides}chloride"`.



## Custom per-user scripts and functions

```bash
mkdir -v $HOME/bin $HOME/funcs

```

* Could define functions in scripts located in `~/.bashrc.d/`
```bash
#!/usr/bin/env bash
## ~/.bashrc.d
ytdlp() {
	## Log runs.
	local args=( "$@" )
	echo "#> Invoked at $(date -u '+%Y%m%dT%H%M%SZ_@%s') by ${USER}@{$HOSTNAME}:${PWD@Q} with command:" | tee -a "${HOME}/yt-dlp.log"
	echo "#\$ yt-dlp ${args[*]@Q}" | tee -a "${HOME}/yt-dlp.log"
	time yt-dlp "${args[@]}"
}
export -f ytdlp
```

```bash
#!/usr/bin/env bash
## ~/.bashrc.d
example_func() {
	echo "example_func() Invoked at $(date -u '+%Y%m%dT%H%M%SZ_@%s') by ${USER}@{$HOSTNAME}:${PWD@Q} with command:"
}
export -f example_func
```
* http://www.manpagez.com/man/1/bc/
* http://www.manpagez.com/man/1/dc/
* https://www.gnu.org/software/bc/manual/html_mono/bc.html


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

