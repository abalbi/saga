use strict;

package Saga;
use Data::Dumper;
our $srand = 24170986;
our $srand_asignado = 0;

sub t {
  my $valor = shift;
  my $sexo = shift;
  my $str = $valor;
  $str =~ /\[(\w*)\|(\w*)\]/;
  if(defined $sexo) {
    my $r;
    $r = $1 if $sexo eq 'f';
    $r = $2 if $sexo eq 'm';
    $str =~ s/\[\w*\|\w*\]/$r/;
  }
  $str =~ s/_/ /g;
  return $str;
}
1;

sub saga_srand {
  if(!$srand_asignado) {
    srand($srand);
    $srand_asignado = 1;
  }
  return $srand;
}

sub azar {
  my $valor = shift;
  my $cantidad = shift;
  saga_srand();
  return $valor->[int rand scalar @$valor] if ref $valor eq 'ARRAY' && not defined $cantidad; 
  if (ref $valor eq 'ARRAY') {
    my @items;
    while(scalar @items != $cantidad){
      my $item = $valor->[int rand scalar @$valor];
      if(scalar @items != 0){
        next if scalar grep {$_ eq $item} @items;
      }
      push @items, $item;
    }
    return @items;
  }
  return int rand $valor + 1 if $valor =~ /^\d+$/;
  return undef;
}

1;


package Situacion::Fabrica;

sub hacer {
  my $self = shift;
  my $entorno = shift;

}

1;

package Situacion;
use Data::Dumper;
use fields qw();

sub new {
  my $class = shift;
  my $params = shift || {};
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}
1;


package Persona;
use Data::Dumper;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);
use fields qw(_nombre _nacimiento _sexo _virtudes _defectos _zodiaco);

sub new {
  my $class = shift;
  my $params = shift || {};
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}

sub nombre {
  my $self = shift;;
  return $self->{_nombre};
}

sub sexo {
  my $self = shift;;
  return $self->{_sexo};
}


sub virtudes {
  my $self = shift;;
  return $self->{_virtudes};
}

sub defectos {
  my $self = shift;;
  return $self->{_defectos};
}


sub nacimiento {
  my $self = shift;
  return DateTime::Format::Strptime->new(pattern => '%FT%T')->parse_datetime($self->{_nacimiento});
}

sub edad {
  my $self = shift;
  return $Persona::Fabrica::ano_base - $self->nacimiento->year;
}

sub zodiaco {
  my $self = shift;
  return zodiac_of($self->nacimiento)
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= sprintf("%s, %s, %s, %s, %s", 
    $self->nombre, 
    $self->edad, 
    $self->zodiaco,
    join ', ', map {Saga::t($_, $self->sexo)} @{$self->virtudes},
    join ', ', map {Saga::t($_, $self->sexo)} @{$self->defectos},
  );
  return $str;
}

1;

package Persona::Fabrica;
use Data::Dumper;
use DateTime;
use DateTime::Event::Random;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);


our $ano_base = DateTime->now->year;
our $nombres_mujer  = [qw(Lucia Maria Martina Paula Daniela Sofia Valeria Carla Sara Alba Julia Noa Emma Claudia Carmen Marta Valentina Irene Adriana Ana Laura Elena Alejandra Ines Marina Vera Candela Laia Ariadna Lola Andrea Rocio Angela Vega Nora Jimena Blanca Alicia Clara Olivia Celia Alma Eva Elsa Leyre Natalia Victoria Isabel Cristina Lara Abril Triana Nuria Aroa Carolina Manuela Chloe Mia Mar Gabriela Mara Africa Iria Naia Helena Paola Noelia Nahia Miriam Salma)];
our $nombres_hombre = [qw(Hugo Daniel Pablo Alejandro Alvaro Adrian David Martin Mario Diego Javier Manuel Lucas Nicolas Marcos Leo Sergio Mateo Izan Alex Iker Marc Jorge Carlos Miguel Antonio Angel Gonzalo Juan Ivan Eric Ruben Samuel Hector Victor Enzo Jose Gabriel Bruno Dario Raul Adam Guillermo Francisco Aaron Jesus Oliver Joel Aitor Pedro Rodrigo Erik Marco Alberto Pau Jaime Asier Luis Rafael Mohamed Dylan Marti Ian Pol Ismael Oscar Andres Alonso Biel Rayan Jan Fernando Thiago Arnau Cristian Gael Ignacio Joan)];
our $signos = {
  aries => {
    orden => 1,
    compatibilidad => [qw(4 3 4 3 5 1 2 2 5 2 4 1)],
    elemento => 'fire',
    lema => 'Yo soy',
    virtudes => [qw(
      pioner[a|o]
      ejecutiv[a|o]
      emprendedor[a|]
      direct[a|o]
      energic[a|o]
      guerrer[a|o]
      valiente
    )],
    defectos => [qw(
      egoista
      agresiv[a|o]
      impulsiv[a|o]
      irreflexiv[a|o]
      altaner[a|o]
      dominante
      inconstante
    )],
  },
  taurus => {
    orden => 2,
    compatibilidad => [qw(3 5 1 4 3 5 2 2 1 5 2 4)],
    elemento => 'earth',
    lema => 'Yo tengo',
    virtudes => [qw(
      afectuos[a|o]
      estable
      paciente
      reflexiv[a|o]
      imperturbable
      tenaz
      sensual
    )],
    defectos => [qw(
      brutal
      lent[a|o]
      materialista
      obstinad[a|o]
      posesiv[a|o]
      terc[a|o]
      tedios[a|o]
    )],
  },
  gemini => {
    orden => 3,
    compatibilidad => [qw(4 1 5 1 4 2 5 1 3 2 5 1)],
    elemento => 'air',
    lema => 'Yo pienso',
    virtudes => [qw(
      comunicativ[a|o]
      elocuente
      versatil
      intelectual
      amigable
      polifacetic[a|o]
      ingenios[a|o]
    )],
    defectos => [qw(
      curios[a|o]
      nervios[a|o]
      superficial
      inconstante
      chismos[a|o]
      parlanchin
      dispers[a|o]
    )],
  },
  cancer => {
    orden => 4,
    compatibilidad => [qw(2 4 3 5 3 4 1 5 2 4 2 5)],
    elemento => 'water',
    lema => 'Yo siento',
    virtudes => [qw(
      hogareni[a|o]
      maternal
      nutritiv[a|o]
      romantic[a|o]
      emotiv[a|o]
      sensible
      familiar
    )],
    defectos => [qw(
      contradictori[a|o]
      repetitiv[a|o]
      indirect[a|o]
      lloron[a|]
      susceptible
      timid[a|o]
      vulnerable
    )],
  },
  leo => {
    orden => 5,
    compatibilidad => [qw(5 3 4 3 5 1 4 3 5 2 2 3)],
    elemento => 'fire',
    lema => 'Yo hago',
    virtudes => [qw(
      creativ[a|o]
      lider
      elegante
      estratega
      organizador[a|]
      valiente
      noble
    )],
    defectos => [qw(
      soberbi[a|o]
      dominante
      dramatic[a|o]
      orgullos[a|o]
      exhibicionista
      fanfarron[a|]
      prepotente
    )],
  },
  virgo => {
    orden => 6,
    compatibilidad => [qw(1 5 2 4 1 5 2 4 1 5 2 2)],
    elemento => 'earth',
    lema => 'Yo analizo',
    virtudes => [qw(
      estudios[a|o]
      detallista
      ordenad[a|o]
      pulcr[a|o]
      servicial
      analitic[a|o]
      diligente
    )],
    defectos => [qw(
      aprensiv[a|o]
      critic[a|o]
      quisquillos[a|o]
      escrupulos[a|o]
      exigente
      perfeccionista
      intolerante
    )],
  },
  libra => {
    orden => 7,
    compatibilidad => [qw(3 3 5 1 4 2 5 2 4 2 5 3)],
    elemento => 'air',
    lema => 'Yo busco',
    virtudes => [qw(
      diplomatic[a|o]
      just[a|o]
      refinad[a|o]
      pacific[a|o]
      sutil
      estetic[a|o]
      gentil
    )],
    defectos => [qw(
      indecis[a|o]
      comod[a|o]
      dulcer[a|o]
      desorientad[a|o]
      insegur[a|o]
      caprichos[a|o]
      acomodatici[a|o]
    )],
  },
  scorpius => {
    orden => 8,
    compatibilidad => [qw(3 3 1 5 3 4 2 5 2 4 2 5)],
    elemento => 'water',
    lema => 'Yo deseo',
    virtudes => [qw(
      agud[a|o]
      magnetic[a|o]
      apasionad[a|o]
      perspicaz
      profund[a|o]
      secretiv[a|o]
      astut[a|o]
    )],
    defectos => [qw(
      celos[a|o]
      sexual
      misterios[a|o]
      extremista
      vengativ[a|o]
      violent[a|o]
      obsesiv[a|o]
    )],
  },
  sagittarius => {
    orden => 9,
    compatibilidad => [qw(5 1 3 2 5 1 4 2 5 1 4 2)],
    elemento => 'fire',
    lema => 'Yo veo',
    virtudes => [qw(
      afortunad[a|o]
      alegre
      expansiv[a|o]
      filosofic[a|o]
      generos[a|o]
      optimista
      sincer[a|o]
    )],
    defectos => [qw(
      autoritari[a|o]
      descuidad[a|o]
      exagerad[a|o]
      irresponsable
      parrander[a|o]
      confianzud[a|o]
      amiguer[a|o]
    )],
  },
  capricornus => {
    orden => 10,
    compatibilidad => [qw(3 5 2 4 2 5 2 4 1 5 2 4)],
    elemento => 'earth',
    lema => 'Yo utilizo',
    virtudes => [qw(
      discret[a|o]
      eficiente
      estructurad[a|o]
      perseverante
      responsable
      seri[a|o]
      planificador[a|]
    )],
    defectos => [qw(
      ambicios[a|o]
      calculador[a|]
      solirati[a|o]
      fri[a|o]
      manipulador[a|]
      pesimista
      sever[a|o]
    )],
  },
  aquarius => {
    orden => 11,
    compatibilidad => [qw(4 2 5 2 2 2 5 2 4 2 5 3)],
    elemento => 'air',
    lema => 'Yo conosco',
    virtudes => [qw(
      fraternal
      humanitari[a|o]
      reformador[a|]
      inventiv[a|o]
      innovador[a|]
      progresista
      independiente
    )],
    defectos => [qw(
      excentric[a|o]
      sabelotod[a|o]
      utopic[a|o]
      inconvencional
      desapegad[a|o]
      rebelde
      revolucionari[a|o]
    )],
  },
  pisces => {
    orden => 12,
    compatibilidad => [qw(1 4 1 5 3 2 3 5 2 4 3 5)],
    elemento => 'water',
    lema => 'Yo creo',
    virtudes => [qw(
      compasiv[a|o]
      mistic[a|o]
      sacrificad[a|o]
      piados[a|o]
      tolerante
      humilde
      intuitiv[a|o]
    )],
    defectos => [qw(
      confus[a|o]
      evasiv[a|o]
      imprecis[a|o]
      soñador[a|]
      fanatic[a|o]
      vicios[a|o]
      credul[a|o]
    )],
  },
};


sub hacer {
  my $self = shift;
  my $persona_params = {};
  $self->dar_nacimiento($persona_params);
  $self->dar_sexo($persona_params);
  $self->dar_nombre($persona_params);
  $self->dar_virtudes($persona_params);
  $self->dar_defectos($persona_params);
  my $persona = Persona->new($persona_params);
  return $persona;
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

sub dar_virtudes {
  my $self = shift;
  my $persona_params = shift;
  my $virtudes = [];
  push @$virtudes, Saga::azar($signos->{$persona_params->{zodiaco}}->{virtudes},2);
  $persona_params->{virtudes} = $virtudes;
}

sub dar_defectos {
  my $self = shift;
  my $persona_params = shift;
  my $defectos = [];
  push @$defectos, Saga::azar($signos->{$persona_params->{zodiaco}}->{defectos},2);
  $persona_params->{defectos} = $defectos;
}

1;

package Entorno;
use fields qw(_items);
sub new {
  my $class = shift;
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  $self->{_items} = [];
  $self;
}

sub cantidad_personas {
  my $self = shift;
  return 6;
}

sub items {
  my $self = shift;
  return $self->{_items};  
}

sub personas {
  my $self = shift;
  return [grep {$_->isa('Persona')} @{$self->items}];
}

sub describir {
  my $self = shift;
  my $str = '';
  foreach my $persona (@{$self->personas}) {
    $str .= $persona->describir."\n";
  }
  return $str;
}
1;

package Entorno::Fabrica;
sub hacer {
  my $self = shift;
  my $entorno = shift;
  $entorno = Entorno->new;
  my $cantidad_personas = 0;
  while ($entorno->cantidad_personas > $cantidad_personas) {
    my $persona = Persona::Fabrica->hacer;
    push @{$entorno->items}, $persona;
    $cantidad_personas = scalar @{$entorno->personas};
    Situacion::Fabrica->hacer($entorno, {sujeto => $persona});
  }
  return $entorno;
}
1;


use Data::Dumper;
my $entorno = Entorno::Fabrica->hacer();
print $entorno->describir;