#########################################################################################################################################################
## This is really just the generic extract_isolate_data.pl but with the added practicality of using it for all the work that was involved in the ms_flyway paper of 08-11. Some minor
## modifications to make it easier for putting into other files for downstream analysis.
#########################################################################################################################################################

## Just remember to rename the file extracted_data.txt when the program is complete!

use strict;
use warnings;

my $OUTPUT_FILE; # The extracted_data file that will contain the column data for the isolates you requested with their associated metadata
my $match1; # The variable that saves the id value for the first time through the new Isolates list
my $match2; # The variable that must match the Isolates id value in $match 1... this value is obtained from the Database file
my $line; # This value is assigned to hold the line data from the database file
my @isolate; # The array that holds the values of the isolate line from the database after it is split into an array.

open (ISOEXTRACT, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/PB1_08-11/PB1_names_to_extract.txt")|| die "cannot open file";

open (DATABASE, "Tony/Influenza_Genomics/JCVI_OSU_Sequencing_07_18_2013.txt")||die "cannot open file";

open ($OUTPUT_FILE, ">" . "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/PB1_08-11/PB1_names.txt" || die "cannot open");

while (<ISOEXTRACT>){  # You are entering into the list of isolates that you want data for.
	$_ =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # This is the key... this regex captures the "_XXXX" year and takes 8 values in front of it.
	$match1 = $1; # Assign the capture so that it is saved through the next while loop
	$_ =~ /(\A)/; # This is to reset the capture variable.. because $1 will be maintained through the next while loop until a successful match is formed.
	
	open (DATABASE, "Tony/Influenza_Genomics/JCVI_OSU_Sequencing_07_18_2013.txt")||die "cannot open file"; # I don't know why but you need to open the file everytime
		
	while (<DATABASE>){  # Now you enter into the mainframe of the database line by line... this is the most important file to keep up to date.
		$line = $_;  # Assigning the entire line to the $line varible
		@isolate = split(/\t/, $_); # Putting the specific line of the database (i.e. one isolate record) into an array
		$line = /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # same capture idea as above except $1 is empty before entering the loop
		my $match2 = $1; # Each time you capture the new $match2 variable is assigned
		
		if ($match1 eq $match2){ # Testing whether the text id values saved for each isolate record are equal
			print $OUTPUT_FILE "$isolate[0]\t$isolate[1]\t$isolate[6]\t$isolate[4]\n";	 # If they are then go ahead and print the cell value of the array in question.
		# If not go to the next isolate record (i.e. line) of the database.
		}
	}
}
#End of File