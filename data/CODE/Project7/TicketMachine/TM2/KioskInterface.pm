# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;
use TicketKiosk;

class KioskInterface 1.0 {
	lexical_has age => (is => 'rw', isa => 'Int', accessor => \(my $age), required => 0);
	lexical_has price => (is => 'rw', isa => 'Int', accessor => \(my $price), required => 0);

	method dispatch() {
		$self->setAge();
		$self->setPrice();
		my $kiosk = TicketKiosk->new();
		$kiosk->dispatch($self->$price);
		$kiosk->printWelcome();
		while ($kiosk->getTotal() < $kiosk->getPrice()) {
               $kiosk->insertMoney();
               $kiosk->printRunningTotal();
          }
          $kiosk->printTicket();
          if ($kiosk->getBalance() > 0) {
               $kiosk->refundBalance();
          }
	}

	method setAge() {
		$self->$age(-1);
		while ($self->$age < 0 || $self->$age > 200 || $self->$age !~ /[0-9]/) {
			print "Please enter your age: ";
			chomp (my $statedAge = <STDIN>);
			$self->$age($statedAge);
			if ($self->$age < 0 || $self->$age > 200 || $self->$age !~ /[0-9]/) {
				system ("cls");
				print "\nIncorrect age, please try again.\n";
				sleep 1;
			}
		}
	}

	method setPrice() {
		use constant YOUNG_OLD_PRICE => 50;
		use constant REGULAR_PRICE => 100;
		use constant YOUNG_AGE => 10;
		use constant OLD_AGE => 62;
		if ($self->$age <= YOUNG_AGE || $self->$age >= OLD_AGE) {
			$self->$price(YOUNG_OLD_PRICE);
		} else {
			$self->$price(REGULAR_PRICE);
		}
	}
}
