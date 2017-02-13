use strict;
use lib 'lib';

use Saga;
use Data::Dumper;
Saga::load($ARGV[0]);
my $entorno = Entorno::Fabrica->hacer();
print $entorno->describir;

