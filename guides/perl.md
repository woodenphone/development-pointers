# Perl
* TODO: WRITEME
* TODO: COPY IN NOTES


## Brief summary
The Perl official docs are good: ["CONTENTS" (Perl documentation)](https://perldoc.perl.org/perl)

Introduction for new users ["perlintro - a brief introduction and overview of Perl" (Perl documentation)](https://perldoc.perl.org/perlintro)

Invocation parameters ["perlrun - how to execute the Perl interpreter" (Perl documentation)](https://perldoc.perl.org/perlrun)

Regex (PCRE - Perl Compatible Regular Expressions):
- ["perlrequick - Perl regular expressions quick start" (Perl documentation)](https://perldoc.perl.org/perlrequick)
- ["perlretut - Perl regular expressions tutorial" (Perl documentation)](https://perldoc.perl.org/perlretut)
- ["perlre - Perl regular expressions" (Perl documentation)](https://perldoc.perl.org/perlre)

["perlsyn - Perl syntax: declarations, statements, comments" (Perl documentation)](https://perldoc.perl.org/perlsyn)

["perlvar - Perl predefined variables" (Perl documentation)](https://perldoc.perl.org/perlvar)


["SYNOPSYS" (Perl documentation)](LINK)


## Installing perl
#### Windows installation

On windows, via `winget`:
```powershell
winget install StrawberryPerl.StrawberryPerl
```


#### Linux installation

Fedora-like using `dnf`
```bash
sudo dnf install perl
```

Debian-like via `apt`
```bash
sudo apt-get update && sudo apt-get upgrade
sudo apt install perl
```


## Editor support
VSCode extention:
```
Name: Perl
Id: richterger.perl
Description: Language Server and Debugger for Perl
Version: 2.6.2
Publisher: Gerald Richter
VS Marketplace Link: https://marketplace.visualstudio.com/items?itemName=richterger.perl
```


## Regular expressions (regex)
Regex (PCRE - Perl Compatible Regular Expressions):
- ["perlrequick - Perl regular expressions quick start" (Perl documentation)](https://perldoc.perl.org/perlrequick)
- ["perlretut - Perl regular expressions tutorial" (Perl documentation)](https://perldoc.perl.org/perlretut)
- ["perlre - Perl regular expressions" (Perl documentation)](https://perldoc.perl.org/perlre)


## Shell oneliners
### Invocation templates
Invocation patterns for perl shell oneliners.
```bash
printf '%s\n' "INPUT_STRING_1" "INPUT_STRING_2" | perl -FLAGS 'PERL_CODE'
```

```bash
echo "INPUT_STRING" | perl -FLAGS 'PERL_CODE'
```

Example oneliner to show who we're hacking today:
```bash
printf '%s\n' "user:pass@host:~/somefile" "user@host:22:/some/abs/path" "joey@lisamylove.maint.usc.edu/dictionary.txt" "sftp://root:god@gibson.ellingson-minerals.com:22:/var/lib/gibson/jobsched/garbage" | perl -n -e '/(?<user>[a-Z0-9-]+)(?<pass>(?:\:)[^@]+)?@(?<host>[a-Z0-9\-\.]+)(?:\:\/)((?<path>[^\0\n]+)?/ && print "Address points to:\n\tuser=$+{user}\n\thost=$+{host}\n\tport=$+{port}\n\tpath=$+{path}\n"'
```



## Script files

Simple clear scaffold for your scripts
```perl
#!/usr/bin/env perl
## myScript.pl
## Very brief synopsis of script.
## Author: YourNameHere
## Created: YYYY-MM-DD
## Modified: YYYY-MM-DD
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
		/x;                 # 'x' - enable inline whitespace/commenting.
	if $2 { # Only emit result line if match pattern.
		$firstNum = $1;
		$secondNum = $2;
		$name = "$+{name}"; # Optional value.
		$answer = mySubroutine($firstNum $secondNum);
		if ($name) { 
			print("$answer ($name)");
		} else {
			print($answer);
		}
	}
}
exit
```
* (##"examples/perl/mySctipt.pl")

Example of running that example script:
```bash
 perl myScript.pl < "mystery-numbers.txt" > "decoded-results.txt" 
```




## Links
### Perl offical documentation

* ["CONTENTS" (Perl documentation)](https://perldoc.perl.org/perl)
* ["perlintro - a brief introduction and overview of Perl" (Perl documentation)](https://perldoc.perl.org/perlintro)
* ["perlrun - how to execute the Perl interpreter" (Perl documentation)](https://perldoc.perl.org/perlrun)
* ["perlrequick - Perl regular expressions quick start" (Perl documentation)](https://perldoc.perl.org/perlrequick)
* ["perlretut - Perl regular expressions tutorial" (Perl documentation)](https://perldoc.perl.org/perlretut)
* ["perlre - Perl regular expressions" (Perl documentation)](https://perldoc.perl.org/perlre)
* ["perlsyn - Perl syntax: declarations, statements, comments" (Perl documentation)](https://perldoc.perl.org/perlsyn)


* ["SYNOPSYS" (Perl documentation)](LINK)
* ["SYNOPSYS" (Perl documentation)](LINK)
* ["SYNOPSYS" (Perl documentation)](LINK)
* ["SYNOPSYS" (Perl documentation)](LINK)


### Other links
* ["TITLE_OR_SYNOPSYS" (SITE)](LINK)
