#!/usr/bin/perl -w

use Test::More tests => 2;

$|++;

#$ENV{PARADNS_DEBUG}= 5;
use_ok('ParaDNS');

my $done = 0;

Danga::Socket->SetPostLoopCallback(
    sub {
        return 1 unless $done >= 1;
        return 0; # causes EventLoop to exit
    });

my $got_answer = 0;
ParaDNS->new(
    host => 'www.cpan.org',
    type => 'A',
    nameservers => [qw/8.8.8.8 8.8.4.4:53/],
    callback => sub {
        print "Got no answer: $_[0]\n";
	return if $got_answer++;
	ok($_[0], "www.google.com => $_[0]");
        $done++;
    },
);

Danga::Socket->EventLoop;

