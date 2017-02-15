use strict;
use lib 'lib';
use Saga;
use Data::Dumper;
Saga::load($ARGV[0]);
my $entorno = Saga::despachar('Entorno::Fabrica')->hacer();
print $entorno->describir;
