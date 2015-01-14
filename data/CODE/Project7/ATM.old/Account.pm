## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

package ATM;

use 5.14.3;
use warnings;
use MooseX::Declare;

role Account {
	has 'accountNumber' => (is => 'ro', isa => 'Int', required => 1);
	has 'lastName' => (is => 'ro', isa => 'Str', required => 1);
	has 'firstName' => (is => 'ro', isa => 'Str', required => 1);
	has 'accountPin' => (is => 'ro', isa => 'Int', required => 1);
	has 'balance' => (is => 'rw', isa => 'Int', required => 1);
	has 'accountType' => (is => 'ro', isa => 'Str', required => 1);
	has 'insufficientFunds' => (is => 'rw', isa => 'Int', required => 0);

	method performBalanceInquiry() {
		$self->insufficientFunds(0);
		system("cls");
		say "Current " . $self->accountType() . " account balance for " . $self->firstName() . " " . $self->lastName() . ": " . $self->balance() . "\n";
		sleep 3;
		return;
	}

	method makeDeposit(Int $amount) {
		$self->insufficientFunds(0);
		$self->balance($self->balance() + $amount);
		$self->performBalanceInquiry();
		return;
	}

	method makeWithdrawal(Int $amount) {
		if (($self->balance() - $amount) < 0) {
			$self->displayInsufficientFunds($amount);
			$self->performBalanceInquiry();
		} else {
			$self->insufficientFunds(0);
			$self->balance($self->balance() - $amount);
			$self->performBalanceInquiry();
		}
		return;
	}

	method displayInsufficientFunds() {
		$self->insufficientFunds(1);
		print "\n\tINSUFFICIENT FUNDS TO COMPLETE TRANSACTION\n";
		sleep 2;
		return;
	}
	
	method displayInsufficientFunds(Int $var) { ## Just to demonstrate method overloading
		$self->insufficientFunds(1);
		print "\n\tINSUFFICIENT FUNDS TO COMPLETE TRANSACTION\n";
		print "\n\t$var\n";
		sleep 2;
		return;
	}
}
