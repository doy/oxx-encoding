package OXx::Encoding::Role::Response;
use MooseX::Role::Parameterized;
use namespace::autoclean;

use OXx::Encoding::Types;

parameter encoding => (
    isa      => 'Encoding',
    required => 1,
);

parameter html_encoding => (
    isa     => 'Str',
    lazy    => 1,
    default => sub { shift->encoding },
);

role {
    my $p = shift;

    # XXX: set the html encoding here... (need to support this in ox first)
}

1;
