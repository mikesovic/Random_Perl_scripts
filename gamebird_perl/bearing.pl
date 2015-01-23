##REMEMBER TO ELIMINATE HEADERS FROM THE FILE AND MAKE SURE THAT THERE ARE NO UNPOPULATED CELLS!!


use strict;
use warnings;
use Geo::Ellipsoid;

open (COORD, "encounters_mall_all_1986.txt") || die "cannot open file";


my $geo = Geo::Ellipsoid->new(
	ellipsoid => 'WGS84',
	units => 'degrees',
	distance_units => 'meter',
	longitude => 0,
	bearing => 0,
);

my $OUTPUT_FILE;
my @bearing;
my $bearing;

while (<COORD>) {
	$_ =~ m/(^\S\d+\.\d+)\s+(\S\d+\.\d+)\s+(\S\d+\.\d+)\s+(\S\d+\.\d+)/;
	$bearing = $geo->bearing ($1, $2, $3, $4);
	push @bearing, $bearing;
}

open ($OUTPUT_FILE, ">" . "encounters_mall_all_1986_bearing.txt" || die "cannot open");

foreach my $bear (@bearing) {
	print $OUTPUT_FILE "$bear\n";
	
}


close COORD;