# VERSION: 12.05.2013.01
# PURPOSE: Project 7 Solution
# ASSIGNMENT: Project 7: Chapter 11 #9, pg. 485

use 5.14.3;
use Moops;

role ShippedOrder 1.0 {
     has shippingHandlingCharge => (is => 'ro', isa => Int, required => 1, default => 4);

     requires qw(computeShippedPrice);
}
