## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

package ATM;

use 5.14.3;
use warnings;
use MooseX::Declare;

class Savings with Account {
	has 'interest' => (is => 'rw', isa => 'Int', required => 0);
}
