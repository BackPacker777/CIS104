## Assignment:
## Author: Howard Bates (hbates@northmen.org)
## Version: 00.00.2013.01
## Purpose:

use 5.16.1;
use warnings;

my ($continueInt, $userInput, $finalValue, $counter);

sub main {
     use constant YES => 1;
     use constant MAX_RECURSION => 10;
     system("cls");
     setCounter();
     setContinueInt();
     if ($continueInt == YES) {
          if ($counter < MAX_RECURSION) {
               setUserInput();
               setFinalValue();
               system("cls");
               printFinalValue();
               main();
          }
     }
}

main();

sub setCounter {
     if (!( defined $counter)) {
          $counter = 0;
     } else {
          #$counter++;
          $counter = $counter + 1;
     }
     print "\n\t\t\tCOUNTER: $counter\n";
}

sub setContinueInt {
     if (!(defined $continueInt)) {
          $continueInt = 1;
     } else {
          print "\n\nDo you want to continue (0=no, 1=yes)? ";
          chomp ($continueInt = <STDIN>);
     }
}

sub setUserInput {
     print "\n\nWhat is the integer? ";
     chomp ($userInput = <STDIN>);
}

sub setFinalValue {
     use constant MIN_RANGE => 10;
     use constant MAX_RANGE => 20;
     use constant ADD_MIN => 100;
     use constant ADD_MAX => 500;
     use constant ADD_TURBO => 10000;
     if ($userInput > 0 && $userInput <= MIN_RANGE) {
          $finalValue = $userInput + ADD_MIN;
     } elsif ($userInput > MIN_RANGE && $userInput <= MAX_RANGE) {
          $finalValue = $userInput + ADD_MAX;
     } else {
          $finalValue = $userInput + ADD_TURBO;
     }
}

sub printFinalValue {
     print "\n\n\tYour final value is: $finalValue \n\n";
     sleep 1;
}























