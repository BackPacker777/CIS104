## Assignment: 6.8
## Author: Howard Bates (hbates@northmen.org)
## Version: 10.18.2011.01
## Purpose: Answer key for lab 6-8

#use 5.14.1;
use warnings;
use autodie;

my $counter;
my $continue;
my $grossPay;
my $netPay;
my $tax;
my $totalHours;
my $totalGrossPay;
my $totalWithholding;
my $totalNetPay;
my @employeeData;

sub main() {
	$counter = 0;
	$continue = 1;
	$totalHours = 0;
	$totalGrossPay = 0;
	$totalWithholding = 0;
	$totalNetPay = 0;
	@employeeData = ([],[],[]);
	while ($continue != 0) {
		system ("cls");
		setEmployeeName();
		setEmployeeWage();
		setEmployeeHours();
		setGrossPay();
		setTax();
		setNetPay();
		setTotalHours();
		setTotalGrossPay();
		setTotalWithholding();
		setTotalNetPay();
		printEmployeeData();
		$counter++;
		determineContinue();
	}
	system ("cls");
	printTotals();
	sleep 1;
	exit 0;
}

sub setEmployeeName() {
	my $name;
	print "\n\tPlease enter employee last name: ";
	chomp ($name = <STDIN>);
	$employeeData[getCounter()] = $name;
}

sub setEmployeeWage() {
	my $wage;
	print "\n\tPlease enter employee hourly wage: ";
	chomp ($wage = <STDIN>);
	$employeeData[getCounter()][getCounter()] = $wage;
}

sub setEmployeeHours() {
	my $hours;
	print "\n\tPlease enter employee hours worked: ";
	chomp ($hours = <STDIN>);
	$employeeData[getCounter()][getCounter()][getCounter()] = $hours;
}

sub setGrossPay() {
	$grossPay = getWage() * getHours();
}

sub setTax() {
	use constant MINTAX => 1.10;
	use constant MEDTAX1 => 1.14;
	use constant MEDTAX2 => 1.18;
	use constant MAXTAX => 1.22;
	use constant ZEROPAY => 0;
	use constant MINPAY => 200;
	use constant MEDPAY => 350;
	use constant MAXPAY => 500;
	
	if (getGrossPay() > ZEROPAY && getGrossPay() <= MINPAY) {
		$tax = MINTAX;
	} elsif (getGrossPay() <= MEDPAY && getGrossPay() > MINPAY) {
		$tax = MEDTAX1;
	} elsif (getGrossPay() <= MAXPAY && getGrossPay() > MEDPAY) {
		$tax = MEDTAX2;
	} else {
		$tax = MAXTAX;
	}
}

sub setNetPay() {
	$netPay = (getGrossPay() / getTax());
}

sub setTotalHours() {
	$totalHours = ($totalHours + getHours());
}

sub setTotalGrossPay() {
	$totalGrossPay = ($totalGrossPay + getGrossPay());
}

sub setTotalWithholding() {
	$totalWithholding = ($totalWithholding + (getGrossPay() - getNetPay()));
}

sub setTotalNetPay() {
	$totalNetPay = ($totalNetPay + getNetPay());
}

sub getName() {
	return $employeeData[getCounter()];
}

sub getWage() {
	return $employeeData[getCounter()][getCounter()];
}

sub getHours() {
	return $employeeData[getCounter()][getCounter()][getCounter()];
}

sub getCounter() {
	return $counter;
}

sub getGrossPay() {
	return $grossPay;
}

sub getTax() {
	return $tax;
}

sub getNetPay() {
	return $netPay;
}

sub getTotalHours() {
	return $totalHours;
}

sub getTotalGrossPay() {
	return $totalGrossPay;
}

sub getTotalWithholding() {
	return $totalWithholding;
}

sub getTotalNetPay() {
	return $totalNetPay;
}

sub printEmployeeData() {
	system ("cls");
	print "\n\tEmployee: $employeeData[getCounter()]\n";
	print "\t=======================\n";
	printf "\tGross pay: " . '%.2f', getGrossPay();
	print "\n\tTax rate: " . getTax();
	printf "\n\tNet pay: " . '%.2f', getNetPay();
}

sub determineContinue() {
	print "\n\n\tDo you want to continue? (0 = no, 1 = yes): ";
	chomp ($continue = <STDIN>);
	if ($continue < 0 || $continue > 1) {
		print "\n\tInvalid choice! Please enter a 0 for no or a 1 for yes!\n";
		sleep 1;
		$continue = 1;
		determineContinue();
	}
}

sub printTotals() {
	#system ("cls");
	print "\n\n\t==================================\n";
	printf "\tTotal hours worked: " . '%.2f', getTotalHours();
	print "\n\tTotal gross pay: " . getTotalGrossPay();
	printf "\n\tTotal withholding amount: " . '%.2f', getTotalWithholding();
	printf "\n\tTotal net pay: " . '%.2f', getTotalNetPay();
	print "\n\t==================================\n";
}

main();