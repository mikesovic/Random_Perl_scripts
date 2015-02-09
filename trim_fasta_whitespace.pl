##########################################################################################################################################
## Generic script that will trim any whitespace from a title in a fasta file. 

use strict;
use warnings;

my $OUTPUT_FILE;


print "What is the name of the file you would like to trim whitespace from:";
my $fasta = <STDIN>;
 
open (FASTACONV, "$fasta")|| die "cannot open file";
open ($OUTPUT_FILE, ">" . "nowstitles.txt" || die "cannot open");

while (<FASTACONV>){
	chomp;
	$_ =~ s/Influenza A virus/Influenza_A_virus/g;
	$_ =~ s/[\s]/_/g;
	print $OUTPUT_FILE "$_\n";	
}