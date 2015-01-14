## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

use 5.14.3;
use Moops;
use Account;

class Savings 1.0 with Account 1.0 {
	lexical_has interest => (is => 'rw', isa => Int, accessor => \(my $interest));

	method dispatch(Int $acctNum,Int $pin,Str $lastName,Str $firstName,Int $balance,Str $type) {
		$self->setAccountNum($acctNum);
		$self->setAccountPin($pin);
		$self->setLastName($lastName);
		$self->setFirstName($firstName);
		$self->setBalance($balance);
		$self->setAccountType($type);
		return;
	}

	method setInterest(Int $amount) {
		$self->$interest($amount);
	}

	method getInterest() {
		return $self->$interest;
	}
}
