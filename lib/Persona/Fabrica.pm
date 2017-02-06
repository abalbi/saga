package Persona::Fabrica;
use Data::Dumper;
use DateTime;
use DateTime::Event::Random;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);


our $ano_base = DateTime->now->year;
our $nombres_mujer  = [qw(Lucia Maria Martina Paula Daniela Sofia Valeria Carla Sara Alba Julia Noa Emma Claudia Carmen Marta Valentina Irene Adriana Ana Laura Elena Alejandra Ines Marina Vera Candela Laia Ariadna Lola Andrea Rocio Angela Vega Nora Jimena Blanca Alicia Clara Olivia Celia Alma Eva Elsa Leyre Natalia Victoria Isabel Cristina Lara Abril Triana Nuria Aroa Carolina Manuela Chloe Mia Mar Gabriela Mara Africa Iria Naia Helena Paola Noelia Nahia Miriam Salma)];
our $nombres_hombre = [qw(Hugo Daniel Pablo Alejandro Alvaro Adrian David Martin Mario Diego Javier Manuel Lucas Nicolas Marcos Leo Sergio Mateo Izan Alex Iker Marc Jorge Carlos Miguel Antonio Angel Gonzalo Juan Ivan Eric Ruben Samuel Hector Victor Enzo Jose Gabriel Bruno Dario Raul Adam Guillermo Francisco Aaron Jesus Oliver Joel Aitor Pedro Rodrigo Erik Marco Alberto Pau Jaime Asier Luis Rafael Mohamed Dylan Marti Ian Pol Ismael Oscar Andres Alonso Biel Rayan Jan Fernando Thiago Arnau Cristian Gael Ignacio Joan)];
our $positivos = [qw(accesible humilde activ[a|o] independiente adaptable intuitiv[a|o] afable inspirador[a|] afortunad[a|o] ingenios[a|o] alegre innovador[a|] apasionad[a|o] just[a|o] atrevid[a|o] leal bondados[a|o] logic[a|o] calmad[a|o] luchador[a|] caritativo meticulos[a|o] compasiv[a|o] modest[a|o] comunicativ[a|o] original con_iniciativa paciente concentrad[a|o] pacific[a|o] considerad[a|o] prudente constante profund[a|o] creativ[a|o] receptiv[a|o] curios[a|o] rect[a|o] decidid[a|o] reservad[a|o] discret[a|o] sensat[a|o] divertid[a|o] sensual divulgador[a|] sincer[a|o] ecuanime tenaz elegante tolerante emotiv[a|o] transigente energic[a|o] valiente espontane[a|o] veraz extrovertid[a|o] versatil generos[a|o] vital honest[a|o] voluntarios[a|o])];
our $negativos = [qw(aburrid[a|o] inconsciente agresiv[a|o] inconstante agri[a|o] indecis[a|o] apatic[a|o] indiscret[a|o] arrogante inhibid[a|o] artificios[a|o] inmoral autocompasiv[a|o] intolerante autoritario insensat[a|o] avaricios[a|o] lujurios[a|o] caprichos[a|o] malvad[a|o] celos[a|o] megaloman[a|o] chismos[a|o] mentiros[a|o] cobarde nervios[a|o] coleric[a|o] obsesiv[a|o] cruel oportunista dependiente ordinari[a|o] desconectad[a|o] pasiv[a|o] desconsiderad[a|o] pesimista distraid[a|o] presuntuos[a|o] egoista rencoros[a|o] envidios[a|o] rigid[a|o] fals[a|o] rutinari[a|o] fri[a|o] sadic[a|o] frivol[a|o] sanguinari[a|o] gafe simple hipocrita sumis[a|o] hermetic[a|o] susceptible impaciente superficial imprudente tiran[a|o] inadaptable triste inapropiad[a|o] vulnerable)];

sub hacer {
  my $self = shift;
  my $persona_params = {};
  $self->dar_nacimiento($persona_params);
  $self->dar_sexo($persona_params);
  $self->dar_nombre($persona_params);
  $self->dar_ascendente_erotica($persona_params);
  $self->dar_aptitudes($persona_params);
  $self->dar_animo($persona_params);
  $self->dar_rasgos($persona_params);
  my $persona = Persona->new($persona_params);
  return $persona;
}

sub dar_rasgos {
  my $self = shift;
  my $persona_params = shift;
  $persona_params->{positivos} = [];
  $persona_params->{negativos} = [];
  my $numero = $persona_params->{animo};
  my $rasgos = [];
  $rasgos = [2,1] if $numero == 4;
  $rasgos = [1,1] if $numero == 5;
  $rasgos = [1,2] if $numero == 6;
  $rasgos = [1,3] if $numero == 7;
  my $c = 1;
  while ($rasgos->[0] >= $c) {
    push @{$persona_params->{negativos}}, Saga::azar($negativos);
    $c++;
  }
  my $c = 1;
  while ($rasgos->[1] >= $c) {
    push @{$persona_params->{positivos}}, Saga::azar($positivos);
    $c++;
  }
}


sub dar_animo {
  my $self = shift;
  my $persona_params = shift;
  my $numero = $persona_params->{espiritu};
  my $valor;
  $valor = 4 if $numero >= 1;
  $valor = 5 if $numero >= 2;
  $valor = 6 if $numero >= 4;
  $valor = 7 if $numero >= 7;
  $persona_params->{animo} = $valor;
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
  $persona_params->{cuerpo}   = $valores->[0];
  $persona_params->{mente}    = $valores->[1];
  $persona_params->{espiritu} = $valores->[2];
  $persona_params->{sentidos} = int (($persona_params->{cuerpo} + $persona_params->{mente})/2);
  $persona_params->{sociabilidad} = int (($persona_params->{mente} + $persona_params->{espiritu})/2);
}

sub dar_ascendente_erotica {
  my $self = shift;
  my $persona_params = shift;
  my $ascendentes = [qw(romantic[a|o] fogos[a|o] bizarr[a|o] depravad[a|o])];
  $persona_params->{ascendente_erotica} = Saga::azar($ascendentes);  
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
  $persona_params->{nacimiento} = $dt->datetime;
  $persona_params->{zodiaco} = zodiac_of($dt);
}

sub dar_sexo {
  my $self = shift;
  my $persona_params = shift;
  $persona_params->{sexo} = Saga::azar([qw(f m)]);
}

sub dar_nombre {
  my $self = shift;
  my $persona_params = shift;
  my $nombres = $persona_params->{sexo} eq 'f' ? $nombres_mujer : $nombres_hombre;
  my $nombre = Saga::azar($nombres);
  $persona_params->{nombre} = $nombre;
}


1;
