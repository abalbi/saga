package Situacion::Pelea;
use strict;
use Data::Dumper;
use base qw(Situacion);

our $acentos = [qw(
	agilidad			       contorsionarse     destreza			       elasticidad
	equilibrio			     fuerza             intuicion 			     pelear 
	resistencia 		     acrobacias      	  arte_marcial		     atletismo_deporte
	defensa_personal     juegos_de_manos    debilidad_muscular   enanismo
	invalidez			       nulidad_deportiva  tics_insoportables   torpeza
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
      my $reporte = {};
      $reporte->{actor_actua} = $actor->actua;
      if($actor->actua eq 'SI') {
        $reporte->{oponente_salud} = $oponente->salud;
        $reporte->{tirada_ataque} = Saga::azar(10);
        $reporte->{mod_ataque} = $actor->acentuar($acentos);
        $reporte->{res_ataque} = $reporte->{tirada_ataque} - ($actor->cuerpo + $reporte->{mod_ataque});
        $reporte->{'esquiva?'} = Saga::azar(1);
        if($reporte->{'esquiva?'}) {
          $reporte->{tirada_esquivar} = Saga::azar(10);
          $reporte->{mod_esquivar} = $actor->acentuar($acentos);
          $reporte->{res_esquivar} = $reporte->{tirada_esquivar} - ($actor->sentidos + $reporte->{mod_esquivar});
          $reporte->{ataque_hit} = $reporte->{res_ataque} - $reporte->{res_esquivar};
          $oponente->actua('NO');
        } else {
          $reporte->{ataque_hit} = $reporte->{res_ataque};
        }
        $reporte->{dano} = 0;
        if($reporte->{ataque_hit} < 0) {
          $reporte->{dano} = int((-$reporte->{res_ataque})/3);
          $reporte->{dano} = 0 if $reporte->{dano} < 0;
          $oponente->salud($oponente->salud - $reporte->{dano});
#          $self->log($actor->nombre." ataca a ". $oponente->nombre . " y le causa $reporte->{dano} de daño. Salud ". $oponente->nombre.": ". $oponente->salud);
        }
        $sigue = 'NO' if $oponente->salud < 1;
        $self->log(join(' - ', map {$_->nombre . ' => salud:' .("=" x $_->salud)} sort {$a->nombre cmp $b->nombre} @$actores)) if $reporte->{dano};
      }
      $actor->actua('SI');
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