########################################################################################################################################
## Generic script that can be used to trim whitespace from any single file that contains strings in a column format so that you can sequence through them in a 
## WHILE loop.
########################################################################################################################################
#Just remember to rename the fasta when the program has completed in the folder. Start code now.

use strict;
use warnings;

my $OUTPUT_FILE;

print "What is the name of the file you would like to trim whitespace from:";
my $file = <STDIN>;
 
open (CONV, "$file")|| die "cannot open file";
open ($OUTPUT_FILE, ">" . "trimmedfile.txt" || die "cannot open"); # This will always need to be renamed.

while (<CONV>){ #Enter into the file with each line representing an element that you want to trim whitespace from 
	$_ =~ s/[\s]/_/g; # this regex substitutes any whitespace character (i.e. [\s]) with the underscore character.
	print $OUTPUT_FILE "$_\n";	
}