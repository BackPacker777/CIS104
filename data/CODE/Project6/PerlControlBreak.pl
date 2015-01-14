## Assignment: Control Break
## Version: 11.20.2014.02
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To demonstrate control break

use 5.14.2;
use warnings;

my (@data, @value);
use constant DATA_SUMMARY_FILE => "./dataSummary.txt";
use constant DEPT_FILE_IN => "./ControlBreakData2.csv";
use constant ID => 0;
use constant NAME => 1;
use constant VALUE => 2;
use constant POLICY_TYPE => 3;

sub main {
	readDataFile();
	sortData();
	printData();
	processReport();
}

main();

sub readDataFile {
	my $IN;
	my $counter = 0;
	my $size = 0;
	my @tempData = ();
	@data = ();
	open ($IN, '<', DEPT_FILE_IN);
	while (<$IN>) {
		@tempData = split(/,/);
		$size = @tempData;
		for (my $i = 0; $i < $size; $i++) {
			chomp ($data[$counter][$i] = $tempData[$i]);
		}
		$counter++;
	}
	close $IN;
}

sub sortData {
	my $size = @data;
	my $temp = 0;
	for (my $i = 1; $i < $size; $i++) {
		my $j = $i;
		while ($j > 0 && $data[$j][POLICY_TYPE] < $data[$j - 1][POLICY_TYPE]) {
			$temp = $data[$j][POLICY_TYPE];
			$data[$j][POLICY_TYPE] = $data[$j - 1][POLICY_TYPE];
			$data[$j - 1][POLICY_TYPE] = $temp;

			$temp = $data[$j][ID];
			$data[$j][ID] = $data[$j - 1][ID];
			$data[$j - 1][ID] = $temp;

			$temp = $data[$j][NAME];
			$data[$j][NAME] = $data[$j - 1][NAME];
			$data[$j - 1][NAME] = $temp;

			$temp = $data[$j][VALUE];
			$data[$j][VALUE] = $data[$j - 1][VALUE];
			$data[$j - 1][VALUE] = $temp;

			$j--;
		}
	}
}

sub printData {
	use constant COLUMNS => 4;
	my $size = @data;
	for (my $i = 0; $i < $size; $i++) {
		for (my $j = 0; $j < COLUMNS; $j++) {
			print "$data[$i][$j] ";
		}
		print "\n";
	}
}

sub processReport {
	use constant COLUMNS => 4;
	my $legacyPolicyType = $data[0][POLICY_TYPE];
	my $policyTypeValue = 0;
	my $HEADER =    "\n        Value by Policy Type\n";
	my $SEPERATOR = "==========================================\n\n";
	my $size = @data;
	my $OUT;
	open ($OUT, '>>', DATA_SUMMARY_FILE);
	print ($OUT $HEADER);
	print ($OUT $SEPERATOR);
	for (my $i = 0; $i < $size; $i++) {
		if ($legacyPolicyType != $data[$i][POLICY_TYPE]) {
			printSummary($policyTypeValue, $legacyPolicyType);
			$policyTypeValue = 0;
		}
		print ($OUT "$data[$i][NAME], $data[$i][VALUE]", "\n");
		$policyTypeValue = ($policyTypeValue + $data[$i][VALUE]);
		$legacyPolicyType = $data[$i][POLICY_TYPE];
	}
	printSummary($policyTypeValue, $legacyPolicyType);
	close ($OUT);
}

sub printSummary {
	my $OUT;
	my $policyTypeValueX = $_[0];
	my $legacyPolicyTypeX = $_[1];
	open ($OUT, '>>', DATA_SUMMARY_FILE);
	print ($OUT "\nTotal value for $legacyPolicyTypeX is $policyTypeValueX\n");
	print ($OUT "_________________________________________\n\n");
	close ($OUT);
}
