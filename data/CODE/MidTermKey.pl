## Assignment: Project Four - Multi-dimensional arrays & sorting
## Author: Howard Bates (hbates@northmen.org)
## Version: 02.28.2013.01
## Purpose: Multi-dimensional array & sorting example

use 5.14.2;
use warnings;

my (@arrayNumbers,@names);
my ($numNumbers,$continue,$counter);
use constant YES => 1;

sub main {
	setContinue();
	setCounter();
	while ($continue == YES) {
		setNumNumbers();
		populateArrayNumbers();
		populateNames();
		printNames();
		sortArrayNumbersBubble();
		sortArrayNumbersInsertion();
		printArrayNumbers();
		setContinue();
	}
}

main();

sub setCounter {
	if (!( defined $counter)) {
		$counter = 0;
	} else {
		$counter++;
	}
}

sub setContinue {
     if (!(defined $continue)) {
          $continue = 1;
     } else {
          print "\n\nDo you want to continue (0=no, 1=yes)? ";
          chomp ($continue = <STDIN>);
     }
}

sub setNumNumbers {
	print "\n\nHow many numbers are you entering (no more than ten)? ";
	chomp ($numNumbers = <STDIN>);
	validateInput();
}

sub populateArrayNumbers {
	@arrayNumbers = ();
	for (my $i = 0; $i < $numNumbers; $i++) {
		print "\nPlease enter a number: ";
		chomp ($arrayNumbers[$i] = <STDIN>);
	}
}

sub populateNames {
	@names = ();
	for (my $i = 0; $i < $numNumbers; $i++) {
		print "\nPlease enter a first name: ";
		chomp ($names[$i][0] = <STDIN>);
		print "\nPlease enter a last name: ";
		chomp ($names[$i][1] = <STDIN>);
	}
}

sub printNames {
	use constant COLUMNS => 2;
	my $size = @names;
	for (my $i = 0; $i < $size; $i++) {
		print "\n";
		for (my $j = 0; $j < COLUMNS; $j++) {
			print "$names[$i][$j] ";
		}
		print "\n";
	}
}

sub sortArrayNumbersBubble {
	my $index = 0;
	my $didSwap = 1;
	my $temp = 0;
	my $size = @arrayNumbers;
	while ($didSwap == 1) {
		$index = 0;
		$didSwap = 0;
		while ($index < $size) {
			if ($arrayNumbers[$index] > $arrayNumbers[$index + 1]) {
				$temp = $arrayNumbers[$index];
				$arrayNumbers[$index] = $arrayNumbers[$index + 1];
				$arrayNumbers[$index + 1] = $temp;
				$didSwap = 1;
			}
			$index++;
		}
	}
}

sub sortArrayNumbersInsertion {
	my $x = 1;
	my $size = @arrayNumbers;
	while ($x < $size) {
		my $temp = $arrayNumbers[$x];
		my $y = $x - 1;
		while ($y >= 0 && $arrayNumbers[$y] > $temp) {
			$y = $y - 1; # or $y--;
		}
		$arrayNumbers[$y + 1] = $temp;
		$x++;
	}
}

sub printArrayNumbers {
	foreach my $item (@arrayNumbers) {
		print "$item\n";
	}
}

sub validateInput {
	my $MIN_NUMBERS = 1;
	my $MAX_NUMBERS = 10;
	my $MAX_VALIDATE = 5;
	setCounter();
	if ($counter <= $MAX_VALIDATE) {
		if ($numNumbers < $MIN_NUMBERS || $numNumbers > $MAX_NUMBERS) {
			print "\nYou must enter a number between 1 and 10. Try again\n";
			sleep 1;
			setNumNumbers();
		}
	} else {
		system ("cls");
		die "\n\n\tToo many attempts, goodbye.\n";
	}
	$counter = 0;
}
