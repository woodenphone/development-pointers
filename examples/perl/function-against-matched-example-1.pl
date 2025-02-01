#!/usr/bin/env perl
## function-against-matched-example-1.pl
## Convert number-of-bytes type values into IEC units for readability
## ========================================
## LICENSE: BSD
## AUTHOR: Ctrl-S
## CREATD: 2024-08-24
## MODIFIED: 2024-08-24
## ========================================
use strict;
use warnings;
use v5.35;

sub replace_units_bytes {
    # Convert number of bytes into IEC units.
    my $size = shift; # Number of bytes.
    my @units = ("K", "M", "G", "T", "P", "E", "Y");
    my $unitsuffix = "iB";
    my $divisor = 1024;
    return $size . "B" if ($size < $divisor);  # If too small to divide, pass back out as bytes.
    # my $i = 0;
    # for (my $i = -1; $i <= $#units; $i++) { # Loop as many times as we have units.
    # while (my ($i, $unit) = each @units) {
    foreach (@units) {
        # my $unit = @units[$i];
        $size = $size / $divisor; 
        return $size . $_ . $unitsuffix if ($size < $divisor);  # Stop if we can't divide further.
    }
    ## If we run out of units, use the biggest we have (i.e. that from the final loop).
    return $size . $units[$#units] . $unitsuffix;
}


## Loop over STDIN
while (<>) {     # assigns each line in turn to $_
    # Replace numbers of bytes with function result.
    # '$foo =~ s///' style substitution modifies original string.
    # s/regexp/replacement/modifiers
    $_ =~ 
        s/       # Match like: "12345B"
        ([0-9]+) # Match numeric value for conversion.
        (?:B)    # Original unit in non-capturing group to discard it. 
        /        # Execute perl code to generate replacement value:    
        &replace_units_bytes($1)
        /egx; # Regex modifiers.
    # s///g modifier means replace all matches.
    # s///e modifier means evaluate replacement as perl code.
    # /x modifier means enable inline whitespace/commenting.
    
    print "$_"; ## Emit line to STDOUT.
}
