#!/usr/bin/perl -w

use strict;

use ExtUtils::MakeMaker qw(WriteMakefile);

sub MY::postamble {
	qq[testcover ::
	\t cover -delete && \\
	HARNESS_PERL_SWITCHES=-MDevel::Cover \$(MAKE) test && \\
	cover -report text
	]
}



WriteMakefile(
    VERSION_FROM   => 'lib/ParaDNS.pm',
    NAME           => 'ParaDNS',
    PREREQ_PM      => { 
                        'Danga::Socket' => 0.52,
                        'Test::More'    => 0,
                        'Net::DNS'      => 0.48,
                      },
    ABSTRACT_FROM  => 'lib/ParaDNS.pm',
    AUTHOR         => 'Matt Sergeant <matt@sergeant.org>',
    clean          => {FILES => "tv.log"},
    EXE_FILES      => [qw(fast-rdns.pl)],
);
    
