package Entorno::Fabrica;
use Data::Dumper;
sub hacer {
  my $self = shift;
  my $entorno = shift;
  $entorno = Entorno->new;
  my $cantidad_personas = 0;
  while ($entorno->cantidad_personas > $cantidad_personas) {
    my $persona = Persona::Fabrica->hacer;
    push @{$entorno->items}, $persona;
    $cantidad_personas = scalar @{$entorno->personas};
  }
  foreach my $persona (@{$entorno->personas}) {
    Situacion::Fabrica->hacer($entorno, {sujeto => $persona});
  }
  return $entorno;
}
1;
