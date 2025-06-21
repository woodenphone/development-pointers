#!/usr/bin/env -S perl -lan
## trivial-regex-match-example-001.pl
## Print the line matching the pattern (like grep).
## ==================================== ##
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATED: 2024-08-16
## MODIFIED: 2024-08-16
## ==================================== ##

## ===================< Shebang line / perl invocation params >==================== ##
## '#!/usr/bin/env perl' - Use whatever the default perl binary is.
##
## See: https://perldoc.perl.org/perlrun
##   perlrun - how to execute the Perl interpreter
## -l[octnum] - enables automatic line-ending processing
## -a - turns on autosplit mode when used with a "-n" or "-p". -a implicitly sets "-n".
## -n - loop over program (similar to 'sed -n' or awk)
## ===================< /Shebang line / perl invocation params >==================== ##



m/Serial Attached SCSI controller/i && print "$0";
