#!/usr/bin/perl
#

use Ham::Reference::QRZ;
use Data::Dumper;
use IO::File;

my $qrz = Ham::Reference::QRZ->new(
  callsign => '',
  username => '',
  password => ''
);

my $fd = new IO::File "/Users/joeri/Documents/MacLoggerDX QSO Details Labels.txt";

my $hash;

if (defined $fd) {
  while (my $data = <$fd>){
	  my $callsign = (split(" ", $data))[2];
	  $qrz->set_callsign($callsign);
	 my $listing = $qrz->get_listing;
	 if (($listing->{qslmgr} =~ /only direct/i) || ($listing->{qslmgr} =~ /no bureau/i)) {
		 print $callsign . "-> only direct ? " . $listing->{qslmgr} . "\n";
	 } else {
		 if ($callsing =~ /^3B6|^3B8|^3B9|^3C|^3DA|^3W|^3X|^4J|^5A|^5R|^5T|^7O|^7P|^7Q|^8Q|^9L|^9N|^9U|^9X|^A3|^A5|^A6|^A9|^C2|^C5|^C6|^CN|^D2|^D4|^D6|^E3|^ET|^HH|^HV|^J5|^J6|^J8|^KH0|^KH8|^KH9|^P2|^PZ|^S0|^S7|^S9|^5V|^ST|^SU|^T2|^T3|^T5|^T6|^T8|^V3|^V4|^V6|^V7|^VP2E|^VP2M|^VP6|^VQ9|^XU|^XW|^XZ|^Z2|^Z6|^Z8|^ZA|^ZD7|^ZD8|^ZD9/) {
			 print "No QSL Bureau available\n";
		 } else {
			 $hash->{$callsign} = $data;
		 }
	 }
  }
} else {
  print "no label file\n";
}

my $lfd = new IO::File ">/Users/joeri/Documents/Labels.txt";

foreach my $name (sort keys $hash) {
$lfd->print($hash->{$name});
}
$lfd->close;
