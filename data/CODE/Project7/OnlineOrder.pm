# AUTHOR: hbates@northmen.org
# VERSION: 12.05.2013.01
# PURPOSE: Project 7 Solution
# ASSIGNMENT: Project 7: Chapter 11 #9, pg. 485

use 5.14.3;
use Moops;
use Order;

class OnlineOrder 1.0 extends Order 2.0 {
     has ipAddress => (is => 'rw', Isa => Str, required => 0);

     method dispatch() {
          $self->computePrice();
          $self->computeShippedPrice();
          $self->printIpAddress();
     }

     method printIpAddress() {
          $self->printValues();
          print "IP Address: " . $self->ipAddress() . "\n\n";
     }
}
