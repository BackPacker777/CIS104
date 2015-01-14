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
     lexical_has idNum => (is => 'rw', isa => Int, accessor => \(my $idNum), required => 0);

     multi method setIdNum() { ## Method overloading
          print "Please enter ID number: ";
          chomp (my $input = <STDIN>);
          $self->$idNum($input);
     }

     multi method setIdNum(Int $num) { ## Method overloading
          $self->$idNum($num);
     }
	 
     method getIdNum() {
          return $self->$idNum;
     }

     method setLastName() {
          print "Please enter last name: ";
          chomp (my $input = <STDIN>);
          $self->$lastName($input);
     }

     method getLastName() {
          return $self->$lastName;
     }

     method setFirstName() {
          print "Please enter first name: ";
          chomp (my $input = <STDIN>);
          $self->$firstName($input);
     }

     method getFirstName() {
          return $self->$firstName;
     }

     method processPayment(Int $value) {
          print "\tPaying \$$value to Employee!\n";
     }

     method printStakeholder() {
          print "ID Number: " . $self->getIdNum . "\n";
          print "Last Name: " . $self->getLastName . "\n";
          print "First Name: " . $self->getFirstName . "\n";
          print "Valid person: " . $self->getIsValid . "\n";
     }
}
