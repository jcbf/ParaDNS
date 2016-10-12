#!/usr/bin/perl -w

use Test::More tests => 3;

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
    host => 'outlook.com',
    type => 'TXT',
    nameservers => [qw/8.8.8.8/],
    callback => sub {
        print "Got no answer: $_[0]\n";
        return if $got_answer++;
	ok($_[0], "www.google.com => $_[0]");
        $done++;
    },
);
my $ns_got_answer = 0;
ParaDNS->new(
    host => 'gmail.com',
    type => 'TXT',
    nameservers => [qw/8.8.4.4:53/],
    callback => sub {
        print "Got no answer: $_[0]\n";
        return if $ns_got_answer++;
	ok($_[0], "gmail.com  MX => $_[0]");
        $done++;
    },
);

Danga::Socket->EventLoop;

