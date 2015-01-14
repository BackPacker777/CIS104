# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use warnings;
use KioskInterface;

sub main {
	KioskInterface->new()->dispatch();
}

main();
