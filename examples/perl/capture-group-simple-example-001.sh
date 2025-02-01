#!/usr/bin/env bash
## capture-group-simple-example-001.sh
## ==================================== ##
## Example of using perl to print a message when input contains a certain pattern;
##   where output message is a capture group e.g. /before_capture_group(this_part_gets_captired)after_capture_group/
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2024-08-16
## MODIFIED: 2024-08-16
## ==================================== ##
# set -v # Print lines as they are run (bash option).

echo "diamonds want cake;" | perl -ne 'print "At once your shimmeriness, I shall get the $2 at once.\n" if  m/diamonds?\s+(want|desire|request|seek|need|demand|order)\s+([^\.]+)[\.\;]/i'
