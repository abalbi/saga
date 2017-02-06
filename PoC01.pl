use strict;
use lib 'lib';

use Saga;









use Data::Dumper;
my $entorno = Entorno::Fabrica->hacer();
print $entorno->describir;


