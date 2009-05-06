package ;
use strict;
use warnings;

use base qw/Class::Accessor::Fast/;
use Data::Dumper;
__PACKAGE__->mk_accessors(qw/name/);
sub p { warn Dumper shift }

sub new {
    my $class = shift;
    $class = ref $class || $class;
    bless { @_ }, $class;
}

package main;
use strict;
use warnings;

use Data::Dumper;

sub p ($) { warn Dumper shift }
