# AUTHOR: hbates@northmen.org
# VERSION: 12.05.2013.01
# PURPOSE: Project 7 Solution
# ASSIGNMENT: Project 7: Chapter 11 #9, pg. 485

use 5.14.3;
use Moops;
use ShippedOrder;

class Order 2.0 with ShippedOrder 1.0 {
     has customerName => (is => 'rw', isa => Str, required => 1);
     has customerNumber => (is => 'rw', isa => Int, required => 1);
     has orderQty => (is => 'rw', isa => Int, required => 1);
     has unitPrice => (is => 'rw', isa => Int, required => 1);
     has totalPrice => (is => 'rw', isa => Int, required => 0);
     has shippedPrice => (is => 'rw', isa => Int, required => 0);

     method computePrice() {
          $self->totalPrice($self->unitPrice() * $self->orderQty());
     }

     method computeShippedPrice() {
          $self->shippedPrice($self->totalPrice() + $self->shippingHandlingCharge());
     }

     method printValues() {
          print "Customer Name: " . $self->customerName() . "\n";
          print "Customer Number: " . $self->customerNumber() . "\n";
          print "Order Quantity: " . $self->orderQty() . "\n";
          print "Unit Price: " . $self->unitPrice() . "\n";
          print "Total Price: " . $self->totalPrice() . "\n";
          print "Shipped Price: " . $self->shippedPrice() . "\n";
     }
}
