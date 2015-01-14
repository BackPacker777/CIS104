## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

package ATM;

use 5.14.2;
use warnings;

use UserInterface;

sub main {
     startInterface();
}

main();

sub startInterface {
     if (! @ARGV) {
          die "You must supply the correct card number!\n";
     }
     UserInterface->new(cardNumber => $ARGV[0])->main();
     return;
}
