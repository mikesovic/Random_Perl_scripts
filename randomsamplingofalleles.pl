#!usr/bin/perl

#frequencies - you can change starting allele frequencies to anything you want
$p=0.5;
$q=0.5;
#2N population - you can change pop size to anything you want
$N = 10;
#alleles
$pG=($p*$N);
$qG=($q*$N);
print "starting allele frequencies are p:$p and q:$q\n";
print "population size is $N\n";

#my @simulation = ();
#1000 simulations if you want to run it many times
#for ($j=0; $j<1000; $j++) { 

$notdone = 1; #while loop exit
$generations = 0; #count number of generations	

while ($notdone) {

	$generations +=1;
	$pcount =0; #produce new frequency

for ($i=0; $i<$N; $i++) {
	$x = rand $N;
#print "x is $x\n";
#x are random draws from population
	 
	if ($x < $pG) {
		$pcount +=1;
	}#end if
}#end i for loop

#print "pcount: $pcount\n";

	if ($pcount == 0) {
	$notdone = 0; #ends while loop q is fixed
	}
	elsif ($pcount == $N) {
	$notdone = 0; #ends while loop p is fixed
	}
	else {$pG = $pcount;}
	
$pnew = $pcount/$N;
print "new p is $pnew at generation $generations\n";

}#end while	loop

#if ($pcount == 0) {$pfixed +=1;}

#push (@simulation, $generations);

#}#end j 1000 for loop


#print "p is fixed $pfixed times\n";

#print "@simulation\n";

#$total = 0;
#$total+=$_ for @simulation;
#$average = $total/1000;
#print "average time to fixation = $average\n"; 

#$above = 0;
#$below = 0;
#for ($k=0; $k<1000; $k++) { #get count above and below average
#if ($simulation[$k] > $average) {$above +=1;}
#else {$below +=1;}}

#@simulation = sort {$a <=> $b} (@simulation);
#print "@simulation\n";
#print "minimum = @simulation[0]\n";
#print "maximum = @simulation[999]\n";

#print "number above average = $above\n";
#print "number below average = $below\n";


