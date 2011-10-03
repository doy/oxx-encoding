package OXx::Encoding::Types;
use strict;
use warnings;
use Moose::Util::TypeConstraints;

use Encode ();

subtype 'Encoding', as 'Str', where { Encode::find_encoding($_) };

1;
