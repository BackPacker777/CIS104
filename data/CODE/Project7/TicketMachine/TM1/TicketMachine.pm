# AUTHOR: hbates@northmen.org
# VERSION: 03.21.2013.01
# PURPOSE: Demonstrate Perl OOP (POOP) polymorphism, instatiation, inheritance, encapsulation (PIIE)
# ASSIGNMENT: Perl OOP (POOP PIIE)

use 5.14.3;
use Moops;

class TicketMachine 1.0 {
     has price => (is => 'rw', isa => 'Int', required => 1);
     lexical_has balance => (is => 'rw', isa => 'Int', accessor => \(my $balance), required => 0, default => 0);
     lexical_has total => (is => 'rw', isa => 'Int', accessor => \(my $total), required => 0, default => 0);

     method dispatch() {
          $self->printWelcome();
          while ($self->$total < $self->price) {
               $self->insertMoney();
               $self->printRunningTotal();
          }
          $self->printTicket();
          if ($self->$balance > 0) {
               $self->refundBalance();
          }
     }

     method printWelcome() {
          system("cls");
          my $hereDoc = <<'END';
          ###########################################################
                         MOOSE Line Ticket Machine
                         Tickets cost $1.00
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

     method refundBalance() {
          say "Your change: " . $self->$balance;
     }

     method printRunningTotal() {
          print "\nYour current balance is: " . $self->$total() . "\n";
          sleep 1;
     }

     method insertMoney() {
          my $input = -1;
          while ($input < 0) {
               print "\n\nHow much money do you want to insert? ";
               chomp ($input = <STDIN>);
               if ($input < 0) {
                    print "";
               } else {
                    $self->$total($self->$total + $input);
                    if ($self->$total > $self->price) {
                         $self->$balance($self->$total - $self->price);
                    }
               }
          }
     }
}
