## Assignment: Chapter 6.09a
## Author: Howard Bates (hbates@northmen.org)
## Version: 10.04.2013.01
## Purpose: Countrywide Tours

use 5.14.1;
use warnings;

use constant YES => 1;
my (@tourNum, @month, @day, @year, @numTravelers, @destCode); ## Arrays
my ($continue, $continueValidated, $tourNumValidated, $monthValidated, $dayValidated, $yearValidated, $numTravelersValidated, $destCodeValidated); ## Boolean
my ($counter, $numValidations, $grossPrice, $discountedPrice); ## Integers

sub main {
     system ("cls");
     setCounter();
     setContinue();
     setNumValidations();
     initializeValidations();
     while ($continue == YES) {
          setTourNum();
          setMonth();
          setDay();
          setYear();
          setNumTravelers();
          setDestCode();
          setGrossPrice();
          setDiscountedPrice();
          printResults();
          setContinue();
          setCounter();
     }
}

main();

sub setCounter {
	if (!(defined $counter)) {
		$counter = 0;
	} else {
		$counter++;
	}
}

sub setContinue {
	if (!(defined $continue)) {
		$continue = 1;
	} else {
		print "\nDo you want to continue? (0=no, 1=yes): ";
		chomp ($continue = <STDIN>);
          $continueValidated = 0;
          validateInput();
	}
}

sub initializeValidations {
     $continueValidated = 1;
     $tourNumValidated = 1;
     $monthValidated = 1;
     $dayValidated = 1;
     $yearValidated = 1;
     $numTravelersValidated = 1;
     $destCodeValidated = 1;
}

sub setNumValidations {
	if (!(defined $numValidations)) {
		$numValidations = 0;
	} else {
		$numValidations++;
	}
}

sub setTourNum {
     print "\nPlease enter a 3-digit tour number: ";
     chomp ($tourNum[$counter] = <STDIN>);
	$tourNumValidated = 0;
     validateInput();
}

sub setMonth {
     print "\nPlease enter a month (1-12): ";
     chomp ($month[$counter] = <STDIN>);
	$monthValidated = 0;
     validateInput();
}

sub setDay {
     print "\nPlease enter a day (1-31): ";
     chomp ($day[$counter] = <STDIN>);
	$dayValidated = 0;
     validateInput();
}

sub setYear {
	$year[$counter] = 0;
	while ($year[$counter] < 2014 || $year[$counter] > 2018) {
		print "\nPlease enter a year (2014-2018): ";
		chomp ($year[$counter] = <STDIN>);
		if ($year[$counter] < 2014 || $year[$counter] > 2018) {
			print "BAD USER: YOU DO NOT KNOW HOW TO ENTER DATA. TRY AGAIN!\n";
			sleep 2;
			system("cls");
		}
	}
}

sub setNumTravelers {
     print "\nPlease enter the number of travelers (1-110): ";
     chomp ($numTravelers[$counter] = <STDIN>);
	$numTravelersValidated = 0;
     validateInput();
}

sub setDestCode {
     print "\nPlease enter the destinaton code as follows:\n";
	print "\t\t1 = Chicago\n";
	print "\t\t2 = Boston\n";
	print "\t\t3 = Miami\n";
	print "\t\t4 = San Francisco\n";
	print "\tCode: ";
     chomp ($destCode[$counter] = <STDIN>);
	$destCodeValidated = 0;
     validateInput();
}

sub setGrossPrice {
     use constant CHICAGO => 1;
     use constant BOSTON => 2;
     use constant MIAMI => 3;
     use constant CHICAGO_PRICE => 300;
     use constant BOSTON_PRICE => 480;
     use constant MIAMI_PRICE => 1050;
     use constant SANFRAN_PRICE => 1300;
     if (!(defined $grossPrice)) {
          $grossPrice = 0;
     }
     if ($destCode[$counter] == CHICAGO) {
          $grossPrice = CHICAGO_PRICE * $numTravelers[$counter];
     } elsif ($destCode[$counter] == BOSTON) {
          $grossPrice = BOSTON_PRICE * $numTravelers[$counter];
     } elsif ($destCode[$counter] == MIAMI) {
          $grossPrice = MIAMI_PRICE * $numTravelers[$counter];
     } else {
          $grossPrice = SANFRAN_PRICE * $numTravelers[$counter];
     }
}

sub setDiscountedPrice {
     use constant MIN_TOURISTS => 5;
     use constant MED_LOW_TOURISTS => 12;
     use constant MED_HIGH_TOURISTS => 20;
     use constant HIGH_TOURISTS => 50;
     use constant MED_LOW_TOURISTS_DISCOUNT => 75;
     use constant MED_HIGH_TOURISTS_DISCOUNT => 125;
     use constant HIGH_TOURISTS_DISCOUNT => 200;
     use constant MAX_TOURISTS_DISCOUNT => 300;
     if ($numTravelers[$counter] > 0 && $numTravelers[$counter] <= MIN_TOURISTS) {
          $discountedPrice = $grossPrice;
     } elsif ($numTravelers[$counter] <= MED_LOW_TOURISTS) {
          $discountedPrice = $grossPrice - ($numTravelers[$counter] * MED_LOW_TOURISTS_DISCOUNT);
     } elsif ($numTravelers[$counter] <= MED_HIGH_TOURISTS) {
          $discountedPrice = $grossPrice - ($numTravelers[$counter] * MED_HIGH_TOURISTS_DISCOUNT);
     } elsif ($numTravelers[$counter] <= HIGH_TOURISTS) {
          $discountedPrice = $grossPrice - ($numTravelers[$counter] * HIGH_TOURISTS_DISCOUNT);
     } else {
          $discountedPrice = $grossPrice - ($numTravelers[$counter] * MAX_TOURISTS_DISCOUNT);
     }
}

sub printResults {
     system ("cls");
     print "\t\tTOUR NUMBER...........: $tourNum[$counter]\n";
     print "\n\t\tTOUR DATE.............: $month[$counter]/$day[$counter]/$year[$counter]\n";
     print "\n\t\tNUMBER OF TRAVELERS...: $numTravelers[$counter]\n";
     print "\n\t\tGROSS TOTAL PRICE.....: \$$grossPrice\n";
     print "\n\t\tTOTAL DISCOUNTED PRICE: \$$discountedPrice\n";
}

sub validateInput {
     use constant MAX_VALIDATE => 5;
	setNumValidations();
     if ($numValidations >= MAX_VALIDATE) {
          system ("cls");
		die "\n\n\t\t\aToo many BAD attempts, goodbye.\n\n\n\n\n";
     } else {
		if ($continueValidated == 0) {
               if ($continue != 0 && $continue != 1 && $numValidations) {
                    print "\nYou must enter a 1 or 0. Try again.\n";
                    sleep 1;
                    setContinue();
               }
		} elsif ($tourNumValidated == 0) {
			use constant MIN_TOUR_NUM => 100;
			use constant MAX_TOUR_NUM => 999;
			if ($tourNum[$counter] < MIN_TOUR_NUM || $tourNum[$counter] > MAX_TOUR_NUM) {
				print "\nYou must enter a 3-digit number. Try again.\n";
				sleep 1;
				setTourNum();
			}
          } elsif ($monthValidated == 0) {
			use constant MIN_MONTH => 1;
			use constant MAX_MONTH => 12;
			if ($month[$counter] < MIN_MONTH || $month[$counter] > MAX_MONTH) {
				print "\nYou must enter a month between 1-12. Try again.";
				sleep 1;
				setMonth();
			}
		} elsif ($dayValidated == 0) {
			use constant MIN_DAY => 1;
			use constant MAX_DAY => 31;
			if ($day[$counter] < MIN_DAY || $day[$counter] > MAX_DAY) {
				print "\nYou must enter a day between 1-31. Try again.\n";
				sleep 1;
				setDay();
			}
		} elsif ($yearValidated == 0) {
			my $isValid = 0;
			my @ALLOWED_YEARS = (2014, 2015, 2016, 2017, 2018);
			for (my $i = 0; $i < @ALLOWED_YEARS; $i++) {
				if ($year[$counter] == $ALLOWED_YEARS[$i]) {
					$isValid = YES;
				}
			}
			if ($isValid != YES) {
				print "\nYou must enter a valid year (2014-2018). Try again.";
				sleep 1;
				setYear();
			}
		} elsif ($numTravelersValidated == 0) {
			use constant MIN_TRAVELERS => 1;
			use constant MAX_TRAVELERS => 110;
			if ($numTravelers[$counter] < MIN_TRAVELERS || $numTravelers[$counter] > MAX_TRAVELERS) {
				print "\nYou must enter a number of travelers (1-110). Try again.";
				sleep 1;
				setNumTravelers();
			}
		} elsif ($destCodeValidated == 0) {
			use constant MIN_CODE => 1;
			use constant MAX_CODE => 4;
			if ($destCode[$counter] < MIN_CODE || $destCode[$counter] > MAX_CODE) {
				print "\nYou must enter a valid code (1-4). Try again.";
				sleep 1;
				setDestCode();
			}
		}
          initializeValidations();
		$numValidations = 0;
	}
}
