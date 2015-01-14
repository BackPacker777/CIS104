## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

use 5.14.3;
use Moops;

role Account 1.0 {
	lexical_has 'accountNum' => (is => 'ro', isa => Int, accessor => \(my $accountNum));
	lexical_has 'accountPin' => (is => 'ro', isa => Int, accessor => \(my $accountPin));
	lexical_has 'lastName' => (is => 'ro', isa => Str, accessor => \(my $lastName));
	lexical_has 'firstName' => (is => 'ro', isa => Str, accessor => \(my $firstName));
	lexical_has 'balance' => (is => 'rw', isa => Int, accessor => \(my $balance));
	lexical_has 'accountType' => (is => 'ro', isa => Str, accessor => \(my $accountType));

	method setAccountNum(Int $num) {
		$self->$accountNum($num);
	}

	method getAccountNum() {
		return $self->$accountNum;
	}

	method setAccountPin(Int $num) {
		$self->$accountPin($num);
	}

	method getAccountPin() {
		return $self->$accountPin;
	}

	method setLastName(Str $name) {
		$self->$lastName($name);
	}

	method getLastName() {
		return $self->$lastName;
	}

	method setFirstName(Str $name) {
		$self->$firstName($name);
	}

	method getFirstName() {
		return $self->$firstName;
	}

	method setBalance(Int $num) {
		$self->$balance($num);
	}

	method getBalance() {
		return $self->$balance;
	}

	method setAccountType(Str $type) {
		$self->$accountType($type);
	}

	method getAccountType() {
		return $self->$accountType;
	}
}
return 1;
