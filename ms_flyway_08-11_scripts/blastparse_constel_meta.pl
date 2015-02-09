# Involved in the blastparse_miss -> blastparse_parsetime -> distance -> blastparse_constel -> blastparse_constel_meta -> elim_dupl_comparisons sequence of scripts
# associate with similarity comparisons of AIV in a region - NOTE: Several intermediate editing steps to files must be conducted prior to each script.
##############################################################################################################################################
## This script is used combine the two files from the blastparse_constel script into one file that has all of the events coupled with the associated number of segements 
## shared between the isolates involved in the event. Takes the input from both of the files in the previous script. Simple script just adding a number to the end of the event.
## Your output will be very similar to events.txt but just with the events_counted number associated with it.
##############################################################################################################################################

use strict;
use warnings;

my $OUTPUT1;
my @record;
my @record2;
my $match1;
my $match2;
my $match3;
my $match4;
my @constellations;

open (META, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/ALL_100_constgeneflow_events_counted.txt")||die "cannot open file"; # Opens the file created with counts from the blastparse_consel.pl
open ($OUTPUT1, ">", "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/ALL_100_constgeneflow_events_PARSED.txt")||die "cannot open file"; # Create a new file with  the counts included with all of the metadata of a geneflow event

while (<META>){ # Enter into the first line of the file that contains the number of times an isolate matched another isolate for all segments ... should range from 1-8
	chomp;
	@record = split(/\t/, $_); # parse the first line into an array by tab delimiter
	$match1 = $record[0]; # assign first isolate name to variable
	$match2 = $record[1]; # assign second isolate name to variable
	
	open (ALLEVENTS, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/Blast/ALL_100/ALL_100_constgeneflow_events.txt")||die "cannot open file"; # Open the file that contains all the gene flow events and the metadata associated with that event... i.e. time, distance, segment
	
	while (<ALLEVENTS>){ # Enter into the first line of the metadata of each event 
		chomp;
		@record2 = split(/\t/, $_); # parse the first line into an array by tab delimiter
		$match3 = $record2[2]; # assign first isolate name to variable
		$match4 = $record2[3]; # assign second isolate name to variable
		
		if (($match1 eq $match3) && ($match2 eq $match4)) {
			print $OUTPUT1 "$match1\t$match2\t$record2[0]\t$record2[1]\t$record2[4]\t$record2[5]\t$record2[6]\t$match1$match2\t$record[2]\n";
		}
	}
}
close META;
close ALLEVENTS;