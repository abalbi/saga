package Libido::Situacion::Seduccion;
use strict;
use Data::Dumper;
use base qw(Situacion);

sub key {'Situacion Seduccion'}

our $donde = [qw(una_fiesta el_trabajo una_galeria la_calle una_disco)];

sub _hacer {
  my $self = shift;
  my $personas = shift;
  my $actores = $self->actores;
  my ($seductor, $seducido) = sort {$b->animo <=> $a->animo} @$actores;
  my $duracion = Saga::azar(2*60*60);
  $seductor->seductor('SI');
  $seducido->seductor('NO');
  $seductor->primera_impresion(Saga::azar(10) - $seducido->sociabilidad);
  $seducido->primera_impresion(Saga::azar(10) - $seducido->sociabilidad);
	if($seductor->primera_impresion <= $seducido->primera_impresion) {
		my $mod = $seductor->primera_impresion + $seducido->primera_impresion;
		$seductor->miradas(Saga::azar(10) - $seducido->sentidos + $mod);
		$seducido->miradas(Saga::azar(10) - $seducido->sentidos - $mod);
	  if($seductor->miradas <= $seducido->miradas) {
			my $mod = $seductor->miradas + $seducido->miradas;
			$seductor->charla_astuta(Saga::azar(10) - $seducido->mente + $mod);
			$seducido->charla_astuta(Saga::azar(10) - $seducido->mente + $mod);
			if($seductor->charla_astuta <= $seducido->charla_astuta) {
				$self->logger()->warn("Se dispara situacion Erotica entre ".$self->nombres_actores);
				Saga::despachar('Situacion::Fabrica')->hacer(
					entorno => $self->entorno, 
					clase => 'Libido::Situacion::Erotica',
					fecha => DateTime->from_epoch(epoch => $self->fecha->epoch + $duracion)->datetime,
					personas => [map {$_->persona} @$actores]
				);
			}
		}
  }
}

1;
