#!/usr/bin/env bash
## accept-env-var-example-a.sh
## Example of a way to accept env vars as script config.
## ======================================== ##
## LICENSE: GPLv3
## AUTHOR: Ctrl-S
## CREATED: 2024-07-11
## MODIFIED: 2024-07-11
## ======================================== ##

## Declare a default value:
DEFAULT_PANE_FILENAME_PATTERN="tmux.s#{session_id}.#{session_name}_w#{window_index}.#{window_name}_p#{pane_id}.#{window_name}.log"
## If var is not set in env, set it to the default value:
if [[ -z ${PANE_FILENAME_PATTERN+x} ]]; then
    PANE_FILENAME_PATTERN="${DEFAULT_PANE_FILENAME_PATTERN}"
fi

## Show the value of our var, and demonstrate it being used:
echo "PANE_FILENAME_PATTERN=${PANE_FILENAME_PATTERN@Q}" >&2

exit