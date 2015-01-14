# AUTHOR:
# VERSION:
# PURPOSE:
# ASSIGNMENT:

use 5.14.2;
use warnings;
no warnings 'uninitialized';

my $NUMSUIT = 4;
my $NUMCARDS = 13;
my $SPADES = 100;
my $HEARTS = 200;
my $DIAMONDS = 300;
my $CLUBS = 400;
my @CARDDECK = ([$SPADES, $HEARTS, $DIAMONDS, $CLUBS],
                [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
                [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
                );
my @playCards;
my $card;

sub main {
    system ("cls");
    $card = drawCard();
    printCard();
}

main();

sub drawCard {
    my $cardSuit = int(rand($NUMSUIT));
    my $suitCard = int(rand($NUMCARDS));
    my $tempCard = $CARDDECK[0][$cardSuit] + $CARDDECK[1][$suitCard];
    checkDeck($tempCard);
    $playCards[$tempCard] = 1;
    return $tempCard;
}

sub checkDeck {
    my $tempCard = $_[0];
    if ($playCards[$tempCard] > 0) {
        drawCard();
    }
}

sub printCard {
    my $suit;
    my $finalCard;
    if ($card < $HEARTS) {
        $suit = 'Spades';
        if ($card < 111) {
            $finalCard = $CARDDECK[1][$card - $SPADES];
        } elsif ($card == 111) {
            $finalCard = 'Jack';
        } elsif ($card == 112) {
            $finalCard = 'Queen';
        } elsif ($card == 113) {
            $finalCard = 'King';
        } else {
            $finalCard = 'Ace';
        }
    } elsif ($card > $HEARTS && $card < $DIAMONDS) {
        $suit = 'Hearts';
        if ($card < 211) {
            $finalCard = $CARDDECK[1][$card - $HEARTS];
        } elsif ($card == 211) {
            $finalCard = 'Jack';
        } elsif ($card == 212) {
            $finalCard = 'Queen';
        } elsif ($card == 213) {
            $finalCard = 'King';
        } else {
            $finalCard = 'Ace';
        }
    } elsif ($card > $DIAMONDS && $card < $DIAMONDS) {
        $suit = 'Diamonds';
        if ($card < 311) {
            $finalCard = $CARDDECK[1][$card - 300];
        } elsif ($card == 311) {
            $finalCard = 'Jack';
        } elsif ($card == 312) {
            $finalCard = 'Queen';
        } elsif ($card == 313) {
            $finalCard = 'King';
        } else {
            $finalCard = 'Ace';
        }
    } else {
        $suit = 'Clubs';
        if ($card < 411) {
            $finalCard = $CARDDECK[1][$card - $CLUBS];
        } elsif ($card == 411) {
            $finalCard = 'Jack';
        } elsif ($card == 412) {
            $finalCard = 'Queen';
        } elsif ($card == 413) {
            $finalCard = 'King';
        } else {
            $finalCard = 'Ace';
        }
    }
    print "\n\n\tYour card: " . $finalCard . " of " . $suit . "\n";
}