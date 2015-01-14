## Assignment: 9.18 - HANGMAN!
## Version: 10.30.2010.02
## Author: Howard Bates (hbates@northmen.org)
## Purpose: To play hangman

use 5.14.2;  ## Automatically enables 'use strict'
use warnings;

my (@gameWordArray, @wordBuild, @singleWordArray);
my $INFILE;
my ($guess, $correctGuess);
my $validated;
my ($numValidateAttempts, $guessNum, $wrongGuessNum, $gameCounter, $singleWordArrayLength, $guessCounter, $wordCounter);
use constant MAXVALIDATIONS => 5;

sub main {
	unless (@ARGV){
		system ("cls");
		die "\n\n\tUsage: hangman.pl path_to_datafile\n\n";
	}
	system ("cls");
	$validated = 0;
	$wordCounter = 0;
	$numValidateAttempts = 1;
	$guessNum = 0;
	$wrongGuessNum = 0;
	$gameCounter = 0;
	$correctGuess = 0;
	
	openDataFile();
	readDataFile();
	closeDataFile();
	
	print "\nWelcome! Here we go.\n";
	while ($gameCounter < @gameWordArray) {
		displayLogo();
		prepGame();
		while ($validated == 0 && $numValidateAttempts <= MAXVALIDATIONS) {
			while ($guessCounter < @singleWordArray) {
				setGuess();
				processGuess();
			}
		}
		$wrongGuessNum = 0;
		$guessCounter = 0;
		print "YAY! Word " . ($gameCounter + 1) . " guessed in $guessNum tries!\n";
		sleep 1;
		shift (@gameWordArray);
		system("cls");
		$guessNum = 0;
	}
	die "\n\n\tAll words guessed!\n";
}

main();

sub prepGame {
     $guessCounter = 0;
     $validated = 0;
     $wordCounter++;
	@singleWordArray = split(//, $gameWordArray[$gameCounter]);
	@wordBuild = ("_") x @singleWordArray;
	print "Guessing word $wordCounter which has " . @singleWordArray . " letters.\n\n";
	print "@wordBuild \n\n";
}

sub setGuess {
	use constant VIGUESS => 0;
	$validated = 1;
	print "Please enter your guess: ";
	chomp ($guess = <STDIN>);
	$guess  =~ tr/A-Z/a-z/;
	validateInput(VIGUESS);
}

sub processGuess {
     for (my $i = 0; $i < @wordBuild; $i++) {
          if ($wordBuild[$i] eq $guess) {
               $guessCounter--;
          }
     }
	foreach my $letter (@singleWordArray) {
		if ($letter =~ /$guess/) {
			$guessCounter++;
			$correctGuess = 1;
			for (my $i = 0; $i < @wordBuild; $i++) {
				if ($singleWordArray[$i] eq $guess) {
					$wordBuild[$i] = $guess;
				}
			}
		}
	}
	system("cls");
	processWrongGuess($wrongGuessNum);
	print "@wordBuild\n\n";
	if ($correctGuess == 0) {
		$wrongGuessNum++;
		print "WRONG!\n";
		sleep 1;
		processWrongGuess($wrongGuessNum);
		print "@wordBuild \n";
	}
	$correctGuess = 0;
	$guessNum++;
}

sub openDataFile {
	my $dataFile = $ARGV[0];
	open ($INFILE, '<', $dataFile);
}

sub readDataFile {
	while (<$INFILE>) {
		@gameWordArray = split(/, /);
	}
	chomp (@gameWordArray);
	foreach my $line (@gameWordArray) {
		$line =~ tr/A-Z/a-z/; ## Convert any uppercase letters to lowercase
	}
}

sub closeDataFile {
	close ($INFILE);
}

sub processWrongGuess {
	my $wrongGuessNumX = $_[0];
	given ($wrongGuessNumX) {
		when (0) {displayLogo()}
		when (1) {printOne()}
		when (2) {printTwo()}
		when (3) {printThree()}
		when (4) {printFour()}
		when (5) {printFive()}
		when (6) {printSix()}
		when (7) {printSeven()}
		default {warn "\n\tERROR!\n";}
	}
}

sub displayHeader {
	use constant HEADER1 =>    "\n          H A N G M A N !\n";
	use constant HEADER2 => "====================================\n\n";
	print HEADER1;
	print HEADER2;
}

sub displayLogo {
	displayHeader();
	print "  _______\n", " |/      |\n", " |\n", " |\n", " |\n", " |\n", "_|___\n\n";
}

sub printOne {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |\n", " |\n", " |\n", "_|___\n\n";
}

sub printTwo {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |       |\n", " |\n", " |\n", "_|___\n\n";
}

sub printThree {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |      /|\n", " |\n", " |\n", "_|___\n\n";
}

sub printFour {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |      /|\\\n", " |\n", " |\n", "_|___\n\n";
}

sub printFive {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |      /|\\\n", " |       |\n", " |\n", "_|___\n\n";
}

sub printSix {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |      /|\\\n", " |       |\n", " |      /\n", "_|___\n\n";
}

sub printSeven {
	system("cls");
	displayHeader();
	print "  _______\n", " |/      |\n", " |      (_)\n", " |      /|\\\n", " |       |\n", " |      / \\ \n", "_|___\n\n";
	die "\n\n** G A M E - O V E R **\n\n";
}

sub validateInput {
	## Key:
	## 0 = Guess
	## ========================

	my $methodLabel = $_[0];
	if ($numValidateAttempts > MAXVALIDATIONS) {
		system("cls");
		die "\nSorry, you have to re-start the program. Too many input errors!\n\n";
	}
	if ($methodLabel == 0) {
		my @letterArray = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');
		my $length = @letterArray;
		my $isMatched = 0;
		for (my $i = 0; $i < $length; $i++) {
			if ($guess eq $letterArray[$i]) {
				$isMatched = 1;
				last;
			}
		}
		if ($isMatched == 0) {
			system ("cls");
			print "\nYou must enter a lower case letter a - z. Please try again!\n";
			sleep 1;
			$numValidateAttempts++;
			$validated = 0;
			processWrongGuess($wrongGuessNum);
			print "@wordBuild \n\n";
			setGuess();
		} else {
			$numValidateAttempts = 1;
		}         
	}
}