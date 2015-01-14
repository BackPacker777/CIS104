## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

use 5.14.3;
use warnings;
use UserInterface;

sub main {
     #if (! @ARGV || $ARGV[0] !~ /\b\d{7}\b/) {
     #     die "You must supply the correct card number!\n";
     #}
     #UserInterface->new()->dispatch($ARGV[0]);
     UserInterface->new()->dispatch(1230987);
}

main();
