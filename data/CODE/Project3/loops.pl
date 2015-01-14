## Assignment: Project Three - Loops
## Author: Howard Bates (hbates@northmen.org)
## Version: 02.14.2013.01
## Purpose: Loops example

use 5.14.2;
use warnings;

my $continue;
use constant YES => 1;

sub main {
    setContinue();
    while ($continue == YES) {
        guessNum();
        countdown();
        setContinue();
    }
}

main();

sub setContinue {
    if (!(defined $continue)) {
        $continue = YES;
    } else {
        print "\n\nDo you want to continue? (0=no, 1=yes): ";
        chomp ($continue = <STDIN>);
    }
}

sub guessNum {
    use constant ANSWER => 8;
    my $guess = 0;
    while ($guess != ANSWER) {
        print "Please guess a number between 1 - 10: ";
        chomp ($guess = <STDIN>);
    }
    print "\nCorrect guess!\n";
}

sub countdown {
    use constant LIMIT => 10;
    for (my $i = 0; $i < LIMIT; $i++) {
        print "\n\tCOUNTDOWN: T-MINUS $i\n";
        sleep 1;
    }
}
