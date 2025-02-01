#!perl -lan
## size-conv.pl

sub conv_bytes {
  ## Argument:
  $sizenum = $_[0];
  
  @units=("B","KiB","MiB","GiB","TiB","PiB");
  while ($sizenum > 1024) {
    $sizenum/=1024;
    shift @units;
  }
  $result = sprintf("%.2f%s", $sizenum, $units[0]);
  return $result;
}

foreach my $line ( <STDIN> ) {
  $line =~ s/(size:)(\d+)/$1 . conv_bytes($2)/e;
  $line =~ s/(deleted_bytes:)(\d+)/$1 . conv_bytes($2)/e;
  printf $line
}
printf "\n"
