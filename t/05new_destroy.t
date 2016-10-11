#!/usr/bin/perl -w

use Test::More tests => 2;

$|++;

$ENV{NODNS}= 1;
use_ok('ParaDNS');

my $done = 0;

Danga::Socket->SetPostLoopCallback(
    sub {
        return 1 unless $done >= 1;
        return 0; # causes EventLoop to exit
    });

my $txt_got_answer = 0;
ParaDNS->new(
    host => 'www.google.com',
    callback => sub {
        print "Got no answer: $_[0]\n";
        return if $txt_got_answer++;
	ok($_[0] eq 'NXDNS' , "NXDNS no host $_[0]");
        $done++;
    },
);

Danga::Socket->EventLoop;

