package Persona;
use Data::Dumper;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);
use fields qw(
  _nombre
  _nacimiento 
  _sexo 
  _zodiaco 
  _ascendente_erotica 
  _cuerpo 
  _mente 
  _espiritu 
  _sentidos 
  _sociabilidad 
  _animo
  _positivos
  _negativos
);

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

sub sentidos {
  my $self = shift;;
  return $self->{_sentidos};
}

sub positivos {
  my $self = shift;;
  return $self->{_positivos};
}

sub negativos {
  my $self = shift;;
  return $self->{_negativos};
}

sub animo {
  my $self = shift;;
  return $self->{_animo};
}


sub sociabilidad {
  my $self = shift;;
  return $self->{_sociabilidad};
}

sub cuerpo {
  my $self = shift;;
  return $self->{_cuerpo};
}

sub mente {
  my $self = shift;;
  return $self->{_mente};
}

sub espiritu {
  my $self = shift;;
  return $self->{_espiritu};
}


sub ascendente_erotica {
  my $self = shift;;
  return $self->{_ascendente_erotica};
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

sub t {
  my $self = shift;
  my $key = shift;
  return Saga::t($self->$key,$self->sexo);  
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= sprintf("%s, %s, %s, %s, %s, %s", 
    $self->nombre, 
    $self->edad, 
    $self->zodiaco,
    $self->t('ascendente_erotica'),
    join(', ', map {Saga::t($_, $self->sexo)} @{$self->positivos}),
    join(', ', map {Saga::t($_, $self->sexo)} @{$self->negativos}),
    join(', ', map {"$_: ". $self->$_} qw(cuerpo mente espiritu sentidos sociabilidad animo)),
  );
  return $str;
}

1;
