## Assignment: File I/O
## Version: 03.11.2013.01
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To demonstrate File I/O

use 5.14.2;
use warnings;

my @data;
use constant DATAFILEIN => "./data.csv";
use constant DATAFILEOUT => "./data1.csv";

sub main {
	readData();
	modifyData();
	printData();
	writeData();
}

main();

sub readData {
	my $IN;
	@data = ();
	my $counter = 0;
	open ($IN, '<', DATAFILEIN);
	while (<$IN>) {
		chomp ($data[$counter] = $_);
		$counter++;
	}
	close $IN;
}

sub modifyData {
	my $size = @data;
	for (my $i = 0; $i < $size; $i++) {
		$data[$i] = "$data[$i], AWESOME!";
	}
}

sub printData {
	my $size = @data;
	for (my $i = 0; $i < $size; $i++) {
		print "\t$data[$i]\n";
	}
}

sub writeData {
	my $OUT;
	my $counter = 0;
	open ($OUT, '>', DATAFILEOUT);
	foreach (@data) {
		print ($OUT "$_\n");
	}
	close $OUT;
}
























