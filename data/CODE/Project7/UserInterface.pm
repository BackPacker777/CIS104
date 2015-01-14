# AUTHOR: hbates@northmen.org
# VERSION: 12.05.2013.01
# PURPOSE: Project 7 Solution
# ASSIGNMENT: Project 7: Chapter 11 #9, pg. 485

use 5.14.3;
use Moops;
use OnlineOrder;

class UserInterface 1.5 {
     has continue => (is => 'rw', isa => Int, required => 0);
     has counter => (is => 'rw', isa => Int, required => 0, default => 0);
     has orders => (is =>'rw', traits => ['Array'], isa => 'ArrayRef', default => sub { [] }, handles => { pushing => 'push' }, required => 0);

     method dispatch() {
          use constant TRUE => 1;
          $self->setContinue();
          while ($self->continue() == TRUE) {
               $self->setOrderValues();
               $self->counter($self->counter() + 1);
               $self->setContinue();
          }
          $self->printOrders();
     }

     method setContinue() {
          my $answer;
          if (!(defined $self->continue())) {
               $self->continue(1);
          } else {
               system ("cls");
               print "Do you want to add another order? (0=no, 1=yes): ";
               chomp ($answer = <STDIN>);
               $self->continue($answer);
          }
     }

     method setOrderValues() {
          my @orders;
          my ($custName, $ip);
          my ($custNum, $qty, $price);
          print "\nPlease enter customer name: ";
          chomp ($custName = <STDIN>);
          print "\nPlease enter customer number: ";
          chomp ($custNum = <STDIN>);
          print "\nPlease enter order quantity: ";
          chomp ($qty = <STDIN>);
          print "\nPlease enter item price: ";
          chomp ($price = <STDIN>);
          print "\nPlease enter customer ip address: ";
          chomp ($ip = <STDIN>);
          $self->placeOrder($custName, $custNum, $qty, $price, $ip);
     }

     method placeOrder(Str $custName, Int $custNum, Int $qty, Int $price, Int $ip) {
          $self->pushing(OnlineOrder->new(customerName => $custName, customerNumber => $custNum, orderQty => $qty, unitPrice => $price, ipAddress => $ip));
     }

     method printOrders() {
          system ("cls");
          for (my $i = 0; $i < $self->counter(); $i++) {
               $self->orders()->[$i]->dispatch();
          }
     }
}
