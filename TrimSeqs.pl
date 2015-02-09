#! /usr/bin/perl
use warnings;
use strict;

open INFILE, "rad29_3.txt" or die$!;

open OUTFILE, ">rad29_3_Trimmed.txt" or die$!;
open OUTFILE2, ">rad29_3_Shorties.txt" or die$!;
open OUTFILE3, ">rad29_3_Longies.txt" or die$!;

my $Counter = 0;
my $size;
my @block;

while (<INFILE>)  {
	
	chomp($_);
	
	if ($Counter == 0)  {
		push @block, $_;
		# print OUTFILE "$_\n";
		$Counter++;
	}

	elsif ($Counter == 1)  {
		$size = length($_);
		push @block, $_;	
		# $_ = substr($_, 0, 75);
		# print OUTFILE "$_\n";
		$Counter++;
	}

	elsif ($Counter == 2)  {
		push @block, $_;
		# print OUTFILE "$_\n";
		$Counter++;
	}	
	
	elsif ($Counter == 3)  {
		push @block, $_;
		# $_ = substr($_, 0, 75);
		# print OUTFILE "$_\n";
		$Counter = 0;
		if ($size < 50){
			foreach my $element (@block){
				print OUTFILE2 "$element\n";
			}
		}
		elsif($size == 50){
			foreach my $element2 (@block){
				print OUTFILE "$element2\n";
			}
		}
		elsif($size > 50){
			foreach my $element3 (@block){
				print OUTFILE3 "$element3\n";
			}
		}
		@block = ();
	}
	
}
close INFILE;
close OUTFILE2;
		
		
		
		
