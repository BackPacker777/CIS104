## AUTHOR: hbates@northmen.org
## CREATED: 01.16.2013
## VERSION: 01.16.2013.01
## PURPOSE: Key for final exam

use 5.14.2;
use warnings;
no warnings 'uninitialized';

my @customerData;
my $IN;  #File handler
my $MINCHARGE = 200; # Psudeo constant
my $PINE = 1;
my $OAK = 2;
my $MAHOGANY = 3;
my $PROFIT = .4;
my ($customerReceipt, $totalCash, $income, $totalPineSupply, $totalMahoganySupply, $totalOakSupply); # Multi-variable declaration

sub main { # Dispatch method
    system("cls");
    parseCustomerDataFile();
    closeDataFile();
    printSupplies();
    printTotalCash();
    calculateIncome();
    printIncome();
}

main();

sub parseCustomerDataFile {
    my $customerDataFile = $ARGV[0];
    open ($IN, '<', $customerDataFile); # Read file data IN
    while (<$IN>) {
        @customerData = split(/,/);
        $customerReceipt = calculateReciept(); # Variable initialized to method return value
        $totalCash = $totalCash + $customerReceipt;
        printCustomerReciept($customerDataFile); # Pass a parameter
        calculateSupplies();
    }
}

sub closeDataFile {
    close $IN;
}

sub calculateReciept {
    my $OAKCOST = 125;
    my $MAHOGANYCOST = 150;
    my $DRAWERCOST = 30;
    my $LARGESIZE = 750;
    my $SIZECOST = 50;
    my $customerCost = $MINCHARGE;
    if ($customerData[2] == $OAK) {
        $customerCost = $customerCost + $OAKCOST;
    } elsif ($customerData[2] == $MAHOGANY) {
        $customerCost = $customerCost + $MAHOGANYCOST;
    }
    if ($customerData[5] > 0) {
        $customerCost = $customerCost + ($customerData[5] * $DRAWERCOST);
    }
    if (($customerData[3] * $customerData[4]) > $LARGESIZE) {
        $customerCost = $customerCost + $SIZECOST;
    }
    return $customerCost; # Initializes variable above
}

sub printCustomerReciept {
    my $dataFile = $_[0]; # Unpack parameter
    print "Last name: " . $customerData[0] . " \nFirst name: " . $customerData[1] . " \nTotal cost: " . $customerReceipt . "\n";
    print "Data gathered from file: " . $dataFile . "\n\n";
}

sub printTotalCash {
    print "\n\tTotal Cash: " . $totalCash . "\n\n";
}

sub calculateSupplies {
    my $DRAWERWOOD = 3;
    my $woodType = $customerData[2];
    if ($woodType == $PINE) {
        $totalPineSupply = $totalPineSupply + (($customerData[3] * $customerData[4]) + ($DRAWERWOOD * $customerData[5]));
    } elsif ($woodType == $MAHOGANY) {
        $totalMahoganySupply = $totalMahoganySupply + (($customerData[3] * $customerData[4]) + ($DRAWERWOOD * $customerData[5]));
    } else {
        $totalOakSupply = $totalOakSupply + (($customerData[3] * $customerData[4]) + ($DRAWERWOOD * $customerData[5]));
    }
}

sub printSupplies {
    print "\nSupplies needed:\n";
    print "Pine: " . $totalPineSupply . " square feet\n";
    print "Oak: " . $totalOakSupply . " square feet\n";
    print "Mahogany: " . $totalMahoganySupply . " square feet\n";
}

sub calculateIncome {
    $income = ($totalCash * $PROFIT);
}

sub printIncome {
    print "\n\tIncome: " . $income . "\n";
}