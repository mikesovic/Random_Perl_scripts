use strict;
use warnings;

my $OUTPUT;
my $isolate;
my $name;

open (TITLES, "Titles.txt") || die "cannot open shit";
open ($OUTPUT, ">", "Seq_Titles.txt") || die "can't find shit";

while (<TITLES>){
	chomp;
	$isolate = $_;
	$isolate =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/;
	$name = $1;
	
	print $OUTPUT "$name\n";
}