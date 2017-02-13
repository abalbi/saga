package Situacion::Pelea;
use strict;
use Data::Dumper;
use base qw(Situacion);

our $acentos = [qw(
	agilidad			contorsionarse
	destreza			elasticidad
	equilibrio			fuerza 
	intuicion 			pelear 
	resistencia 		acrobacias 
	arte_marcial		atletismo_deporte
	defensa_personal 	juegos_de_manos
	debilidad_muscular	enanismo
	invalidez			nulidad_deportiva
	tics_insoportables	torpeza
)];

sub hacer {
  my $self = shift;
  my $personas = shift;
  $self->hacer_actores;
  my $actores = [sort {$b->sentidos <=> $a->sentidos} @{$self->actores}];
  my $sigue = 'SI';
  my $duracion_total = 0;
  while($sigue ne 'NO') {
	my $duracion = 3;
	foreach my $actor (@$actores) {
	  last if $sigue eq 'NO';
	  my $oponente = [grep {$_->nombre ne $actor->nombre} @{$self->actores}]->[0];
	  my $tirada_ataque = Saga::azar(10) + 1;
	  my $mod = $actor->acentuar($acentos);
	  my $res = $tirada_ataque - ($actor->cuerpo + $mod);
	  my $dano = 0;
	  if($res < 0) {
	  	$dano = int((-$res)/3);
	  	$oponente->salud($oponente->salud - $dano);
	  }
	  $self->log($actor->nombre." ataca a ". $oponente->nombre . " y le causa $dano de daño. Salud ". $oponente->nombre.": ". $oponente->salud);
	  $sigue = 'NO' if $oponente->salud < 1;
	}
	$self->fecha(DateTime->from_epoch(epoch => $self->fecha->epoch + $duracion)->datetime);
	$duracion_total += $duracion;
  }
  $self->log("La pelea entre " . $self->nombres_actores . " dura " . Saga::seg2codes($duracion_total));
}

sub hacer_actores {
  my $self = shift;
  my $personas = shift;
  my $actores = [];
  $personas = [] if not defined $personas;
  while(scalar @{$personas} < 2) {
    my $params = {
      package => 'Persona'
    };
    if($personas->[0]) {
      $params->{nombre} = "!".$personas->[0]->nombre;
    }
    my $persona = $self->entorno->buscar_crear($params);
    next if scalar grep {$_ eq $persona} @$personas;
    push @$personas, $persona;
  }
  foreach my $persona (@$personas) {
    push @$actores, Situacion::Actor->new({
      persona => $persona,
    });
  }
  $self->actores($actores);
}

1;