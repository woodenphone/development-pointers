#!/usr/bin/env perl
## myScript.pl
## Very brief synopsis of script.
## Author: YourNameHere
## Created: 2024-12-22
## Modified: 2024-12-22
use strict;
use warnings;
use v5.35;

sub mySubroutine {
	my $dividend = shift; # Number of bytes.
	my $divisor = shift; # Number of bytes.
	my $result = ($dividend / $divisor);
	return "Subroutine gave " . $result . " as the answer."
}

while (<>) { # Loop over STDIN lines.
	# '$foo =~ s///' style substitution modifies original string.
	$_ =~ / 
		^(?<name>[a-Z]+?:)? # Optional name prefix.
		([0-9\+\-\.]+)      # First number in line.
		.?                  # Whatever is in between numbers.
		([0-9\+\-\.]+)      # Second number in line.
	/x;
	# 'x' - enable inline whitespace/commenting.
	$firstNum = $1;
	$secondNum = $2;
	$name = "$+{name}"; # Optional value.
	$answer = mySubroutine($firstNum $secondNum);
	if $2 { # Only emit result line if match pattern.
		if ($name) { 
			print("$answer ($name)");
		} else {
			print($answer);
		}
	}
}
exit
