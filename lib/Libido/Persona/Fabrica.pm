package Persona::Fabrica;
use strict;
use Data::Dumper;
use DateTime;
use DateTime::Event::Random;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);


our $ano_base = DateTime->now->year;
our $nombres_mujer  = [qw(Lucia Maria Martina Paula Daniela Sofia Valeria Carla Sara Alba Julia Noa Emma Claudia Carmen Marta Valentina Irene Adriana Ana Laura Elena Alejandra Ines Marina Vera Candela Laia Ariadna Lola Andrea Rocio Angela Vega Nora Jimena Blanca Alicia Clara Olivia Celia Alma Eva Elsa Leyre Natalia Victoria Isabel Cristina Lara Abril Triana Nuria Aroa Carolina Manuela Chloe Mia Mar Gabriela Mara Africa Iria Naia Helena Paola Noelia Nahia Miriam Salma)];
our $nombres_hombre = [qw(Hugo Daniel Pablo Alejandro Alvaro Adrian David Martin Mario Diego Javier Manuel Lucas Nicolas Marcos Leo Sergio Mateo Izan Alex Iker Marc Jorge Carlos Miguel Antonio Angel Gonzalo Juan Ivan Eric Ruben Samuel Hector Victor Enzo Jose Gabriel Bruno Dario Raul Adam Guillermo Francisco Aaron Jesus Oliver Joel Aitor Pedro Rodrigo Erik Marco Alberto Pau Jaime Asier Luis Rafael Mohamed Dylan Marti Ian Pol Ismael Oscar Andres Alonso Biel Rayan Jan Fernando Thiago Arnau Cristian Gael Ignacio Joan)];
our $rasgos_positivos = [qw(accesible humilde activ[a|o] independiente adaptable intuitiv[a|o] afable inspirador[a|] afortunad[a|o] ingenios[a|o] alegre innovador[a|] apasionad[a|o] just[a|o] atrevid[a|o] leal bondados[a|o] logic[a|o] calmad[a|o] luchador[a|] caritativo meticulos[a|o] compasiv[a|o] modest[a|o] comunicativ[a|o] original con_iniciativa paciente concentrad[a|o] pacific[a|o] considerad[a|o] prudente constante profund[a|o] creativ[a|o] receptiv[a|o] curios[a|o] rect[a|o] decidid[a|o] reservad[a|o] discret[a|o] sensat[a|o] divertid[a|o] sensual divulgador[a|] sincer[a|o] ecuanime tenaz elegante tolerante emotiv[a|o] transigente energic[a|o] valiente espontane[a|o] veraz extrovertid[a|o] versatil generos[a|o] vital honest[a|o] voluntarios[a|o])];
our $rasgos_negativos = [qw(aburrid[a|o] inconsciente agresiv[a|o] inconstante agri[a|o] indecis[a|o] apatic[a|o] indiscret[a|o] arrogante inhibid[a|o] artificios[a|o] inmoral autocompasiv[a|o] intolerante autoritario insensat[a|o] avaricios[a|o] lujurios[a|o] caprichos[a|o] malvad[a|o] celos[a|o] megaloman[a|o] chismos[a|o] mentiros[a|o] cobarde nervios[a|o] coleric[a|o] obsesiv[a|o] cruel oportunista dependiente ordinari[a|o] desconectad[a|o] pasiv[a|o] desconsiderad[a|o] pesimista distraid[a|o] presuntuos[a|o] egoista rencoros[a|o] envidios[a|o] rigid[a|o] fals[a|o] rutinari[a|o] fri[a|o] sadic[a|o] frivol[a|o] sanguinari[a|o] gafe simple hipocrita sumis[a|o] hermetic[a|o] susceptible impaciente superficial imprudente tiran[a|o] inadaptable triste inapropiad[a|o] vulnerable)];
our $acentos_positivos = [qw(agilidad atractivo_fisico buscar calcular_mentalmente concentrarse contorsionarse convencer correr creacion_artistica culturilla_general destreza documentarse_investigar elasticidad empatia enseñar equilibrio esconderse estilo_personal evaluar fingir_mentir fuerza hacer_reir imitar influir integrarse intuicion mando memorizar orientarse pelear punteria_de_oro resistencia seducir sentido_desarrollado tocar_la_fibra tratar_con_animales tratar_con_niños trepar_escalar voz_bonita  acrobacias aficion armas_cuerpo_a_cuerpo arte_marcial atletismo_deporte bailar burocracia cantar comerciar conducir_pilotar defensa_personal diplomacia_y_etiqueta disfrazarse disparar forzar_mecanismos idioma_extranjero juegos_de_manos mañas montar_animal oratoria peluqueria_estetica primeros_auxilios tocar_instrumento torturar  aeronautica geologia antropologia historia arqueologia arquitectura arte_dramatico artesania astronomia audiovisuales biologia cibernetica ciencias_de_la_informacion criminologia derecho diseño ebanisteria ecologia economia electronica filosofia fisica fotografia quimica genetica ingenieria informatica farmacologia filologia gastronomia jardineria lampisteria literatura matematicas medicina mecanica metalurgia meteorologia musica ocultismo parapsicologia politica psicologia teologia veterinaria zoologia)];
our $acentos_negativos = [qw(adiccion cansancio_facil lent[a|o] debilidad_muscular dedos_torpes dificultad_de_aprendizaje dificultades_de_comunicacion enanismo discapacidad no_ritmo gigantismo invalidez enimista_animales enimista_ninos mal_aliento mal_humor mala_memoria metepatas sin_estilo_personal no_se_nadar nulidad_deportiva poco_agraciad[a|o], fe[a|o]_o_repulsiv[a|o] gloton[a|] punteria_horrible gord[a|o]_rigidez_corporal incapaz_de_orientarte incultura ineptitud_informatica_tecnologia sentido_atrofiado tics_insoportables torpeza ineptitud_para_idiomas voz_horrible)];

sub hacer {
  my $self = shift;
  my $persona_params = {};
  $self->dar_nacimiento($persona_params);
  $self->dar_sexo($persona_params);
  $self->dar_nombre($persona_params);
  $self->dar_ascendente_erotica($persona_params);
  $self->dar_aptitudes($persona_params);
  $self->dar_animo($persona_params);
  $self->dar_salud($persona_params);
  $self->dar_rasgos($persona_params);
  $self->dar_acentos($persona_params);
  my $persona = Persona->new($persona_params);
  return $persona;
}

sub dar_acentos {
  my $self = shift;
  my $persona_params = shift;
  my $animo = $persona_params->{animo}->valor;
  my $puntos = [5,3]  if $animo == 4;
  $puntos = [8,2]  if $animo == 5;
  $puntos = [8,2]  if $animo == 6;
  $puntos = [10,1] if $animo == 7;
  my $valores = [];
  while($puntos->[0]) {
    my $valor = Saga::azar(3) if $puntos->[0] >= 3;
    $valor = Saga::azar($puntos->[0]) if $puntos->[0] < 3;
    $puntos->[0] -= $valor;
    push @$valores, $valor if $valor;
  }
  while($puntos->[1]) {
    my $valor = Saga::azar(3) if $puntos->[1] >= 3;
    $valor = Saga::azar($puntos->[1]) if $puntos->[1] < 3;
    $puntos->[1] -= $valor;
    push @$valores, -$valor if $valor;
  }
  my $acentos = [];
  foreach my $valor (@$valores) {
    my $acento;
    while (1) {
      $acento = Saga::azar($acentos_positivos) if $valor > 0;
      $acento = Saga::azar($acentos_negativos) if $valor < 0;
      next if scalar grep {$_->{acento} eq $acento} @$acentos;
      last;
    }
    push @$acentos, {key => $acento, valor => $valor};
  }
  $persona_params->{acentos} = Persona::Valor->new({key => 'acentos', valor => $acentos});
}

sub dar_rasgos {
  my $self = shift;
  my $persona_params = shift;
  my $rasgos = {};
  $rasgos->{positivos} = [];
  $rasgos->{negativos} = [];
  my $numero = $persona_params->{animo}->valor;
  my $rasgos_valores = [];
  $rasgos_valores = [2,1] if $numero == 4;
  $rasgos_valores = [1,1] if $numero == 5;
  $rasgos_valores = [1,2] if $numero == 6;
  $rasgos_valores = [1,3] if $numero == 7;
  my $c = 1;
  my $lista = [];
  while ($rasgos_valores->[0] >= $c) {
    my $item = Saga::azar($rasgos_negativos);
    push @{$lista}, Saga::azar($rasgos_negativos);
    $c++;
  }
  $rasgos->{negativos} = $lista;
  my $c = 1;
  my $lista = [];
  while ($rasgos_valores->[0] >= $c) {
    push @{$lista}, Saga::azar($rasgos_positivos);
    $c++;
  }
  $rasgos->{positivos} = $lista;
  $persona_params->{rasgos} = Persona::Valor::Rasgos->new({key => 'rasgos', valor => $rasgos});
}


sub dar_animo {
  my $self = shift;
  my $persona_params = shift;
  my $numero = $persona_params->{espiritu}->valor;
  my $valor;
  $valor = 4 if $numero >= 1;
  $valor = 5 if $numero >= 2;
  $valor = 6 if $numero >= 4;
  $valor = 7 if $numero >= 7;
  $persona_params->{animo}= Persona::Valor::Animo->new({key => 'animo', valor => $valor});
}

sub dar_salud {
  my $self = shift;
  my $persona_params = shift;
  my $numero = $persona_params->{cuerpo}->valor;
  my $valor;
  $valor = 5 if $numero >= 2;
  $valor = 6 if $numero >= 3;
  $valor = 7 if $numero >= 4;
  $valor = 8 if $numero >= 5;
  $valor = 9 if $numero >= 6;
  $valor = 10 if $numero >= 7;
  $persona_params->{salud}= Persona::Valor::Salud->new({key => 'salud', valor => $valor});
}

sub dar_aptitudes {
  my $self = shift;
  my $persona_params = shift;
  my $valores = [];
  while (scalar @$valores <= 3) {
    my $numero = Saga::azar(9) + 1;
    my $valor;
    $valor = 2 if $numero >= 1;
    $valor = 3 if $numero >= 2;
    $valor = 4 if $numero >= 4;
    $valor = 5 if $numero >= 7;
    $valor = 6 if $numero >= 9;
    $valor = 7 if $numero >= 10;
    push @$valores, $valor;
  }
  $persona_params->{cuerpo} = Persona::Valor->new({key => 'cuerpo', valor => $valores->[0]});
  $persona_params->{mente} = Persona::Valor->new({key => 'mente', valor => $valores->[1]});
  $persona_params->{espiritu} = Persona::Valor->new({key => 'espiritu', valor => $valores->[2]});
  my $sentidos = int (($persona_params->{cuerpo}->valor + $persona_params->{mente}->valor)/2);
  my $sociabilidad = int (($persona_params->{mente}->valor + $persona_params->{espiritu}->valor)/2);
  $persona_params->{sentidos} = Persona::Valor->new({key => 'sentidos', valor => $sentidos});
  $persona_params->{sociabilidad} = Persona::Valor->new({key => 'sociabilidad', valor => $sociabilidad});
}

sub dar_ascendente_erotica {
  my $self = shift;
  my $persona_params = shift;
  my $ascendentes = [qw(romantic[a|o] fogos[a|o] bizarr[a|o] depravad[a|o])];
  my $ascendente_erotica = Saga::azar($ascendentes);
  $persona_params->{ascendente_erotica} = Persona::Valor->new({key => 'ascendente_erotica', valor => $ascendente_erotica});
  my $elecciones = [
    Saga::azar([qw(h m)]),
    Saga::azar([qw(h m)]),
    Saga::azar([qw(h m)]),
    Saga::azar([qw(h m)]),
    Saga::azar([qw(h m)]),
  ];
  $persona_params->{elecciones_erotica} = Persona::Valor->new({key => 'elecciones_erotica', valor => $elecciones});
}

sub dar_nacimiento {
  my $self = shift;
  my $persona_params = shift;
  my $base = $Persona::Fabrica::ano_base;
  my $edad = Saga::azar([21..45]);
  $base = $base - $edad;
  my $rango = Saga::azar(365 * 24 * 60 * 60);
  my $epoch = DateTime->new(year => $base)->epoch  + $rango;
  my $dt = DateTime->from_epoch(epoch => $epoch);
  $persona_params->{nacimiento} = Persona::Valor->new({key => 'nacimiento', valor => $dt->datetime});
}

sub dar_sexo {
  my $self = shift;
  my $persona_params = shift;
  $persona_params->{sexo} = Persona::Valor->new({key => 'sexo', valor => Saga::azar([qw(f m)])});

}

sub dar_nombre {
  my $self = shift;
  my $persona_params = shift;
  my $nombres = $persona_params->{sexo}->valor eq 'f' ? $nombres_mujer : $nombres_hombre;
  my $nombre = Saga::azar($nombres);
  $persona_params->{nombre} = Persona::Valor->new({key => 'nombre', valor => $nombre});

}


1;
