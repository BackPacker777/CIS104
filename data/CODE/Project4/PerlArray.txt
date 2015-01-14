## Assignment: Project Four - Arrays
## Author: Howard Bates (hbates@northmen.org)
## Version: 02.21.2013.02
## Purpose: Array example

use 5.14.1;
use warnings;

my @lastNames;
my ($numNames, $continue, $counter);

sub main {
	use constant YES => 1;
	setContinue();
	setCounter();
	while ($continue == YES) {
		system("cls");
		setNumNames();
		populateLastNames();
		printLastNames();
		setContinue();
	}
}

main();

sub setContinue {
     if (defined $continue) {
		$continue = -1;
		while ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
			print "\n\nDo you want to continue (0=no, 1=yes)? ";
			chomp ($continue = <STDIN>);
			if ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
				say "Incorrect input. Please try again";
				sleep 1;
				system ("cls");
			}
		}
     } else {
          $continue = 1;
     }
}

sub setCounter {
	if (defined $counter) {
		$counter++;
	} else {
		$counter = 0;
	}
}

sub setNumNames() {
	use constant MAX_NUM => 10;
	$numNames = -1;
	while ($numNames !~ /[0-9]/ || $numNames > MAX_NUM || $numNames < 0) {
		print "\n\nHow many names are you entering (no more than ten)? ";
		chomp ($numNames = <STDIN>);
		if ($numNames !~ /[0-9]/ || $numNames > MAX_NUM || $numNames < 0) {
			say "Incorrect input. Please try again";
			sleep 1;
			system ("cls");
		}
	}
}

sub populateLastNames {
	@lastNames = ();
	for (my $i = 0; $i < $numNames; $i++) {
		print "\nPlease enter a last name: ";
		chomp ($lastNames[$i] = <STDIN>);
		if ($lastNames[$i] eq "Evans") {
			print "\n\t\a$lastNames[$i] is AWESOME!\n";
		}
	}
}

sub printOneLastName {
	my $name;
	print "\n\tPlease enter a last name to print: ";
	chomp ($name = <STDIN>);
	print "\n\t$lastNames[$name]\n";
}

sub printLastNames {
	foreach my $item (@lastNames) {
		print "\n$item\n";
	}
}

sub validateInput {
	use constant MIN_NAMES => 1;
	use constant MAX_NAMES => 10;
	use constant MAX_VALIDATE => 5;
	if ($counter <= MAX_VALIDATE) {
		if ($numNames < MIN_NAMES || $numNames > MAX_NAMES) {
			$counter++;
			print "\nYou must enter a number between 1 and 10. Try again\n";
			sleep 1;
			setNumNames();
		}
		$counter = 1;
	} else {
		system ("cls");
		die "\n\n\t\t\aToo many BAD attempts, goodbye.\n\n\n\n\n";
	}
}
