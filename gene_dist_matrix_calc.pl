##############################################################################
#This is an old version of a process... might be better to run something closer to the patristic_comparison.pl 
#
#
#Right now we have to delete the first two rows of the input matrices in order to get the right dimensions and correct lower halves of the matrices.
#############################################################################
use strict;
use warnings;

my $OUTPUT_FILE;

print "What is the name of the matrix you would like to put in column format:";
my $matrix = <STDIN>;
 
open (MATRIXCONV, "$matrix")|| die "cannot open file";
open ($OUTPUT_FILE, ">" . "convertedmatrix.txt" || die "cannot open");

my $i = 2;
my @numbers;
my @distances;
my @final;

while (<MATRIXCONV>){

	chomp;
	
	@numbers = split (/\s/, $_);
	@distances = @numbers[$i..364];
	
		foreach my $element (@distances) {
			push @final, "$element\n";
		}
		$i++;	
}
print $OUTPUT_FILE @final;

