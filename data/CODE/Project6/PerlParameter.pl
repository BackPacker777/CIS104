## Assignment: Parameters
## Version: 03.20.2013.01
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To demonstrate Parameters & Validation

use 5.14.2;
use warnings;

my ($continueInt, $counter, $numValidateTries, $age, $validated, @ages);
my (@lastNames, @firstNames, $lastName, $firstName);
use constant MINAGE => 10;
use constant MAXAGE => 120;
use constant MAXVALIDATIONS => 5;

sub main() {
	$counter = 0;
	$validated = 0;
	$numValidateTries = 1;
	system("cls");
	printWelcome();
	while ($validated == 0 && $numValidateTries <= MAXVALIDATIONS) {
		setContinueInt();
	}
	while ($continueInt == 1) {
		$validated = 0;
		$numValidateTries = 1;
		while ($validated == 0 && $numValidateTries <= MAXVALIDATIONS) {
			setLastNames();
		}
		$validated = 0;
		$numValidateTries = 1;
		while ($validated == 0 && $numValidateTries <= MAXVALIDATIONS) {
			setFirstNames();
		}
		$validated = 0;
		$numValidateTries = 1;
		while ($validated == 0 && $numValidateTries <= MAXVALIDATIONS) {
			setAges();
		}
		$validated = 0;
		$numValidateTries = 1;
		setCounter();
		while ($validated == 0 && $numValidateTries <= MAXVALIDATIONS) {
			setContinueInt();
		}
		$validated = 0;
		$numValidateTries = 1;
		system("cls");
	}
	printData();
}

main();

sub printWelcome() {
	print "\nWELCOME TO OUR PROGRAM!\n";
	print "=======================\n\n";
}

sub setContinueInt() {
	use constant VICONTINUEINT => 0;
	$validated = 1;
	if (!(defined $continueInt)) {
		$continueInt = 1;
	} else {
		print "\nDo you want to enter data? (y or n): ";
		chomp($continueInt =  <STDIN>);
		$continueInt = substr($continueInt, 0, 1);
		$continueInt =~ (tr/A-Z/a-z/);
		validateInput(VICONTINUEINT);
		if ( $continueInt =~ m/y/ ) {
			$continueInt =~ (s/y/1/);
		} else {
			$continueInt =~ (s/n/0/);
		}
	}
}

sub setLastNames() {
	use constant VILASTNAMES => 1;
	$validated = 1;
	print "\nPlease enter last name: ";
	chomp($lastName = <STDIN>);
	$lastName = substr($lastName, 0, 20);
	validateInput(VILASTNAMES);
	unshift(@lastNames,$lastName);
}

sub setFirstNames() {
	use constant VIFIRSTNAMES => 2;
	$validated = 1;
	print "\nPlease enter first name: ";
	chomp($firstName = <STDIN>);
	$firstName = substr($firstName, 0, 20);
	validateInput(VIFIRSTNAMES);
	unshift(@firstNames,$firstName);
}

sub setAges() {
	use constant VIAGES => 3;
	$validated = 1;
	print "\nPlease enter age (10 - 120): ";
	chomp($age = <STDIN>);
	validateInput(VIAGES);
	unshift(@ages,$age);
}

sub setCounter() {
	$counter = $counter + 1;
}

sub printData() {
	for (my $i = 0; $i < $counter; $i++) {
		print "\n$firstNames[$i] $lastNames[$i], age: $ages[$i]\n";
	}
}

sub validateInput() {
	#  Key is as follows:
	#  0 = continueString
	#  1 = lastNames
	#  2 = firstNames
	#  3 = ages
	my $value = $_[0];
	if ($numValidateTries > MAXVALIDATIONS) {
		die "Sorry, you have to re-start the program. Too many input errors!";
	}
	if ($value == 0) {
		if ($continueInt !~ m/y/ && $continueInt !~ m/n/) {
			print "Please enter y or n ";
			$validated = 0;
			$numValidateTries++;
			setContinueInt();
		} else {
			$numValidateTries = 1;
		}
	} elsif ($value == 1) {
		if ($lastName =~ m/\W/ || $lastName =~ m/\d/) {
			print "Please enter a PROPER last name ";
			$validated = 0;
			$numValidateTries++;
			setLastNames();
		} else {
			$numValidateTries = 1;
		}
	} elsif ($value == 2) {
		if ($firstName =~ m/\W/ || $firstName =~ m/\d/) {
			print "Please enter a PROPER first name ";
			$validated = 0;
			$numValidateTries++;
			setFirstNames();
		} else {
			$numValidateTries = 1;
		}
	} else {
		if ($age =~ m/\D/ || $age < MINAGE || $age > MAXAGE ) {
			print "Please enter correct age (10 - 120): ";
			$validated = 0;
			$numValidateTries++;
			setAges();
		} else {
			$numValidateTries = 1;
		}
	}
}
