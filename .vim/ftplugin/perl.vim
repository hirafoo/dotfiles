inoremap PP use Data::Dumper;sub p {warn Dumper @_;my @c = caller;print STDERR "  at $c[1]:$c[2]\n\n"}<CR>
inoremap SS my ($self, ) = @_;<CR>
set iskeyword+=:
noremap K :Perldoc<CR>
