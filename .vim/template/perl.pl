use strict;
use warnings;
use Data::Dumper;sub p {warn Dumper @_;my @c = caller;print STDERR "  at $c[1]:$c[2]\n\n"}

