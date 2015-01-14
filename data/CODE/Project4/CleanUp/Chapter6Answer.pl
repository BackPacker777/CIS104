## Assignment: 6.1
## Author: Howard Bates (hbates@northmen.org)
## Version: 10.17.2011.01
## Purpose: Answer key for lab 6

use 5.14.1;
use warnings;

my @classrooms;
my @scores;
use constant MAXROOM => 2;
use constant MAXSTUDENTS => 35;

sub main() {
	system ("cls");
	setStudents();
	setScores();
	printScores();
}

main();

sub setStudents() {
	my $student;
	use constant MINROOM_STUDENT => 1;
	for (my $i = 0; $i < MAXROOM; $i++) {
		print "How many students in classroom " . ($i + 1) . ": ";
		chomp ($student = <STDIN>);
		if ($student < MINROOM_STUDENT || $student > MAXSTUDENTS) {
			print "Invalid number! You must enter a number between " . MINROOM_STUDENT . "& " . MAXSTUDENTS . ". Please try again.\n";
			sleep 1;
			$i--;
		} else {
			$classrooms[$i] = $student;
		}
		system ("cls");
	}
}

sub setScores() {
	use constant MINSCORE => 0;
	use constant MAXSCORE => 100;
	my $score;
	my $roomNumber = 0;
	my $scoreNumber = 0;
	while ($roomNumber < MAXROOM) {
		for (my $i = 0; $i < $classrooms[$roomNumber]; $i++) {
			print "What is the test score for student " . ($i + 1) . " in classrom " . ($roomNumber + 1) . ": ";
			chomp ($score = <STDIN>);
			if ($score < MINSCORE || $score > MAXSCORE) {
				print "Invalid number! You must enter a number between " . MINSCORE . "& " . MAXSCORE . ". Please try again.\n";
				sleep 1;
				$i--;
			} else {
				$scores[$scoreNumber] = $score;
				$scoreNumber++;
			}
			system ("cls");
		}
		$roomNumber++;
	}
}

sub printScores() {
	system ("cls");
	my $totalScore = 0;
	my $rangeMin = 0;
	my $rangeMax = 0;
	my $roomNumber = 0;
	while ($roomNumber < MAXROOM) {
		$rangeMax = $rangeMax + $classrooms[$roomNumber];
		for (my $i = 0; $i < $classrooms[$roomNumber]; $i++) {
			while ($rangeMin < $rangeMax) {
				$totalScore = $totalScore + $scores[$rangeMin];
				$rangeMin++;
			}
			$rangeMin = $rangeMax;
		}
		print "\n\tTotal score for classroom " . ($roomNumber + 1) . ": $totalScore\n";
		$roomNumber++;
		$totalScore = 0;
	}
}