package Entorno::Fabrica;
use Data::Dumper;
sub hacer {
  my $self = shift;
  my $entorno = shift;
  $entorno = Entorno->new;
  my $cantidad_personas = 0;
  print STDERR "Hacer Personas ";
  while ($entorno->cantidad_personas > $cantidad_personas) {
    print STDERR ".";
    my $persona = Persona::Fabrica->hacer;
    push @{$entorno->items}, $persona;
    $persona->entorno($entorno);
    $cantidad_personas = scalar @{$entorno->personas};
  }
  print STDERR "\n";
  my $cantidad_situaciones = 0;
  my $fecha;
  print STDERR "Hacer Situaciones ";
  while ($entorno->cantidad_situaciones > $cantidad_situaciones) {
    print STDERR ".";
    $fecha = DateTime->now if !$fecha;
    my $rango = Saga::azar(1 * 24 * 60 * 60);
    my $epoch = DateTime::Format::Strptime->new(pattern => '%FT%T')->parse_datetime($fecha)->epoch  + $rango;
    $fecha = DateTime->from_epoch(epoch => $epoch)->datetime;
    my $situacion = Situacion::Fabrica->hacer($entorno, {
      fecha => $fecha
    });
    push @{$entorno->items}, $situacion;
    $cantidad_situaciones++;
  }
  print STDERR "\n";
  return $entorno;
}
1;
