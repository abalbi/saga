package Libido::Situacion::Erotica;
use strict;
use Data::Dumper;
use base qw(Situacion);

sub key {'Situacion Erotica'}

sub puede_random {0};

our $calentando_motores = {
  BESOS_APASIONADOS   => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 10, 'bizarr[a|o]' => 6, 'depravad[a|o]' => 0,},
  CARICIAS_SALVAJES   => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 6, 'depravad[a|o]' => 6,},
  STRIPTEASSE         => { 'romantic[a|o]' => 6, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  BDSM                => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 1,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  FILMAR              => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  SEXO_Y_GASTRONOMIA  => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  ATAME               => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  JUEGO_ROLES         => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  MORDISCOS_UNIAS_CACHETES  => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  ME_APETECE_HACERLO_AQUI   => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  LENCERIA            => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  EXIVISIONISMO       => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 1,'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  ROMPER_ROPA         => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 6, 'depravad[a|o]' => 10, },
  DULCES_PALABRAS     => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 6,'bizarr[a|o]' => 6, 'depravad[a|o]' => 0,},
  MASAJES_ACEITES_CARICIA   => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 6,'bizarr[a|o]' => 6, 'depravad[a|o]' => 0,}
};

our $a_toda_maquina = {
  MASTURBACION => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  JUGUETES_EROTICOS => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  ARNESES_Y_CORREAS => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  MESA_SILLA_DE_PIE => { 'romantic[a|o]' => 6, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  DOBLE_PENETRACION => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  LLUVIA_DORADA_BESO_NEGRO => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 1,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  SEXO_Y_DOLOR => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 0,'bizarr[a|o]' => 1, 'depravad[a|o]' => 10, },
  FIST_FUCKING => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 6,'bizarr[a|o]' => 10,  'depravad[a|o]' => 10, },
  BUSCANDO_PUNTO_G => { 'romantic[a|o]' => 12, 'fogos[a|o]' => 20,'bizarr[a|o]' => 20, 'depravad[a|o]' => 12,},
  ACROBACIAS => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  SEXO_ORAL => { 'romantic[a|o]' => 6, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 6,},
  POR_DETRAS => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 10,},
  CUBANA => { 'romantic[a|o]' => 0, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  SESENTINUEVE => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
  EN_LA_CAMA => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 6,'bizarr[a|o]' => 0, 'depravad[a|o]' => 1,},
};


sub _hacer {
  my $self = shift;
  my $personas = shift;
  $self->hacer_calentando_motores;
  $self->hacer_a_toda_maquina;
  $self->hacer_subidon_final;
  $self->hacer_petite_morte;
}

sub hacer_petite_morte {
  my $self = shift;
  my $actores = [sort {$b->espiritu <=> $a->espiritu} @{$self->actores}];
  foreach my $actor (@$actores) {
    my $puntos_placer = $actor->puntos_placer;
    my $params;
    $params = {alteracion => '-2', temporal => 1, duracion => '1d'};
    $params = {alteracion => '-1', temporal => 1, duracion => '1d'} if $puntos_placer >= 11;
    $params = {alteracion => ' 0', temporal => 1, duracion => ''}   if $puntos_placer >= 16;
    $params = {alteracion => '+1', temporal => 1, duracion => '1d'} if $puntos_placer >= 26;
    $params = {alteracion => '+2', temporal => 1, duracion => '1d'} if $puntos_placer >= 36;
    $params = {alteracion => '+3', temporal => 1, duracion => '1d'} if $puntos_placer >= 46;
    $params = {alteracion => '+1', temporal => 0, duracion => '1d'} if $puntos_placer > 55;
    $params->{key} = 'animo';
    $params->{fecha} = $self->fecha;
    $actor->persona->alterar($params);
  }   
}

sub hacer_subidon_final {
  my $self = shift;
  my $actores = [sort {$b->espiritu <=> $a->espiritu} @{$self->actores}];
  foreach my $actor (@$actores) {
    my $puntos_placer = $actor->puntos_placer;
    my $nivel = Saga::azar(9) + 1;
    $actor->subidon('SIGUE');
    while(1) {
      my $nivel2 = Saga::azar(9) + 1;
      $actor->subidon((Saga::azar(9) + 1) >= $nivel ? 'BASTA' : 'SIGUE');
      if($nivel2 > $nivel) {
        $nivel = $nivel2;
        $actor->subidon('BASTA') if $nivel == 10;
      } else {
        $actor->subidon('PERDIO');
      }
      next if $actor->subidon eq 'SIGUE';
      last;
    }
    my $mod = 0;
    if($actor->subidon eq 'BASTA') {
      $mod = 3  if $nivel == 2;
      $mod = 5  if $nivel == 3;
      $mod = 10 if $nivel == 4;
      $mod = 15 if $nivel == 5;
      $mod = 20 if $nivel == 6;
      $mod = 25 if $nivel == 7;
      $mod = 30 if $nivel == 8;
      $mod = 35 if $nivel == 9;
    }
    $actor->puntos_placer($puntos_placer + $mod);
  }
}

sub hacer_a_toda_maquina {
  my $self = shift;
  my $actores = [sort {$b->espiritu <=> $a->espiritu} @{$self->actores}];
  foreach my $actor (@$actores) {
    my $accion;
    while(not $accion) {
      my $azar = Saga::azar(9) +1;
      my $key = Saga::azar([sort keys %$a_toda_maquina]);
      my $valor = $a_toda_maquina->{$key}->{$actor->ascendente_erotica};
      $accion = $key if $valor >= $azar;
    }
    $actor->a_toda_maquina($accion);
  }
  foreach my $actor (@$actores) {
    my $accion = $a_toda_maquina->{$actor->a_toda_maquina};
    foreach my $actor2 (@$actores) {
      my $posibles = $accion->{$actor2->ascendente_erotica};
      my $puntos = Saga::azar($posibles) if $posibles > 1;
      $puntos = $posibles if $posibles <= 1;
      $actor2->puntos_placer($actor2->puntos_placer + $puntos);
    }
    my $duracion = Saga::azar(20*60);
    $self->fecha(DateTime->from_epoch(epoch => $self->fecha->epoch + $duracion)->datetime);
  }
}

sub hacer_calentando_motores {
  my $self = shift;
  my $actores = [sort {$b->espiritu <=> $a->espiritu} @{$self->actores}];
  foreach my $actor (@$actores) {
    my $accion;
    while(not $accion) {
      my $azar = Saga::azar(9) +1;
      my $key = Saga::azar([sort keys %$calentando_motores]);
      my $valor = $calentando_motores->{$key}->{$actor->ascendente_erotica};
      $accion = $key if $valor >= $azar;
    }
    $actor->calentando_motores($accion);
  }
  foreach my $actor (@$actores) {
    my $accion = $calentando_motores->{$actor->calentando_motores};
    foreach my $actor2 (@$actores) {
      my $posibles = $accion->{$actor2->ascendente_erotica};
      my $puntos = Saga::azar($posibles) if $posibles > 1;
      $puntos = $posibles if $posibles <= 1;
      $actor2->puntos_placer($actor2->puntos_placer + $puntos);
    }
    my $duracion = Saga::azar(20*60);
    $self->fecha(DateTime->from_epoch(epoch => $self->fecha->epoch + $duracion)->datetime);
  }
}

1;