#!/usr/bin/env perl
## myScript.pl
## Take lines of filpaths and prefix them with markdown checkboxes.
## (Oneliner stored in a script file.)
## Author: Ctrl-S
## Created: 2025-01-03
## Modified: 2025-01-03
use strict;
use warnings;
use v5.35;

$_ =~ /^(?<filepath>[^\/]+?:)/ && printf("- [ ] `$filepath`\n");
