## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

package ATM;

use 5.14.3;
use warnings;
use MooseX::Declare;
use Savings;
use Checking;

class UserInterface {
     has 'cardNumber' => (is => 'ro', isa => 'Int', required => 1);
     has 'accountInfo' => (traits => ['Array'], is => 'rw', isa => 'ArrayRef', default => sub { [] }, handles => { pushing => 'push', erase => 'clear' }, required => 0);
     has 'currentAccounts' => (traits => ['Array'], is => 'rw', isa => 'ArrayRef', default => sub { [] }, handles => { pushing2 => 'push', erase2 => 'clear' }, required => 0);
     has 'attempts' => (is => 'rw', isa => 'Int', required => 0, default => 0);
     has 'MAXATTEMPTS' => (is => 'ro', isa => 'Int', required => 1, default => 3);
     has 'isValidated' => (is => 'rw', isa => 'Int', required => 0, default => 0);
     has 'numAccounts' => (is => 'rw', isa => 'Int', required => 0, default => 0);

     method main() {
          $self->setAccountData();
          $self->readPin();
          $self->setNumAccounts();
          $self->displayMenu();
     }

     method setAccountData() {
          my @accountsInfo = ();
          my $counter = 0;
          my $createdAccount = 0;
          my $startData = 'DataFile.csv';
          my $tempData = 'DataTemp.csv';
          open (my $DATAIN, '<', $startData) || die "\n\n\tCAN'T OPEN DATA FILE";
          while ($accountsInfo[$counter] = <$DATAIN>) {
               chomp $accountsInfo[$counter];
               if ($accountsInfo[$counter] =~ m/^@{[$self->cardNumber()]}/) {  ## http://stackoverflow.com/questions/15665821/how-do-i-use-a-moose-type-as-a-regex-match-expression/15666412?noredirect=1#15666412
                    $createdAccount = 1;
                    $self->pushing(split(/,/, $accountsInfo[$counter]));
                    pop @accountsInfo;
                    $self->invokeAccount();
               }
               $counter++;
          }
          close ($DATAIN);
          open(my $DATATEMP, '>', $tempData) || die "\n\n\tCAN'T OPEN DATA FILE";
          for (@accountsInfo) {
               if (defined $_) {
                    print $DATATEMP $_ . "\n";
               }
          }
          close ($DATATEMP);
          unlink $startData;
          rename $tempData, $startData;
          if (! $createdAccount) {
               system("cls");
               die "\n\tACCOUNT DOES NOT EXIST, GOODBYE.\n\n";
          }
          return;
     }

     method invokeAccount() {
          use constant SAVINGS => 0;
          use constant CHECKING => 1;
          if ($self->accountInfo->[5] == SAVINGS) {
               $self->pushing2(Savings->new(accountNumber => $self->accountInfo->[6], accountPin => $self->accountInfo->[1], lastName => $self->accountInfo->[2], firstName => $self->accountInfo->[3], balance => $self->accountInfo->[4], accountType => "SAVINGS"));
          } else {
               $self->pushing2(Checking->new(accountNumber => $self->accountInfo->[6], accountPin => $self->accountInfo->[1], lastName => $self->accountInfo->[2], firstName => $self->accountInfo->[3], balance => $self->accountInfo->[4], accountType => "CHECKING"));
          }
          $self->erase();
          return;
     }

     method setNumAccounts() {
          my $size = scalar @{ $self->currentAccounts() };
          $self->numAccounts($size);
          print "\n\n\t" . $self->numAccounts() . "\n";
          sleep 3;
     }
     
     method readPin() {
          use constant VIMETHOD2 => 2;
          my $pin = 0;
          system("cls");
          print "\n\tPlease enter PIN: ";
          chomp ($pin = <STDIN>);
          $self->validateInput(VIMETHOD2, $pin);
          return;
     }

     method displayMenu() {
          use constant VIMETHOD0 => 0;
          my $choice = 0;
          system("cls");
          my $counter;
          print "\n\t1) Balance Inquiry\n";
          print "\t2) Make a deposit\n";
          print "\t3) Make a withdrawal\n";
          if ($self->currentAccounts->[1]) {
               print "\t4) Transfer Funds\n";
          }
          print "\t0) Exit\n";
          print "\n\t\tCHOOSE: ";
          chomp ($choice = <STDIN>);
          $self->validateInput(VIMETHOD0, $choice);
          $self->executeChoice($choice);
          return;
     }

     method executeChoice(Int $choice) {
          use constant VIMETHOD1 => 1;
          my $accountType = 0;
          system("cls");
          if ($self->numAccounts() > 1 && $choice < 4) {
               print "\n\n\tWhich account?\n";
               print "\t0) Savings\n";
               print "\t1) Checking\n";
               print "\n\t\tCHOOSE: ";
               chomp ($accountType = <STDIN>);
               $self->validateInput(VIMETHOD1, $accountType);
          }
          if ($choice == 1) {
               $self->currentAccounts->[$accountType]->performBalanceInquiry();
               $self->displayMenu();
          } elsif ($choice == 2) {
               my $depositAmount = 0;
               system("cls");
               print "\n\nEnter deposit amount: ";
               chomp ($depositAmount = <STDIN>);
               $self->currentAccounts->[$accountType]->makeDeposit($depositAmount);
               $self->displayMenu();
          } elsif ($choice == 3) {
               my $withdrawalAmount = 0;
               system("cls");
               print "\n\nEnter withdrawl amount: ";
               chomp ($withdrawalAmount = <STDIN>);
               $self->currentAccounts->[$accountType]->makeWithdrawal($withdrawalAmount);
               $self->displayMenu();
          } elsif ($choice == 4) {
               my $transferAmount = 0;
               system("cls");
               print "\n\n\tTransfer FROM which account?\n";
               print "\t0) Savings\n";
               print "\t1) Checking\n";
               print "\n\t\tCHOOSE: ";
               chomp ($accountType = <STDIN>);
               $self->validateInput(VIMETHOD1, $accountType);
               print "\n\nEnter transfer amount: ";
               chomp ($transferAmount = <STDIN>);
               $self->currentAccounts->[$accountType]->makeWithdrawal($transferAmount);
               if ($self->currentAccounts->[$accountType]->insufficientFunds() == 0) {
                    if ($accountType == 1) {
                         $self->currentAccounts->[0]->makeDeposit($transferAmount);
                    } else {
                         $self->currentAccounts->[1]->makeDeposit($transferAmount);
                    }
               }
               $self->displayMenu();
          } elsif ($choice == 0) {
               $self->saveData();
               system("cls");
               die "\n\tGoodbye!\n";
          }
          return;
     }
     
     method saveData() {
          open (my $DATAOUT, '>>', 'DataFile.csv') || die "\n\n\tCAN'T OPEN DATA FILE";
          if ($self->currentAccounts->[1]) {
               print $DATAOUT $self->cardNumber() . "," . $self->currentAccounts->[1]->accountPin() . "," . $self->currentAccounts->[1]->lastName() . "," . $self->currentAccounts->[1]->firstName() . "," . $self->currentAccounts->[1]->balance . ",1," . $self->currentAccounts->[1]->accountNumber . "\n";
          }
          print $DATAOUT $self->cardNumber() . "," . $self->currentAccounts->[0]->accountPin() . "," . $self->currentAccounts->[0]->lastName() . "," . $self->currentAccounts->[0]->firstName() . "," . $self->currentAccounts->[0]->balance . ",0," . $self->currentAccounts->[0]->accountNumber;
          close ($DATAOUT);
          return;
     }
     
     method validateInput(Int $methodTag, Int $item) {
          use constant DISPLAYMENU => 0;
          use constant EXECUTECHOICE => 1;
          use constant READPIN => 2;
          while ($self->attempts() < $self->MAXATTEMPTS() && $self->isValidated() == 0) {
               if ($methodTag == DISPLAYMENU) {
                    if (! $self->currentAccounts->[1] && $item > 3) {
                         $self->attempts($self->attempts() + 1);
                         $self->displayMenu();
                    } elsif ($item > 3) {
                         $self->attempts($self->attempts() + 1);
                         $self->displayMenu();
                    } else {
                         $self->attempts(0);
                         $self->isValidated(1);
                    }
               } elsif ($methodTag == EXECUTECHOICE) {
                    if ($item > 1) {
                         $self->attempts($self->attempts() + 1);
                         $self->displayMenu();
                    } else {
                         $self->attempts(0);
                         $self->isValidated(1);
                    }
               } elsif ($methodTag == READPIN) {
                    if ($item != $self->currentAccounts->[0]->accountPin()) {
                         $self->attempts($self->attempts() + 1);
                         print "\n\n\t$item IS INCORRECT, TRY AGAIN.\n\n";
                         sleep 2;
                         $self->readPin();
                    } else {
                         $self->attempts(0);
                         $self->isValidated(1);
                    }
               }
          }
          if ($self->attempts() >= $self->MAXATTEMPTS()) {
               system("cls");
               $self->saveData();
               die "\n\n\t\tTOO MANY WRONG CHOICES, GOODBYE\n";
          }         
          return;
     }
}