#!/usr/bin/perl -w

use Test::More tests => 2;

$|++;

use_ok('ParaDNS');

my $done = 0;

Danga::Socket->SetPostLoopCallback(
    sub {
        return 1 unless $done >= 1;
        return 0; # causes EventLoop to exit
    });

my $got_answer = 0;
ParaDNS->new(
    host => 'gmail.com',
    type => 'TXT',
    callback => sub {
        print "Got no answer: $_[0]\n";
        return if $got_answer++;
	ok($_[0], "gmail.com  TXT => $_[0]");
        $done++;
    },
);

Danga::Socket->EventLoop;

