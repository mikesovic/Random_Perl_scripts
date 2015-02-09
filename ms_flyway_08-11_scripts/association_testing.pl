##############################################################################################################################################
## This is a script to figure out the number of unique combinations of segments from the constellation scripts
##############################################################################################################################################
use warnings;
use strict;
use Data::Dumper;
$Data::Dumper::Sortkeys=1;

my @record;
my $OUTPUT1;
my $OUTPUT2;

open (ASSOCIATION, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/association_matrix.txt")||die "cannot open file";
open ($OUTPUT1, ">", "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/association_matrix_counted.txt")||die "cannot open file";

while(<ASSOCIATION>){
	push @record, $_;
}

my %counts;
$counts{$_}++ for @record;
print $OUTPUT1 Dumper(\%counts);
close $OUTPUT1;

open (ASSOCIATION2, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/association_matrix_counted.txt")||die "cannot open file";
open ($OUTPUT2, ">", "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/association_matrix_counted_parse.txt")||die "cannot open file";

my $counter=0;

while (<ASSOCIATION2>){
	chomp;
	if ($counter==1){
		print $OUTPUT2 "$_\t";
	}
	if ($counter%2==0){
		print $OUTPUT2 "$_\n";
		$counter=0;
	}
	$counter++;
}
		
	