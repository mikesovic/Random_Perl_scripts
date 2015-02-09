use strict;
use warnings;

my $OUTPUT1;

open (MATRIX, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/RAxML_Topologies/ns_mat.txt")|| die "cannot open file";
open ($OUTPUT1, ">" . "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/RAxML_Topologies/patristic_distances_ns_mat.txt" || die "cannot open");

my $counter = 0;
my @isolates = [];
my @distances = [];
my @comparisons = [];

while(<MATRIX>) {
	chomp;
	if ($counter == 0) {
		@isolates = split(/\t/,$_);
	}
	if ($counter > 1) {
		@distances = split(/\t/,$_);
		my $cell = $counter-2;
		for my $i (0..$cell) {
			push (@comparisons, "$distances[$i]\t$isolates[$i]\t$isolates[$counter-1]\n")
		}
	}
	$counter++;
}	

print $OUTPUT1 "@comparisons";	
close $OUTPUT1;

my $OUTPUT2;

open (PATRISTIC, "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/RAxML_Topologies/patristic_distances_ns_mat.txt" || die "cannot open");
open (DATABASE, "Tony/Influenza_Genomics/JCVI_OSU_Sequencing_12_12_2013.txt")||die "cannot open file"; # open up the database of isolates
open ($OUTPUT2, ">", "Tony/Influenza_Genomics/OSU_Surveillance_Analysis/RAxML_Topologies/patristic_distances_meta_ns_mat.txt")||die "cannot open file"; # open up a new output file

my $line;
my $isolate1;
my $isolate2;
my $sort1;
my $sort2;
my $timematch1;
my $timematch2;
my $isoline;
my @isolatedb;


while (<PATRISTIC>) {
		chomp;
		my @sorted;
		my @sorted2 = [];
		my @timestoget = [];
		$line = $_; # assign the first line
		@timestoget = split(/\t/, $_); # split the line into an array by tab delimiter
		$isolate1 = $timestoget[1]; # the 2nd element should be the first isolate
		$isolate1 =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # match the id of the isolate
		$sort1 = $1; # assign the id of the isolate
		$isolate2 = $timestoget[2]; # the 3rd element should be the second isolate
		$isolate2 =~ /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # match the id of the isolate
		$sort2 = $1; # assign the id of this isolate
		push (@sorted, "$sort1","$sort2");
		@sorted2 = sort @sorted;
		$isolate2 =~ /(A)/;
		$isolate1 =~ /(A)/;
		$timematch1 = $sorted2[0];
		$timematch2 = $sorted2[1];
		if ($timematch1 =~ /Ohio_239_1986/ | $timematch2 =~ /Ohio_239_1986/) {
			next;
		}
		if ($timematch1 =~ /Ohio_175_1986/ | $timematch2 =~ /Ohio_175_1986/) {
			next;
		}
		if ($timematch1 =~ /_9411697_1996/ | $timematch2 =~ /_9411697_1996/) {
			next;
		}
		if ($timematch1 =~ /land_252_2001/ | $timematch2 =~ /land_252_2001/) {
			next;
		}	
		if ($timematch1 =~ /_Bay_135_1996/ | $timematch2 =~ /_Bay_135_1996/) {
			next;
		}
		if ($timematch1 =~ /s_421716_2001/ | $timematch2 =~ /s_421716_2001/) {
			next;
		}
		if ($timematch1 =~ /Ohio_156_1990/ | $timematch2 =~ /Ohio_156_1990/) {
			next;
		}
		if ($timematch1 =~ /Ohio_195_1990/ | $timematch2 =~ /Ohio_195_1990/) {
			next;
		}
		if ($timematch1 =~ /a_463993_2006/ | $timematch2 =~ /a_463993_2006/) {
			next;
		}
		if ($timematch1 =~ /4242-271_2006/ | $timematch2 =~ /4242-271_2006/) {
			next;
		}		
		open (DATABASE, "Tony/Influenza_Genomics/JCVI_OSU_Sequencing_12_12_2013.txt")||die "cannot open file"; # open up the database of isolates
		
		while (<DATABASE>){  # Now you enter into the mainframe of the database line by line... this is the most important file to keep up to date.
			chomp;
			$isoline = $_;  # Assigning the entire line to the $isoline varible
			@isolatedb = split(/\t/, $_); # Putting the specific line of the database (i.e. one isolate record) into an array
			$isoline = /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # same capture idea as above except $1 is empty before entering the loop
			my $timematch3 = $1; # assign the id of the isolate from the line of the database
			
			if ($timematch1 eq $timematch3){ # if they match each other
				print $OUTPUT2 "$timestoget[0]\t$isolatedb[0]\t$isolatedb[8]\t$isolatedb[9]\t$isolatedb[10]\t$isolatedb[4]\t$isolatedb[6]\t"; #then print to the new output file
				last;
			}
		}	
		
		open (DATABASE, "Tony/Influenza_Genomics/JCVI_OSU_Sequencing_12_12_2013.txt")||die "cannot open file"; # open up the database of isolates
		
		while (<DATABASE>){  # Now you enter into the mainframe of the database line by line... this is the most important file to keep up to date.
			chomp;
			$isoline = $_;  # Assigning the entire line to the $line varible
			@isolatedb = split(/\t/, $_); # Putting the specific line of the database (i.e. one isolate record) into an array
			$isoline = /(\S{8}_[1:2][9][0-9][0-9]|\S{8}_[2][0][0-9][0-9])/; # same capture idea as above except $1 is empty before entering the loop
			my $timematch3 = $1; # assign the id of the isolate from the line of the database

			if ($timematch2 eq $timematch3){ #if they match each other 
				print $OUTPUT2 "$isolatedb[0]\t$isolatedb[8]\t$isolatedb[9]\t$isolatedb[10]\t$isolatedb[4]\t$isolatedb[6]\t$timematch1$timematch2\n"; # then print
				last;
			}
		}
}

