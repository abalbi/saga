package Situacion::Fabrica;
use strict;
use Data::Dumper;

sub logger {
  return Log::Log4perl->get_logger(__PACKAGE__);
}

sub hacer {
  my $self = shift;
  my $params = Saga::params(@_);
  my $entorno = $params->{entorno};
  my $fecha_base = $params->{fecha};
  my $fecha = $fecha_base;
  die "Se requiere definir una fecha para generar una situacion" if not defined $fecha;
  $fecha = Saga::dt($fecha);
  my $personas = $params->{personas};
  my $clase = $params->{clase};
  $personas = [] if ref $personas ne 'ARRAY';
  my $situacion;
  while (!$situacion) {
    $situacion = $self->hacer_situacion($entorno, $fecha,$clase);
  }
  $situacion->hacer($personas);
  push @{$entorno->items}, $situacion;
  return $situacion;
}

sub hacer_situacion {
  my $self = shift;
  my $entorno = shift;
  my $fecha = shift;
  my $clase = shift;
  if(not defined $clase) {
    $clase = Saga::azar([grep {$_ =~ /^(?!Core).*Situacion\/(\w+)\.pm/;} sort keys %INC]);
    $clase =~ s/\//::/g;
    $clase =~ s/\.pm//g;
    return 0 if !$clase->puede_random;
  }
  my $situacion = $clase->new({
    entorno => $entorno,
    fecha_base => $fecha->datetime,
    fecha => $fecha->datetime,
  });
  return $situacion;
}



1;
