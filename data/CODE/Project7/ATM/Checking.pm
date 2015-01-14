## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

use 5.14.3;
use Moops;
use Account;

class Checking 1.0 with Account 1.0 {
	lexical_has serviceFee => (is => 'rw', isa => Int, accessor => \(my $serviceFee));

	method dispatch(Int $acctNum,Int $pin,Str $lastName,Str $firstName,Int $balance,Str $type) {
		$self->setAccountNum($acctNum);
		$self->setAccountPin($pin);
		$self->setLastName($lastName);
		$self->setFirstName($firstName);
		$self->setBalance($balance);
		$self->setAccountType($type);
		return;
	}

	method setServiceFee(Int $fee) {
		$self->$serviceFee($fee);
	}

	method getServiceFee() {
		return $self->$serviceFee;
	}
}
