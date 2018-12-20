use strict;
use warnings;
sub say {print @_, "\n"}
use Data::Dumper;sub p {local $Data::Dumper::Sortkeys=1; warn Dumper \@_;my @c = caller;warn "  at $c[1]:$c[2]\n\n"}
