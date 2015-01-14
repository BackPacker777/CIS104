# AUTHOR: hbates@northmen.org
# VERSION: 12.10.2012.01
# PURPOSE: Answer key for Pig dice game
# ASSIGNMENT: Chapter 5 pg. 212 #18

use 5.14.1;
use warnings;

use constant PERSON => 0;
use constant BOT => 1;
use constant DIETYPE => 6;
use constant DIEQTY => 2;
use constant WINSCORE => 100;
my ($player, $continue, $turnScore, $numValidations, $isValidated);
my @scores;

sub main {
    system ("cls");
    $scores[PERSON] = 0;
    $scores[BOT] = 0;
    $turnScore = 0;
    $isValidated = 0;
    $numValidations = 0;
    setPlayer();
    while ($scores[PERSON] < WINSCORE && $scores[BOT] < WINSCORE) {
        runGame();
	   checkWin();
    }
    printWin();
}

main();

sub setPlayer {
    $player = int(rand(DIEQTY));
}

sub checkWin {
    if ($scores[PERSON] >= WINSCORE || $scores[BOT] >= WINSCORE) {
        printWin();
        die "\n\n\t--GAME OVER--";
    }
}

sub runGame {
    my $dieQty = DIEQTY;
    my $dieType = DIETYPE;
    my $roll = rollDice($dieQty, $dieType);
    printPlayerTurn();
    if ($roll == 1) {
        if ($player == PERSON) {
            $scores[PERSON] -= $turnScore;
            $turnScore = 0;
            $player = BOT;
        } else {
            $scores[BOT] -= $turnScore;
            $turnScore = 0;
            $player = PERSON;
        }
        printTurnReset();
        sleep 2;
    } elsif ($roll == 2) {
        $turnScore = 0;
        if ($player == PERSON) {
            $turnScore = 0;
            $scores[PERSON] = 0;
            $player = BOT;
        } else {
            $turnScore = 0;
            $scores[BOT] = 0;
            $player = PERSON;
        }
        printTotalReset();
        sleep 2;
    } else {
        printRoll($roll);
        $turnScore = $turnScore + $roll;
        if ($player == PERSON) {
            $scores[PERSON] = $scores[PERSON] + $roll;
        } else {
            $scores[BOT] = $scores[BOT] + $roll;
        }
        printScore();
        sleep 2;
        $player = setPlayerContinue();
    }
}

sub rollDice {
    my $dieQty = $_[0];
    my $dieType = $_[1];
    my @rolls;
    my $totalRoll = 0;
    for (my $i = 0; $i < $dieQty; $i++) {
        $rolls[$i] = int(rand($dieType)) + 1;
        $totalRoll = $totalRoll + $rolls[$i];
    }
    if ($rolls[0] == 1 || $rolls[1] == 1) {
        return 1;
    } else {
        return $totalRoll;
    }
}

sub printRoll {
    my $roll = $_[0];
    print "\nCurrent roll: " . $roll . " \n";
}

sub setPlayerContinue {
    my $continue = -1;
    if ($player == PERSON) {
	   while ($continue !~ /[0-9]/ || $continue > 1 || $continue < 0) {
		  print "\n\nDo you want to play or pass? (0=play or 1=pass): ";
		  chomp ($continue = <STDIN>);
	   }
	   if ($continue == 1) {
		  $turnScore = 0;
	   }
    } else {
        $continue = setPlayer();
        if ($continue == 0) {
            $turnScore = 0;
        }
    }
    return $continue;
}

sub printScore {
    if ($player == PERSON) {
        print "\n\tYour score for the turn: " . $turnScore . "\n";
        print "\n\tYour total score so far: " . $scores[PERSON];
    } else {
        print "\n\tComputer turn score: " . $turnScore . "\n";
        print "\n\tComputer total score so far: " . $scores[BOT];
    }
}

sub printPlayerTurn {
    if ($player == PERSON) {
        print "\n\nIt is PLAYER'S turn.\n";
    } else {
        print "\n\nIt is COMPUTER'S turn.\n";
    }
}

sub printTurnReset {
    print "\nA one was rolled on one of the dice. Turn score is zero and play passes.\n";
}

sub printTotalReset {
    print "\nSnake eyes were rolled. Total score is reset to zero and play passes.\n";
}

sub printWin {
    system ("cls");
    if ($scores[PERSON] >= WINSCORE) {
        print "\n\tYou win! Your final score: " . $scores[PERSON] . "\n\n\n";
        print "\n\tComputer final score: " . $scores[BOT] . "\n\n\n";
    } else {
        print "\n\tComputer beat you. Your final score: " . $scores[PERSON] . "\n\n\n";
        print "\n\tComputer final score: " . $scores[BOT] . "\n\n\n";
    }
}
