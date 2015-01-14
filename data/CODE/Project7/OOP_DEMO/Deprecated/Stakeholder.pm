# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;
use Security;

class Stakeholder 1.0 with Security {
     lexical_has lastName => (is => 'rw', isa => Str, accessor => \(my $lastName), required => 0);
     lexical_has firstName => (is => 'rw', isa => Str, accessor => \(my $firstName), required => 0);

     method getLastName() {
          return $self->$lastName;
     }

     method getFirstName() {
          return $self->$firstName;
     }

     method printStakeholder() {
          print "Last Name: " . $self->$lastName . "\n";
          print "First Name: " . $self->$firstName . "\n";
          print "Valid person: " . $self->isValid . "\n";
     }
}
