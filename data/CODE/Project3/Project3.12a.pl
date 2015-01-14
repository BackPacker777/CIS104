## Assignment: Project 3.12a
## Author: Howard Bates (hbates@northmen.org)
## Version: 10.01.2013.01
## Purpose: Demonstrate Chapter 5 Exercise 12 (Ellison Elementary)

use 5.14.1;
use warnings;

my ($currentMonth, $currentGrade, $currentClassroom, $upperTuition);
use constant MAX_GRADE => 8;
use constant MAX_MONTH => 9;
use constant MAX_CLASSROOM => 3;
use constant KDG_TUITION => 80;

sub main {
     system("cls");
     setCurrentMonth();
     setCurrentGrade();
     setCurrentClassroom();
     printPaymentCoupons();
     printGoodbye();
}

main();

sub setCurrentMonth {
     if (!(defined $currentMonth) || $currentMonth > MAX_MONTH) {
          $currentMonth = 1;
     } else {
          $currentMonth++;
     }
}

sub setCurrentGrade {
     if (!(defined $currentGrade) || $currentGrade > MAX_GRADE) {
          $currentGrade = 0;
     } else {
          $currentGrade++;
     }
}

sub setCurrentClassroom {
     if (!(defined $currentClassroom) || $currentClassroom > MAX_CLASSROOM) {
          $currentClassroom = 1;
     } else {
          $currentClassroom++;
     }
}

sub setUpperTuition {
     use constant BASE_TUITION => 60;
     if (!(defined $upperTuition)) {
          $upperTuition = BASE_TUITION * $currentGrade;
     } else {
          $upperTuition = BASE_TUITION * $currentGrade;
     }
}

sub printPaymentCoupons {
     while ($currentGrade <= MAX_GRADE) {
          while ($currentClassroom <= MAX_CLASSROOM) {
               while ($currentMonth <= MAX_MONTH) {
                    if ($currentGrade == 0) {
                         print "\n\tThe tuition for month: $currentMonth, for classroom: $currentClassroom, of grade: $currentGrade is: \$" . KDG_TUITION . ".\n";
                         #sleep 1;
                    } else {
                         setUpperTuition();
                         print "\n\tThe tuition for month: $currentMonth, for classroom: $currentClassroom, of grade: $currentGrade is: \$$upperTuition.\n";
                         #sleep 1;
                    }
                    setCurrentMonth();
               }
               setCurrentMonth();
               setCurrentClassroom();
          }
          setCurrentClassroom();
          setCurrentGrade();
     }
}

sub printGoodbye {
     print "\n\n\t\t\tGoodbye.\n\n";
}