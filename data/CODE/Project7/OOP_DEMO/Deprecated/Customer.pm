# AUTHOR: hbates@northmen.org
# VERSION: 11.25.2013.01
# PURPOSE: Demonstrate PooP
# ASSIGNMENT: Perl OOP (PooP)

use 5.14.3;
use Moops;
use Stakeholder;

class Customer 1.0 extends Stakeholder 1.0 {
     has customerNum => (is => 'rw', isa => Int, required => 1);
     has salesValue => (is => 'rw', isa => Int, required => 1);

     method dispatch() {
          $self->printCustomer();
     }

     method printCustomer() {
          $self->printStakeholder();
          print "Sales Value: " . $self->salesValue() . "\n";
          print "Customer Number: " . $self->customerNum() . "\n";
     }
}
