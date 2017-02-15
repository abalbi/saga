package Entorno::Fabrica;
use strict;
use Data::Dumper;

sub logger {
  return Log::Log4perl->get_logger(__PACKAGE__);
}

sub new {
	my $class = shift;
	$class = ref $class if ref $class;
	my $self = bless {}, $class;
	$self;
}

sub cantidad_personas {
	return 0;
}

sub cantidad_situaciones {
	return 0;
}

sub hacer {
  my $self = shift;
  my $params = Saga::params(@_);
  $Data::Dumper::Maxdepth = 2;
  my $entorno = Saga::despachar('Entorno')->new;
  $self->hacer_personas($entorno);
  $self->hacer_situaciones($entorno);
  return $entorno;
}

sub hacer_personas {
	my $self = shift;
	my $entorno = shift;
  my $cantidad_personas = 0;
  logger->info("Hacer Personas");
  while ($self->cantidad_personas > $cantidad_personas) {
    my $persona = Saga::despachar('Persona::Fabrica')->hacer(entorno => $entorno);
    $persona->entorno($entorno);
    $cantidad_personas = scalar @{$entorno->personas};
  }
}

sub hacer_situaciones {
	my $self = shift;
	my $entorno = shift;
  my $cantidad_situaciones = 0;
  my $fecha;
  logger->info("Hacer Situaciones");
  while ($self->cantidad_situaciones > $cantidad_situaciones) {
    $fecha = DateTime->now if !$fecha;
    my $rango = Saga::azar(1 * 24 * 60 * 60);
    my $epoch = DateTime::Format::Strptime->new(pattern => '%FT%T')->parse_datetime($fecha)->epoch  + $rango;
    $fecha = DateTime->from_epoch(epoch => $epoch)->datetime;
    my $situacion = Saga::despachar('Situacion::Fabrica')->hacer(entorno => $entorno, fecha => $fecha);
    $cantidad_situaciones++;
  }
}

1;
