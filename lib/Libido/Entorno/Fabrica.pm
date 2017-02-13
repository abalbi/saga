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
    $persona->entorno($entorno);
    $cantidad_personas = scalar @{$entorno->personas};
  }
  my $cantidad_situaciones = 0;
  my $fecha;
  while ($entorno->cantidad_situaciones > $cantidad_situaciones) {
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
  return $entorno;
}
1;
