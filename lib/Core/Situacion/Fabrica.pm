package Situacion::Fabrica;
use strict;
use Data::Dumper;


sub hacer {
  my $self = shift;
  my $entorno = shift;
  my $params = shift;
  my $fecha_base = $params->{fecha};
  my $fecha = $fecha_base;
  die "Se requiere definir una fecha para generar una situacion" if not defined $fecha;
  $fecha = Saga::dt($fecha);
  my $personas = $params->{personas};
  $personas = [] if ref $personas ne 'ARRAY';
  my $situacion = $self->hacer_situacion($entorno, $fecha);
  $situacion->hacer($personas);
  return $situacion;
}

sub hacer_situacion {
  my $self = shift;
  my $entorno = shift;
  my $fecha = shift;
  my $clase = Saga::azar([grep {$_ =~ /^(?!Core).*Situacion\/(\w+)\.pm/;} sort keys %INC]);
  $clase =~ s/\//::/g;
  $clase =~ s/^\w+\:\://g;
  $clase =~ s/\.pm//g;
  my $situacion = $clase->new({
    entorno => $entorno,
    fecha_base => $fecha->datetime,
    fecha => $fecha->datetime,
  });
  return $situacion;
}



1;
