## Assignment: File I/O
## Version: 03.11.2013.01
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To demonstrate File I/O, split, & MD arrays

use 5.14.2;
use warnings;

my @data;
use constant DATAFILEIN => "./dataX.csv";
use constant DATAFILEOUT => "./data2.csv";
use constant COLUMNS => 6;

sub main {
	readData();
	printData();
	writeData();
}

main();

sub readData {
	my $IN;
	my $counter = 0;
	my @tempData = ();
	@data = ();
	open ($IN, '<', DATAFILEIN);
	while (<$IN>) {
		@tempData = split(/,/);
		for (my $i = 0; $i < COLUMNS; $i++) {
			chomp ($data[$counter][$i] = $tempData[$i]);
		}
		$counter++;
	}
	close $IN;
}

sub printData {
	my $size = @data;
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			print "$data[$i][$j] ";
		}
		print "\n";
	}
}

sub writeData {
	my $OUT;
	my $size = @data;
	open ($OUT, '>', DATAFILEOUT);
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			if ($j == COLUMNS - 1) {
				print ($OUT "$data[$i][$j]");
			} else {
				print ($OUT "$data[$i][$j],");
			}
		}
		print ($OUT "\n");
	}
	close $OUT;
}








