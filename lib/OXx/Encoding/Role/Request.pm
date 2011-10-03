package OXx::Encoding::Role::Request;
use MooseX::Role::Parameterized;
use namespace::autoclean;

use Encode ();
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

    my $encoding = Encode::find_encoding($p->encoding);

    sub decode {
        my $self = shift;
        my ($data) = @_;
        return $encoding->decode($data);
    }

    sub encode {
        my $self = shift;
        my ($data) = @_;
        return $encoding->encode($data);
    }

    around response_class => sub {
        my $orig = shift;
        my $self = shift;

        my $super = $self->$orig(@_);

        return Moose::Meta::Class->create_anon_class(
            superclasses => [$super],
            roles        => [
                'OXx::Encoding::Role::Response' => {
                    encoding      => $p->encoding,
                    html_encoding => $p->html_encoding,
                },
            ],
            cache        => 1,
        )->name;
    };
}

1;
