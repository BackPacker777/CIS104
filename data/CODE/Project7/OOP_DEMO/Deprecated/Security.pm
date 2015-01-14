# AUTHOR: hbates@northmen.org
# VERSION: 11.25.2013.01
# PURPOSE: Demonstrate PooP
# ASSIGNMENT: Perl OOP (PooP)

use 5.14.3;
use Moops;

role Security {
     has isValid => (is => 'rw', isa => Bool, required => 1);
}
