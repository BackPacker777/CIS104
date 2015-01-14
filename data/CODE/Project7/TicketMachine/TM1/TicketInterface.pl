# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use warnings;
use TicketMachine;

my $age;
use constant YOUNG_OLD_PRICE => 50;
use constant REGULAR_PRICE => 100;
use constant YOUNG_AGE => 10;
use constant OLD_AGE => 62;

sub main {
	setAge();
	if ($age <= YOUNG_AGE || $age >= OLD_AGE) {
		TicketMachine->new(price => YOUNG_OLD_PRICE)->dispatch(); ## Constructor paramaters
	} else {
		TicketMachine->new(price => REGULAR_PRICE)->dispatch(); ## Constructor paramaters
	}
	return;
}

main();

sub setAge {
	$age = -1;
	while ($age < 0 || $age > 200 || $age !~ /[0-9]/) {
		print "Please enter your age: ";
		chomp ($age = <STDIN>);
		if ($age < 0 || $age > 200 || $age !~ /[0-9]/) {
			system ("cls");
			print "\nIncorrect age, please try again.\n";
			sleep 1;
		}
	}
}
