#! /usr/bin/perl

use DBI;
use strict;


sub db_connect {

	my $driver = "mysql";
	my $database = "thehole";
	my $dsn = "DBI:$driver:database=$database";
	my $userid = "root";
	my $password = "";

	my $dbh = DBI->connect($dsn, $userid, $password ) or die $DBI::errstr;

	return $dbh;

}

sub check_exploits{
	#STARTING SEARCH!!!
	
	my ($dbh, $tecnology, $version) = @_;

	my $sth = $dbh->prepare("SELECT * FROM exploits WHERE tecnologia = ?");
	$sth->execute($tecnology);

	while (my $row = $sth->fetchrow_hashref){
		if (index($row->{versao_afetada}, $version) != -1 || $row->{versao_afetada} eq 'ALL'){
			print "[!] Possible vuln: $row->{nome_exploit}\n";
			print "  CVE: $row->{cve} - Type: $row->{tipo} - Level: $row->{nivel_risco}\n";
			print "  URL: $row->{exploit_url}\n\n ";
		}
	}

	
}

sub API{
	
	my ($target, $dbh) = @_;
	my $ua = LWP::UserAgent->new;

	open(my $fh, '<', 'exploits/api.txt') or die "Not found the api.txt: $!";
	my @api_paths = <$fh>;
	close($fh);
	chomp @api_paths;
	
	foreach my $path (@api_paths) {
		my $url = "$target$path";
		my $res = $ua->get($url);

		if ($res->is_success){
			print "[+] Endpoint found: $url\n";

			my $server = $res->header("Server") // "uncharted"; 
			my $x_powered = $res->header("X-Powered-By") // "No info";
			
			print " -> Server: $server\n";
			print " -> X-Powered-By: $x_powered\n";

			check_exploits($dbh, $server, $x_powered);
		} else {
			print "[-] Fail in $url (Status: " . $res->code .")\n";
		}
	
	}
}

sub start{

	print "Put the host now: ";
	chomp( my $target = <STDIN>);
	API();
}

start();
