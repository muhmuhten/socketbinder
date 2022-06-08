#!/usr/bin/env perl
use 5.012;
use autodie ':socket';
use Socket ':all', 'SOCK_NONBLOCK';

for (shift() // die "usage: $0 path command...") {
	socket STDIN, PF_UNIX, SOCK_STREAM|SOCK_NONBLOCK, 0;
	unlink; # failure ok
	bind STDIN, sockaddr_un $_;
	listen STDIN, SOMAXCONN;
	exec {$ARGV[0]} @ARGV or die "exec: $!";
}
