# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;

role Security 1.0 {
     lexical_has isValid => (is => 'rw', isa => Int, accessor => \(my $isValid), required => 0);

     method setIsValid() {
          $self->$isValid(1);
     }

     method getIsValid() {
          return $self->$isValid;
     }
}
