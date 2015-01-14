# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;
use Employee;
use Customer;

class PersonEntryInterface 1.0 {
	lexical_has personType => (is => 'rw', isa => Int, accessor => \(my $personType));
	lexical_has continueInt => (is => 'rw', isa => Int, accessor => \(my $continueInt));
	lexical_has people => (is => 'rw', isa => ArrayRef, default => sub { [] }, reader => \(my $people), lazy => 1); ## http://stackoverflow.com/questions/27277415/can-someone-please-explain-how-to-implement-and-utilize-privately-scoped-arrays/27282615#27282615

	method dispatch() {
		use constant TRUE => 1;
		my $counter = 0;
		$self->$continueInt(TRUE);
		while ($self->$continueInt == TRUE) {
			$self->setPersonType();
			$self->addPeople($counter);
			$counter++;
			system ("cls");
			$self->setContinueInt();
			system ("cls");
		}
		$self->printPeople();
	}

	method setPersonType() {
		$self->$personType(-1);
		while ($self->$personType < 0 || $self->$personType > 1 || $self->$personType !~ /[0-9]/) {
			print "Please enter person type (0=Employee, 1=Customer): ";
			chomp (my $statedPerson = <STDIN>);
			$self->$personType($statedPerson);
			if ($self->$personType < 0 || $self->$personType > 1 || $self->$personType !~ /[0-9]/) {
				system ("cls");
				print "\nIncorrect type, please try again.\n";
				sleep 1;
			}
		}
	}

	method addPeople(Int $counter) {
		if ($self->$personType == 0) {
			my $employee = Employee->new();
			$employee->dispatch();
			$self->$people->[$counter] = $employee; ## http://www.perlmonks.org/?node_id=6594
		} else {
			my $customer = Customer->new();
			$customer->dispatch();
			$self->$people->[$counter] = $customer; ## http://www.perlmonks.org/?node_id=6594
		}
	}

	method setContinueInt() {
		$self->$continueInt(-1);
		while ($self->$continueInt < 0 || $self->$continueInt > 1 || $self->$continueInt !~ /[0-9]/) {
			print "Do you want to continue? (0=No, 1=Yes): ";
			chomp (my $statedContinue = <STDIN>);
			$self->$continueInt($statedContinue);
			if ($self->$continueInt < 0 || $self->$continueInt > 1 || $self->$continueInt !~ /[0-9]/) {
				system ("cls");
				print "\nIncorrect, please try again.\n";
				sleep 1;
			}
		}
	}

	method printPeople() {
		foreach my $item (@{ $self->$people }) {
			$item->printData();
			print "\n\n";
		}
	}
}
