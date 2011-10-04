package OXx::Encoding;
use MooseX::Role::Parameterized;
use namespace::autoclean;

use Moose::Util 'with_traits';
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

    around request_class => sub {
        my $orig = shift;
        my $self = shift;

        return with_traits($self->$orig(@_),
            'OXx::Encoding::Role::Request' => {
                encoding      => $p->encoding,
                html_encoding => $p->html_encoding,
            },
        );
    };
}

1;
