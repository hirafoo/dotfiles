use strict;
use warnings;
sub say {print @_, "\n"}
use Data::Dumper;sub p {warn Dumper @_;my @c = caller;print STDERR "  at $c[1]:$c[2]\n\n"}
