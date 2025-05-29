#!/usr/bin/env bash
## tmux-dump-session.sh
## Export history of a whole tmux session
## ======================================== ##
## USAGE: $ ./$0
## (Just run the script.)
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2024-07-07
## MODIFIED: 2024-07-28
## ======================================== ##
echo "[${0##*/}]" "Script starting" "at $(date -Is)" >&2


## ==========< Environment var based config >========== ##
# set -x
## Use env vars if set, otherwise use default values.
## -----< output file naming patterns >----- ##
## Patterns here use tmux-style string formatting via tmux display-message; see tmux manpage for syntax and available values.
## Note that you can use regular shell expressions to construct the templates.
##
##  tmux display-message command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE
##  tmux string format substitutions: https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS
##

## Filenames for each pane:
DEFAULT_PANE_FILENAME_PATTERN="tmux.s#{session_id}.#{session_name}_w#{window_index}.#{window_name}_p#{pane_id}.#{window_name}.log"

## Filename for final tarball:
DEFAULT_TARBALL_FILENAME_PATTERN="tmux-session_${HOSTNAME}_$(date '+%Y-%m-%dT%H%M%S%Z')_#{session_id}-#{session_name}.tar.gz"


## Set to the defaults if no env var set:
if [[ -z ${PANE_FILENAME_PATTERN+x} ]]; then
    PANE_FILENAME_PATTERN="${DEFAULT_PANE_FILENAME_PATTERN}"
fi
# echo "PANE_FILENAME_PATTERN=${PANE_FILENAME_PATTERN@Q}" >&2

if [[ -z ${TARBALL_FILENAME_PATTERN+x} ]]; then
    TARBALL_FILENAME_PATTERN="${DEFAULT_TARBALL_FILENAME_PATTERN}"
fi
# echo "TARBALL_FILENAME_PATTERN=${TARBALL_FILENAME_PATTERN@Q}" >&2 
## -----< /output file naming patterns >----- ##
# set +x
## ==========< /Environment var based config >========== ##


## ==========< Shell setup >========== ##
## Safety rails for shell scripting.
## * https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# set -o noclobber  # Avoid overlay files (echo "hi" > foo)
set -o errexit    # Used to exit upon error, avoiding cascading errors
set -o pipefail   # Unveils hidden failures
set -o nounset    # Exposes unset variables
## Shell special vars:
# PATH="$HOME/.local/bin:$HOME/bin:$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin"
## Tracing
# set -o verbose ## Print shell input lines as they are read. (set -v)
# set -o xtrace # Print a trace of simple commands. (set -x) (Uses $PS4)
# PS4='+ ' # Default value.
# PS4='+ $LINENO: ' # Print line number in xtrace.
# PS4='+ ${BASH_SOURCE[0]}|${FUNCNAME[0]}()@${BASH_LINENO[0]}:ln${LINENO} ' ## i.e. '+ FILE|FUNC()@FUNC_LINENO:CURRENT_LINENO '
## ==========< /Shell setup >========== ##


## ==========< Functions >========== ##
f_print_host_info() { ## WIP # Currently unused
    local msg_lines=(
        "## ======================================== ##"
        "[${0##*/}] Begin log (at $(date -u -Is))"
        "HOSTNAME=${HOSTNAME?}"
        "USER=${USER?}"
        "date_iso=$(date -Is)"
        "date_epoch=$(date +@%s)"
        "uname_a=$(uname -a)"
        "script_path=$0"
        "PWD=${PWD}"
        "HOME=${HOME}"
        "PATH=${PATH}"
        "PID=$$"
        "## ======================================== ##"
        "" # Seperator.
    )
    printf '%s\n' "${msg_lines[@]}"
}

f_slugify_pipe(){ # Currently unused
    ## Sanitize $1 into a slug suitable for crossplatform filenames.
    ## e.g. $ safe_string="$( echo my-unsafe-string" | f_slugify )"
    ## Remove any character not listed.
    <&0 tr --complement --delete '[:alnum:]-_.' >&1
}

f_slugify_arg(){ # Currently unused
    ## Sanitize $1 into a slug suitable for crossplatform filenames.
    ## e.g. $ safe_string="$( f_slugify "my-unsafe-string )"
    ## Remove any character not listed. i.e. [a-zA-Z0-9-_.]
    printf '%s\n' "$1" | tr --complement --delete '[:alnum:]-_.'
}

f_bundle_dir() { # Currently unused
	## Bundle results.
	## Function params:
	local out_file="${1?}"
	local source_dir="${2?}"
	mkdir -vp "$(dirname $( realpath "${out_file?}" ))" >&2
	## Create compressed tarball archive of dir contents:
	tar --create --file="${out_file?}.tar.gz" --gzip "${source_dir?}"/*
}

f_dump_pane() { # Currently unused
    local pane_addr=$1
    ## Genenerate filepath for pane dump
    local pane_filename="$(tmux display-message -p "${PANE_FILENAME_PATTERN?}" | tr --complement --delete '[:alnum:]-_.' )"
    # echo "[${0##*/}]" "pane_filename=${pane_filename[*]@Q};" >&2
    local capture_pane_params=(
        ## tmux "capture-pane [-aAepPqCJN] [-b buffer-name] [-E end-line] [-S start-line] [-t target-pane]"
        capture-pane
        -p ## "If -p is given, the output goes to stdout"
		-S '-' # Startpoint is earliest line in history.
		-E '-' # Endpoingt is latest line in history.
		-T # ignores trailing positions that do not contain a character.
        -t "${pane_addr}" # Specify which pane to capture, e.g. 'mysession:mywindow.1'
    )
    # echo "[${0##*/}]" "f_dump_pane():" "capture_pane_params=${capture_pane_params[*]@Q};" >&2
    tmux "${capture_pane_params[@]}" > "${pane_filename?}"
}
## ==========< /Functions >========== ##


## ==========< Traps >========== ##
## Define and register any traps.
trap_err(){ #TESTME!
    ## Function to run when ERR trap triggers.
    echo "[${0##*/}]" "trap_err():" "Trapped ERR signal (at $(date -Is))" >&2
    # builtin caller 1
    echo "[${0##*/}]" "Printing stack trace:" >&2
    ## Stack trace:
    for ((i = 0 ; i < "${#BASH_SOURCE[@]}" ; i++)); do
        printf '%s:%s:%d\n' "${BASH_SOURCE[$i]}" "${FUNCNAME[$i]}" "${BASH_LINENO[$i]}" >&2
    done
    echo "[${0##*/}]" "trap_err():" "Exiting script due to ERR signal." >&2
    exit 1 ## Nonzero status means failure.
}
trap 'trap_err' ERR # Register handler for ERR.

trap_exit(){
    echo "[${0##*/}]" "trap_exit():" "Exit cleanup function started" >&2
    ## Function to run when script exits.
    rm -vrf "${tmpdir?}" >&2
    echo "[${0##*/}]" "trap_exit():" "Exit cleanup function completed" >&2
}
# trap 'trap_exit' EXIT # Register handler for EXIT.
## ==========< /Traps >========== ##

##
## ============================================================ ##
## Main code begins here.
##

## ==========< Prep working dir (tempdir) >========== ##
## Create tempdir
tmpdir=$(mktemp -dt "$(basename $0).XXXXXXXXXX") || { printf '%s\n' "ERROR: Failed to create tempdir" >&2; exit 1; }
# echo "[${0##*/}]" "tmpdir=${tmpdir@Q}" >&2

## Stash actual script used with output:
cp "${0?}" "${tmpdir?}" >&2
## ==========< /Prep working dir (tempdir) >========== ##


## ==========< Dump history of all panes in session >========== ##
## List all panes in the session
list_panes_params=(
    ## $ tmux "list-panes [-as] [-F format] [-f filter] [-t target]"
    list-panes
    -s ## "If -s is given, target is a session (or the current session)."
    ## Need to specify format so tmux will recognize pane address.
    -F "#{session_name}:#{window_id}.#{pane_id}" ## ex from manpage: 'mysession:mywindow.1'
)
# echo "[${0##*/}]" "list_panes_params=${list_panes_params[*]@Q};" >&2
panes=$( tmux "${list_panes_params[@]}" )
# echo "[${0##*/}]" "panes=${panes[*]@Q};" >&2


echo "[${0##*/}] Dumping history for each pane" >&2
## For each pane in the session, dump contents of the pane to a file
for pane in $panes; do
    # echo "[${0##*/}]" "Dump history for pane" "pane=${pane@Q}"
    ## Genenerate filepath for pane dump
    pane_fn_params=(
        ## * display-message command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE
        ## * String format substitutions: https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS
        ## $ tmux 
        display-message
        -t "${pane?}" ## "information is taken from target-pane if -t is given,otherwise the active pane."
        -p "${PANE_FILENAME_PATTERN?}"
    )
    # echo "[${0##*/}]" "pane_fn_params=${pane_fn_params[*]@Q};" >&2
    raw_pane_filename=$( tmux "${pane_fn_params[@]}" )
    # echo "[${0##*/}]" "raw_pane_filename=${raw_pane_filename@Q};" >&2
    
    ## Make filename safe (slugify):
    pane_filename="$( printf '%s\n' "${raw_pane_filename}" | tr --complement --delete '[:alnum:]-_.' )"
    # echo "[${0##*/}]" "pane_filename=${pane_filename@Q};" >&2

    capture_pane_params=(
        ## tmux "capture-pane [-aAepPqCJN] [-b buffer-name] [-E end-line] [-S start-line] [-t target-pane]"
        capture-pane
        -p ## "If -p is given, the output goes to stdout"
		-S '-' # Startpoint is earliest line in history.
		-E '-' # Endpoingt is latest line in history.
		# -T # ignores trailing positions that do not contain a character. (relatively recent feature)
        -t "${pane?}" # Specify which pane to capture, e.g. 'mysession:mywindow.1'
    )
    # echo "[${0##*/}]" "capture_pane_params=${capture_pane_params[*]@Q};" >&2
    tmux "${capture_pane_params[@]}" > "${tmpdir?}/${pane_filename?}"
    # printf '%s\n\n' "[${0##*/}] ----- Dumped pane=${pane@Q} -----" >&2
done
# printf '%s\n\n' "[${0##*/}] ---------- Dumped all panes ----------" >&2
## ==========< /Dump history of all panes in session >========== ##


## ==========< Store extra session info >========== ##
## TODO: Dump extra session info?
# printf '%s\n\n' "[${0##*/}] ---------- Dumping extra info ----------" >&2
# show_session_env_params=(
#     ## * show-environment command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#GLOBAL_AND_SESSION_ENVIRONMENT
#     ## $ tmux
#     show-environment 
#     ## "show-environment [-hgs] [-t target-session] [variable]"
#     -s ## "If -s is used, the output is formatted as a set of Bourne shell commands."
#     -h ## "-h shows hidden variables (omitted by default)"
# )
# echo "[${0##*/}]" "show_session_env_params=${show_session_env_params[*]@Q};" >&2
# tmux "${show_session_env_params[@]}" > "${tmpdir?}/session.envsh"
# tmux show-environment > "${tmpdir?}/session_env.env"
# tmux show-environment -h  > "${tmpdir?}/session_hidden_env.env"
# printf '%s\n\n' "[${0##*/}] ---------- Finished dumping extra info ----------" >&2
## ==========< /Store extra session info >========== ##


## ==========< List produced files >========== ##
# echo "[${0##*/}]" "Temporary working dir contents:" "( tmpdir=${tmpdir@Q} )" >&2
# ( set -x; ls -lhQF "${tmpdir?}" ) >&2 # Subshell with set -x to print the command being run.
# echo "" >&2
## ==========< /List produced files >========== ##


## ==========< Bundle files >========== ##
## Bundle files into tarball.
# printf '%s\n\n' "[${0##*/}] ---------- Bundling results ----------" >&2
echo "[${0##*/}] Packaging files into tarball" >&2
## Genenerate filepath for tarball:
tar_fn_params=(
    ## * display-message command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE
    ## * String format substitutions: https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS
    ## $ tmux
    display-message
    -p ## "If -p is given, the output is printed to stdout"
    "${TARBALL_FILENAME_PATTERN}"
)
# echo "[${0##*/}]" "tar_fn_params=${tar_fn_params[*]@Q};" >&2
raw_tar_filename=$( tmux "${tar_fn_params[@]}" )
# echo "[${0##*/}]" "raw_tar_filename=${raw_tar_filename@Q};" >&2

## Make filename safe (slugify):
tar_filename="$( printf '%s\n' "${raw_tar_filename}" | tr --complement --delete '[:alnum:]-_.' )"
# echo "[${0##*/}]" "tar_filename=${tar_filename@Q};" >&2

## Ensure output dir exists:
mkdir -vp "$(dirname $( realpath "${tar_filename?}" ))" >&2

## Create gzipped tarball, (with no preceeding dirs in paths):
tar_params=(
    ## https://www.man7.org/linux/man-pages/man1/tar.1.html
    --create
    --verbose ## Print filepaths in archive.
    --gzip
    --totals ## Print total size and rate.
    --file="${tar_filename?}"
    --directory="${tmpdir?}" ## Affects arguments after.
    '.'
)
# echo "[${0##*/}]" "tar_params=${tar_params[*]@Q};" >&2
tar "${tar_params[@]}"

printf '\n%s\n' "[${0##*/}] Produced tarball: ( tar_filename=${tar_filename@Q} )" >&2
( set -x; date -Is; 
    pwd; 
    realname "${tar_filename?}"; 
    ls -lnhQF "${tar_filename?}";
) >&2 # Subshell with set -x to print the command being run.
echo "" >&2
## ==========< /Bundle files >========== ##


## ==========< Cleanup >========== ##
# printf '%s\n\n' "[${0##*/}] ---------- Cleaning up ----------" >&2
# echo "[${0##*/}]" "Removing temporary work dir" "( tmpdir=${tmpdir@Q} )" >&2
rm --force --recursive --one-file-system -- "${tmpdir?}" >&2
rmdir "${tmpdir?}" >&2
## ==========< /Cleanup >========== ##

echo "[${0##*/}] Script finished (at $(date -Is)), script took $(( ${SECONDS?} / 86400 ))d $(( ${SECONDS?} / 3600 ))h $(( (${SECONDS?} / 60) % 60 ))m $(( ${SECONDS?} % 60 ))s (${SECONDS?} seconds total) to complete" >&2
exit 0 # Success.
## ======================================== ##
## Docufooter (Unreachable heredoc)
cat <<DOCUFOOTER_HEREDOC_EOF
WRITE STUFF HERE MAYBE


## ======================================== ##
Links:

Manuals:
https://www.man7.org/linux/man-pages/man1/tmux.1.html
https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS
https://www.man7.org/linux/man-pages/man1/tr.1.html
https://www.man7.org/linux/man-pages/man1/tar.1.html

Tmux manpage:
display-message command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#STATUS_LINE
String format substitutions: https://www.man7.org/linux/man-pages/man1/tmux.1.html#FORMATS
show-environment command: https://www.man7.org/linux/man-pages/man1/tmux.1.html#GLOBAL_AND_SESSION_ENVIRONMENT

General links:
https://devhints.io/bash
https://web.archive.org/web/20230406205817/https://wiki.bash-hackers.org/

## Misc. links:
https://stackoverflow.com/questions/18681595/tar-a-directory-but-dont-store-full-absolute-paths-in-the-archive
https://stackoverflow.com/questions/19014576/suppress-set-v-set-x-logging-only-for-a-single-line-in-bash

DOCUFOOTER_HEREDOC_EOF
