## Assignment: Project One, Question 3, pg. 14 Part A
## Author: Howard Bates (hbates@northmen.org)
## Version: 05.08.2012.01
## Purpose: Code formatting example

use 5.14.1;
use warnings;

my ($lastName, $firstName);
my $age;
use constant LANGUAGE => "English";

sub main {
    setLastName();
    setFirstName();
    determineAge();
    printResults();
}

main();

sub setLastName {
    print "\n\nWhat is your last name? ";
    chomp ($lastName = <STDIN>);
}

sub setFirstName {
    print "What is your first name? ";
    chomp ($firstName = <STDIN>);
}

sub determineAge {
    use constant CURRENTYEAR => 2015;
    my $year;
    print "\n\nWhat year were you born? ";
    chomp ($year = <STDIN>);
    $age = CURRENTYEAR - $year;
}

sub printResults {
    system("cls");
    print "\n\nHello $firstName $lastName. You are $age years old.\n";
    print "Your primary language is " . LANGUAGE . ".\n";
    sleep 2;
}
