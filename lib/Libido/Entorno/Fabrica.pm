package Libido::Entorno::Fabrica;
use base qw(Entorno::Fabrica);
use Data::Dumper;
our $ano_base = DateTime->now->year;


sub cantidad_personas {
  return 1;
}

sub cantidad_situaciones {
  return 3;
}

sub ano_base {
  return $ano_base;
}
1;
