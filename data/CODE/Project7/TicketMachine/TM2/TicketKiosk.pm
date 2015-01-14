# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;

class TicketKiosk 1.0 {
     lexical_has price => (is => 'rw', isa => 'Int', accessor => \(my $price), required => 0);
     lexical_has balance => (is => 'rw', isa => 'Int', accessor => \(my $balance), required => 0, default => 0);
     lexical_has total => (is => 'rw', isa => 'Int', accessor => \(my $total), required => 0, default => 0);

     method dispatch(Int $passedPrice) {
          $self->$price($passedPrice);
     }

     method printWelcome() {
          system("cls");
          my $hereDoc = <<"END";
          ###########################################################
                         MOOSE Line Ticket Machine
               Tickets cost \$1.00 if you are between 11 & 61
                         Otherwise ticket cost: \$0.50
                         Please insert cash, thank you
          ###########################################################
END
          print $hereDoc;
     }

     method printTicket() {
          system("cls");
          say "\n\n###############################";
          say " This is your ticket to ride";
          say "     The MOOSE Line!";
          say "###############################";
     }

     method getBalance() {
          return $self->$balance;
     }

     method getTotal() {
          return $self->$total;
     }

     method getPrice() {
          return $self->$price;
     }

     method refundBalance() {
          say "Your change: ", $self->$balance;
     }

     method printRunningTotal() {
          print "\nYour current balance is: ", $self->$total(), "\n";
          sleep 1;
     }

     method insertMoney() {
          print "\n\nHow much money do you want to insert? ";
          chomp (my $valueInserted = <STDIN>);
          $self->$total($self->$total + $valueInserted);
          if ($self->$total > $self->$price) {
               $self->$balance($self->$total - $self->$price);
          }
     }
}
