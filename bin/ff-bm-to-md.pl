## #!/usr/bin/env perl
## ff-bm-to-md.pl
## Convert from firefox bookmarks format to markdown
## ==================================== ##
## USAGE: 
##   $ perl ff-bm-to-md.pl <INPUT_FILE >OUTPUT_FILE
##  PS> get-content INPUT_FILE | perl -- ff-bm-to-md.pl > OUTPUT_FILE
## ==================================== ##
## LICENSE: BSD
## Author: Ctrl-S
## Created: 2024-12-22
## Modified: 2024-12-22
## ==================================== ##
use strict;
use warnings;
use v5.35;

while (<>) { # Loop over STDIN lines.
    /^(?:\s+)+?<DT><A\sHREF="(?<url>[^\"]+)"[^>]+?>(?<title>[^<]+)<\/A>/ && print "* DESCRIPTION \"$+{title}\" - $+{url}"
}
printf "\n"
