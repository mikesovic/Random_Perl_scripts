#This file was originally intended to take a list of isolates that you need to gather data from and return data for each (e.g. data, sex, age, etc.) from
# a database that you maintain... originally this was only done on the sequenced isolate database.

#Just remember to rename the file extracted_data.txt when the program is complete

use strict;
use warnings;

my $OUTPUT_FILE; # The extracted_data file that will contain the column data for the isolates you requested
my $match1; # The variable that saves the id value for the first time through the new Isolates list
my $match2; # The variable that must match the Isolates id value in $match 1... this value is obtained from the Database file
my $line; # This value is assigned to hold the line data from the database file
my @isolate; # The array that holds the values of the isolate line from the database after it is split into an array.

open (ISOEXTRACT, "perl_scripts/trimmedfile.txt")|| die "cannot open file";

open (DATABASE, "Tony/Influenza Genomics/JCVI_OSU_Sequencing_02_08_2013.txt")||die "cannot open file";

open ($OUTPUT_FILE, ">" . "extracted_iso_dataT15.txt" || die "cannot open");

while (<ISOEXTRACT>){  # You are entering into the list of isolates that you want data for.
	$_ =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # This is the key... this regex captures the "_XXXX" year and takes 8 values in front of it.
	$match1 = $1; # Assign the capture so that it is saved through the next while loop
	$_ =~ /(\A)/; # This is to reset the capture variable.. because $1 will be maintained through the next while loop until a successful match is formed.
	
	open (DATABASE, "Tony/Influenza Genomics/JCVI_OSU_Sequencing_02_08_2013.txt")||die "cannot open file"; # I don't know why but you need to open the file everytime
		
	while (<DATABASE>){  # Now you enter into the mainframe of the database line by line... this is the most important file to keep up to date.
		$line = $_;  # Assigning the entire line to the $line varible
		@isolate = split(/\t/, $_); # Putting the specific line of the database (i.e. one isolate record) into an array
		$line = /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # same capture idea as above except $1 is empty before entering the loop
		my $match2 = $1; # Each time you capture the new $match2 variable is assigned
		
		if ($match1 eq $match2){ # Testing whether the text id values saved for each isolate record are equal
			print $OUTPUT_FILE "$isolate[0]\t$isolate[8]\t$isolate[9]\n";	 # If they are then go ahead and print the cell value of the array in question.
		# If not go to the next isolate record (i.e. line) of the database.
		}
	}
}
#End of File