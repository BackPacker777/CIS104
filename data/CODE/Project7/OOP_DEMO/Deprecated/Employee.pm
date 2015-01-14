# AUTHOR: hbates@northmen.org
# VERSION: 11.25.2013.01
# PURPOSE: Demonstrate PooP
# ASSIGNMENT: Perl OOP (PooP)

use 5.14.3;
use Moops;
use Stakeholder;

class Employee 1.0 extends Stakeholder 1.0 {
     has socialSecNum => (is => 'rw', isa => Int, required => 1);
     has employeeNum => (is => 'rw', isa => Int, required => 1);

     method dispatch() {
          $self->printEmployee();
          $self->setLastName("Smith");
          print "\n\n";
          $self->printEmployee();
     }

     method printEmployee() {
          $self->printStakeholder();
          print "Social Security Number: " . $self->socialSecNum . "\n";
          print "Employee Number: " . $self->employeeNum . "\n";
     }
}
