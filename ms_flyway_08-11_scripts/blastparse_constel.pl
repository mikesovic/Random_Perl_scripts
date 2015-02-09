# Involved in the blastparse_miss -> blastparse_parsetime -> distance -> blastparse_constel -> blastparse_constel_meta -> elim_dupl_comparisons sequence of scripts
# associate with similarity comparisons of AIV in a region - NOTE: Several intermediate editing steps to files must be conducted prior to each script.
##############################################################################################################################################
## This script is time consuming. The input should be a TAB DELIMITED txt file that contains a combined observation of several gene flow events by segment that 
## should have been taken from the geneflowfinal (from blastparse_parsetime after distance.pl) for each segment and concatenated into new file. So you could 
## have isolate 1 sharing some 99% similarity with isolate 2 for PB1. They may also share for MP. This file goes through the list of all observations and counts how many
## times two isolates share a segment.  Two outputs will result: 1. An output file constgeneflow_events where it lists every single event but trims out data that we don't need
## from the geneflowfinal file; 2. An output file with the unique comparison of isolate1 and isolate2 and the number of times you see that comparison made at the similarity level
## that you picked.
##############################################################################################################################################

use strict;
use warnings;

my $line;
my @record;
my $match1;
my $match2;
my $iso1;
my $iso2;
my $OUTPUT1;
my $OUTPUT2;
my %myhash;

open (CONSTRESULTS, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_99/ALL_99_results.txt")||die "cannot open file";
open ($OUTPUT1, ">" . "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_99/ALL_99_constgeneflow_events.txt")||die "cannot open file";
open ($OUTPUT2, ">" . "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_99/ALL_99_constgeneflow_events_counted.txt")||die "cannot open file";

####################################################################################################################################################
while (<CONSTRESULTS>){ # Entering into the concatenated file with all segment similarity events that occur between all isolates.
	
	$line = $_; #grab the first line of similarity results
	@record = split(/\t/, $_); # parse the first line into an array by tab delimiter
	$match1 = $record[2]; # assign first isolate name to variable... element [0] and [1] should be the states of the first and second isolate in this file
	$match2 = $record[8]; # assign second isolate name to variable
	$match1 =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # Capture the unique id
	$iso1 = $1; # assign the unique id
	$match2 =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # Capture the 2nd unique id
	$iso2 = $1; # assign the 2nd unique id
	$match2 =~ /(\A)/; # Clear the capture variable
	$myhash {$iso1}{$iso2}++; # Put the unique id into a key and value pair and count the number of times this is occuring (i.e. the ++ symbol).
	
	print $OUTPUT1 "$record[0]\t$record[1]\t$iso1\t$iso2\t$record[14]\t$record[15]\t$record[16]"; # Print the relevant metadata that we are interested in
}

close $OUTPUT1; # Close both of these files 
close CONSTRESULTS;

######################################################################################################################################################
## This block will now make the other file that just has all the unique comparisons and the number of times they occur.
######################################################################################################################################################
while ( my ($key, $value) = each (%myhash)){ 
	while (my  ($field2, $count) = each (%$value)){
		print $OUTPUT2 "$key\t$field2\t$count\n";
	}
}
close $OUTPUT2;