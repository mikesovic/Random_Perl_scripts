#First - parse the patristic titles out in order of how the patristic matrix will be calculated... do this in EXCEL
#Second - take all of the location names from the sequences and figure out the number of unique names... do this in R

use strict;
use warnings;

open (LOCATIONS, "locationscoordpatmat.txt")||die "cannot open file"; #empty matrix in .txt format to be populated in same order as the patristic matrix.
open (OUTPUT, ">paircoordspatmat.txt")||die "cannot open file";

#This hash assignment could propably be more efficient if I were to do a control structure when assigning keys => values from the original text files.
# my %latcoords = (Ohio=> '40.32142', Alaska => '66.16051', Delaware => '38.985033', Illinois => '40.153687', Indiana => '40.187267', Iowa => '42.081917', Maryland => '39.27479',
	# Mississippi => '33.587167', Missouri => '38.203655', Michigan => '43.197167', Wisconsin => '44.292401');
	
# my %longcoords = (Ohio => '-82.854309', Alaska => '-151.706544', Delaware => '-75.455017', Illinois => '-89.188843', Indiana => '-86.123657', Iowa => '-93.583374', Maryland => '-76.620484',
	# Mississippi => '-90.36438', Missouri => '-92.078247', Michigan => '-84.532471', Wisconsin => '-89.608155');
	
#Now we need to make a file of all pairwise comparisons and their resulting origin 1. lat 2. long dest 3. lat 4. long

my $coord1;
my $coord2;
my @seqlocations;

while (<LOCATIONS>) {
	chomp;
	$coord1 = $_;
	push @seqlocations, $coord1;
	}

my $Current = 1;
	
foreach my $coord1 (@seqlocations) {
	
	
	foreach $coord2 (@seqlocations[$Current..363]) {
		print OUTPUT "$coord1\_$coord2\n"; 
	}
	$Current++;
}
