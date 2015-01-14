## CREATED: 03.11.2013
## VERSION: 2.0
## AUTHOR: Howard Bates (hbates@northmen.org)
## Purpose: ATM OOP Solution

use 5.14.3;
use Moops;
use Savings;
use Checking;

class UserInterface 1.0 {
     lexical_has cardNum => (is => 'ro', isa => Int, accessor => \(my $cardNum));
     lexical_has pin => (is => 'ro', isa => Int, accessor => \(my $pin));
     lexical_has accountNum => (is => 'ro', isa => Int, accessor => \(my $accountNum));
     lexical_has accountType => (is => 'rw', isa => Str, accessor => \(my $accountType));
     lexical_has accountInfo => (is => 'rw', isa => ArrayRef, default => sub { [] }, reader => \(my $accountInfo), lazy => 1);
     lexical_has currentAccount => (is => 'rw', isa => HashRef, default => sub { {} }, reader => \(my $currentAccount), lazy => 1);
     lexical_has take => (is => 'rw', isa => Int, accessor => \(my $take), default => 0);

     method dispatch(Int $num) {
          $self->$cardNum($num);
          $self->setPin();
          $self->setAccountData();
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
               if ($accountsInfo[$counter] =~ m/^@{[$self->$cardNum]}/) {  ## http://stackoverflow.com/questions/15665821/how-do-i-use-a-moose-type-as-a-regex-match-expression/15666412?noredirect=1#15666412
                    $createdAccount = 1;
                    push @{ $self->$accountInfo }, split(/,/, $accountsInfo[$counter]);
                    if ($createdAccount != 1 || $self->$pin != $self->$accountInfo->[1]) {
                         system ("cls");
                         die "\n\tIncorrect PIN, goodbye.\n\n";
                    }
                    pop @accountsInfo;
                    $self->invokeAccount();
               } else {}
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
          return;
     }

     method invokeAccount() {
          use constant SAVINGS => 0;
          if ($self->$accountInfo->[5] == SAVINGS) {
               my $account = Savings->new();
               $account->dispatch($self->$accountInfo->[6],$self->$accountInfo->[1],$self->$accountInfo->[2],$self->$accountInfo->[3],$self->$accountInfo->[4],"SAVINGS");
               $self->$currentAccount->{"SAVINGS"} = $account;
               $self->$accountType("SAVINGS");
               $self->$accountNum($self->$accountInfo->[6]);
          } else {
               my $account = Checking->new();
               $account->dispatch($self->$accountInfo->[6],$self->$accountInfo->[1],$self->$accountInfo->[2],$self->$accountInfo->[3],$self->$accountInfo->[4],"CHECKING");
               $self->$currentAccount->{"CHECKING"} = $account;
               $self->$accountType("CHECKING");
               $self->$accountNum($self->$accountInfo->[6]);
          }
          @{ $self->$accountInfo } = ();
          return;
     }

     method setPin() {
          my $input = 0;
          while ($input !~ /\b\d{4}\b/) {
               system ("cls");
               print "\n\tPlease enter PIN: ";
               chomp ($input = <STDIN>);
               if ($input !~ /\b\d{4}\b/) {
                    $self->incorrectInput();
               }
          }
          $self->$pin($input);
          return;
     }

     method displayMenu() {
          my $choice = -1;
          if (keys %{ $self->$currentAccount } == 1) {
               while ($choice !~ /[0-9]/ || $choice < 0 || $choice > 3) {
                    system ("cls");
                    my $counter;
                    print "\n\t1) Balance Inquiry\n";
                    print "\t2) Make a deposit\n";
                    print "\t3) Make a withdrawal\n";
                    print "\t0) Exit\n";
                    print "\n\t\tCHOOSE: ";
                    chomp ($choice = <STDIN>);
                    if ($choice !~ /[0-9]/ || $choice < 0 || $choice > 3) {
                         $self->incorrectInput();
                    }
               }
          } else {
               while ($choice !~ /[0-9]/ || $choice < 0 || $choice > 4) {
                    system ("cls");
                    my $counter;
                    print "\n\t1) Balance Inquiry\n";
                    print "\t2) Make a deposit\n";
                    print "\t3) Make a withdrawal\n";
                    print "\t4) Transfer Funds\n";
                    print "\t0) Exit\n";
                    print "\n\t\tCHOOSE: ";
                    chomp ($choice = <STDIN>);
                    if ($choice !~ /[0-9]/ || $choice < 0 || $choice > 4) {
                         $self->incorrectInput();
                    }
               }
          }
          $self->executeChoice($choice);
          return;
     }

     method executeChoice(Int $choice) {
          system("cls");
          if ($choice == 1) {
               $self->inquireBalance();
               $self->displayMenu();
          } elsif ($choice == 2) {
               $self->performDeposit();
               $self->displayMenu();
          } elsif ($choice == 3) {
               $self->performWithdrawal();
               $self->displayMenu();
          } elsif ($choice == 4) {
               $self->performTransfer();
               $self->displayMenu();
          } elsif ($choice == 0) {
               $self->saveData();
               system("cls");
               die "\n\n\tGoodbye!\n";
          }
          return;
     }

     multi method inquireBalance() {
          system("cls");
          my $acct = $self->setAccountType();
          say "\nCurrent " . $acct . " account balance: " . $self->$currentAccount->{$acct}->getBalance() . "\n";
		sleep 2;
		return;
     }

     multi method inquireBalance(Str $acc) {
          system("cls");
          my $acct = $_[0];
          say "\nCurrent " . $acct . " account balance: " . $self->$currentAccount->{$acct}->getBalance() . "\n";
		sleep 2;
		return;
     }

     method performDeposit() {
          my $amt = 0;
          my $acct = $self->setAccountType();
          while ($amt !~ /[0-9]/ || $amt < 1) {
               print "\nHow much would you like to deposit?: ";
               chomp ($amt = <STDIN>);
               if ($amt !~ /[0-9]/ || $amt < 1) {
                    $self->incorrectInput();
               }
          }
          $self->$currentAccount->{$acct}->setBalance($self->$currentAccount->{$acct}->getBalance() + $amt);
          $self->inquireBalance($acct);
		return;
     }

     method performWithdrawal() {
          my $amt = 0;
          my $acct = $self->setAccountType();
          while ($amt !~ /[0-9]/ || $amt < 1) {
               print "\nHow much would you like to withdraw?: ";
               chomp ($amt = <STDIN>);
               if ($amt !~ /[0-9]/ || $amt < 1) {
                    $self->incorrectInput();
               }
               if ($self->$currentAccount->{$acct}->getBalance() - $amt < 0) {
                    $self->displayInsufficientFunds();
                    $amt = 0;
               }
          }
          $self->$currentAccount->{$acct}->setBalance($self->$currentAccount->{$acct}->getBalance() - $amt);
          $self->inquireBalance($acct);
		return;
     }

     method performTransfer() {
          my $amt = 0;
          $self->$take(1);
          my $acct = $self->setAccountType();
          while ($amt !~ /[0-9]/ || $amt < 1) {
               print "\nHow much would you like to transfer?: ";
               chomp ($amt = <STDIN>);
               if ($amt !~ /[0-9]/ || $amt < 1) {
                    $self->incorrectInput();
               }
               if ($self->$currentAccount->{$acct}->getBalance() - $amt < 0) {
                    $self->displayInsufficientFunds();
                    $amt = 0;
               }
          }
          $self->$currentAccount->{$acct}->setBalance($self->$currentAccount->{$acct}->getBalance() - $amt);
          if ($self->$currentAccount->{$acct}->getAccountType() eq "SAVINGS") {
               $self->$currentAccount->{"CHECKING"}->setBalance($self->$currentAccount->{"CHECKING"}->getBalance() + $amt);
          } else {
               $self->$currentAccount->{"SAVINGS"}->setBalance($self->$currentAccount->{"SAVINGS"}->getBalance() + $amt);
          }
          $self->inquireBalance("SAVINGS");
          $self->inquireBalance("CHECKING");
		return;
     }

     method setAccountType() {
          my $accType = -1;
          my $numKeys = scalar keys %{ $self->$currentAccount };
          if ($numKeys == 2) {
               while ($accType !~ /[0-9]/ || $accType < 0 || $accType > 1) {
                    if ($self->$take == 1) {
                         print "\n\n\tFrom which account?\n\n";
                    } else {
                         print "\n\n\tWhich account?\n\n";
                    }
                    print "\t0) Savings\n";
                    print "\t1) Checking\n";
                    print "\n\t\tCHOOSE: ";
                    chomp ($accType = <STDIN>);
                    if ($accType !~ /[0-9]/ || $accType < 0 || $accType > 1) {
                         $self->incorrectInput();
                    }
               }
               if ($accType == 0) {
                    $accType = "SAVINGS";
               } else {
                    $accType = "CHECKING";
               }
          } else {
               $accType = $self->$accountType;
          }
          $self->$take(0);
          return $accType;
     }

     method displayInsufficientFunds() {
		print "\n\tINSUFFICIENT FUNDS TO COMPLETE TRANSACTION\n";
		sleep 2;
		return;
	}

     method saveData() {
          my $type = -1;
          open (my $DATAOUT, '>>', 'DataFile.csv') || die "\n\n\tCAN'T OPEN DATA FILE";
          foreach (keys %{ $self->$currentAccount }) {
               if ($_ eq "SAVINGS") {
                    $type = 0;
               } else {
                    $type = 1;
               }
               print $DATAOUT ($self->$cardNum . "," . $self->$pin . "," . $self->$currentAccount->{$_}->getLastName()
                              . "," . $self->$currentAccount->{$_}->getFirstName() . "," . $self->$currentAccount->{$_}->getBalance()
                              . ",$type," . $self->$currentAccount->{$_}->getAccountNum() . "\n");
          }
          close ($DATAOUT);
          return;
     }

     method incorrectInput() {
          system ("cls");
          print "\nIncorrect input, please try again.\n";
          sleep 1;
     }
}
