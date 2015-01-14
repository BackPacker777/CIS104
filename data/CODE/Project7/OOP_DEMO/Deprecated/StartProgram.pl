# AUTHOR: hbates@northmen.org
# VERSION: 11.25.2013.01
# PURPOSE: Demonstrate PooP
# ASSIGNMENT: Perl OOP (PooP)

use 5.14.3;
use Moops;
use Employee;
use Customer;

sub main {
	Employee->new(lastName => "Bates", firstName => "Howard", socialSecNum => 111002222, employeeNum => 1, isValid => 1)->dispatch(); ## Constructor paramaters
	print "\n===================================================\n";
	Customer->new(lastName => "Johnson", firstName => "Bill", salesValue => 3000, customerNum => 1000, isValid => 1)->dispatch();
	return;
}

main();
