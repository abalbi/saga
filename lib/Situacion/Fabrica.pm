package Situacion::Fabrica;
use Data::Dumper;
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
69 => { 'romantic[a|o]' => 1, 'fogos[a|o]' => 10, 'bizarr[a|o]' => 10,  'depravad[a|o]' => 1,},
EN_LA_CAMA => { 'romantic[a|o]' => 10,  'fogos[a|o]' => 6,'bizarr[a|o]' => 0, 'depravad[a|o]' => 1,},
};


sub hacer {
  my $self = shift;
  my $entorno = shift;
  my $personas->[0] = shift->{sujeto};
  push @$personas, $entorno->buscar_crear({sexo => $personas->[0]->sexo eq 'f' ? 'm' : 'f'});
  my $actores = [];
  print "#####################################\n";
  foreach my $persona (sort {$b->espiritu <=> $a->espiritu} @$personas) {
    print $persona->describir."\n";
    push @$actores, {
      persona => $persona,
      atributos => {
        animo => $persona->animo,
      },
      puntos_placer => 0,
    };
  }
  #calentando_motores
  foreach my $actor (@$actores) {
    my $accion;
    while(not $accion) {
      my $azar = Saga::azar(9) +1;
      my $key = Saga::azar([sort keys %$calentando_motores]);
      my $valor = $calentando_motores->{$key}->{$actor->{persona}->ascendente_erotica};
      $accion = $key if $valor >= $azar;
    }
    $actor->{calentando_motores} = $accion;
  }
  foreach my $actor (@$actores) {
    my $accion = $calentando_motores->{$actor->{calentando_motores}};
    print $actor->{persona}->nombre . " propone $actor->{calentando_motores}\n";
    foreach my $actor2 (@$actores) {
      my $posibles = $accion->{$actor2->{persona}->ascendente_erotica};
      my $puntos = Saga::azar($posibles) if $posibles > 1;
      $puntos = $posibles if $posibles <= 1;
      $actor2->{puntos_placer} += $puntos;
      print "\t" . $actor2->{persona}->nombre . " recibe $puntos de ". $accion->{$actor2->{persona}->ascendente_erotica} . "\n";
    }
  }

  #a_toda_maquina
  foreach my $actor (@$actores) {
    my $accion;
    while(not $accion) {
      my $azar = Saga::azar(9) +1;
      my $key = Saga::azar([sort keys %$a_toda_maquina]);
      my $valor = $a_toda_maquina->{$key}->{$actor->{persona}->ascendente_erotica};
      $accion = $key if $valor >= $azar;
    }
    $actor->{a_toda_maquina} = $accion;
  }
  foreach my $actor (@$actores) {
    my $accion = $a_toda_maquina->{$actor->{a_toda_maquina}};
    print $actor->{persona}->nombre . " propone $actor->{a_toda_maquina}\n";
    foreach my $actor2 (@$actores) {
      my $posibles = $accion->{$actor2->{persona}->ascendente_erotica};
      my $puntos = Saga::azar($posibles) if $posibles > 1;
      $puntos = $posibles if $posibles <= 1;
      my $prueba = 1;
      if(ref $accion->{prueba} eq 'CODE') {
        $prueba = &{$accion->{prueba}}($actor, $actores);
        print $actor->{persona}->nombre . "FALLO LA PRUEBA";
      }
      $actor2->{puntos_placer} += $puntos if $prueba;
      print "\t" . $actor2->{persona}->nombre . " recibe $puntos de ". $accion->{$actor2->{persona}->ascendente_erotica} . "\n";
    }
  }

  #subidon_final
  foreach my $actor (@$actores) {
    my $nivel = Saga::azar(9) + 1;
    $actor->{'SUBIDON'} = 'SIGUE';
    while($actor->{'SUBIDON'} eq 'SIGUE') {
      my $nivel2 = Saga::azar(9) + 1;
      $actor->{'SUBIDON'} = (Saga::azar(9) + 1) >= $nivel ? 'BASTA' : 'SIGUE';
      if($nivel2 > $nivel) {
        $nivel = $nivel2;
        $actor->{'SUBIDON'} = 'BASTA' if $nivel == 10;
      } else {
        $actor->{'SUBIDON'} = 'PERDIO';
      }
    }
    if($actor->{'SUBIDON'} eq 'BASTA') {
      $actor->{puntos_placer} += 3  if $nivel == 2;
      $actor->{puntos_placer} += 5  if $nivel == 3;
      $actor->{puntos_placer} += 10 if $nivel == 4;
      $actor->{puntos_placer} += 15 if $nivel == 5;
      $actor->{puntos_placer} += 20 if $nivel == 6;
      $actor->{puntos_placer} += 25 if $nivel == 7;
      $actor->{puntos_placer} += 30 if $nivel == 8;
      $actor->{puntos_placer} += 35 if $nivel == 9;
      $actor->{puntos_placer} += 50 if $nivel == 10;
    }
    print $actor->{persona}->nombre . " Al final llega a ".$actor->{puntos_placer}."\n";
  }  
}

1;
