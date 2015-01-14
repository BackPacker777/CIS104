# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;
use Stakeholder;

class Customer 1.0 extends Stakeholder 1.0 {
     lexical_has salesValue => (is => 'rw', isa => Int, accessor => \(my $salesValue), required => 0);

     method dispatch() {
          $self->setIdNum(8888);
          print "\nAutomatically entered ID: " . $self->getIdNum() . "\n";
          $self->setIdNum();
          print "\nManually entered ID: " . $self->getIdNum() . "\n";
          $self->setSalesValue();
          $self->setLastName();
          $self->setFirstName();
          $self->setIsValid();
     }

     method setSalesValue() {
          print "Please enter customer sales value: ";
          chomp (my $input = <STDIN>);
          $self->$salesValue($input);
     }

     method getSalesValue() {
          return $self->$salesValue;
     }

     method processPayment(Int $value) { ## OVERRIDES Stakeholder processPayment method
          print "\tRecieving \$$value from Customer!\n";
     }

     method printData() {
          $self->printStakeholder();
          print "Sales Value: " . $self->$salesValue . "\n";
          $self->processPayment(2000);
          print "\tIf this were an employee....\n";
          $self->SUPER::processPayment(999); ## Call to parent processPayment method
     }
}
