# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;
use Stakeholder;

class Employee 1.0 extends Stakeholder 1.0 {
     lexical_has socialSecNum => (is => 'rw', isa => Int, accessor => \(my $socialSecNum), required => 0);

     method dispatch() {
          $self->setIdNum();
          $self->setSocialSecNum();
          $self->setLastName();
          $self->setFirstName();
          $self->setIsValid();
     }

     method setSocialSecNum() {
          print "Please enter social security number: ";
          chomp (my $input = <STDIN>);
          $self->$socialSecNum($input);
     }

     method getSocialSecNum() {
          return $self->$socialSecNum;
     }

     method printData() {
          $self->printStakeholder();
          print "Social Security Number: " . $self->$socialSecNum . "\n";
          $self->processPayment(1000);
     }
}
