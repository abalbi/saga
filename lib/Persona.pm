package Persona;
use Want;
use strict;
use Data::Dumper;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);
use fields qw(
  _items
  _entorno
);

sub new {
  my $class = shift;
  my $params = shift || {};
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  $self->{_items} = [];
  foreach my $key (sort keys %$params) {
    my $valor = $params->{$key};
    $valor = Persona::Valor->new({key => $key, valor => $valor}) if not ref $valor;
    die "$key = $valor no es un Persona::Valor" if ref $valor eq 'ARRAY';
    die "$key = $valor no es un Persona::Valor" if ref $valor eq 'HASH';
    die "$key = $valor no es un Persona::Valor" if !$valor->isa('Persona::Valor');
    push @{$self->{_items}}, $valor;
    $valor->persona($self);
  }
  $self;
}

our $AUTOLOAD;

sub AUTOLOAD {
  my $method = $AUTOLOAD;
  my $self = shift;
  my $fecha = shift;
  $fecha = Saga::dt($fecha) if defined $fecha;
  $method =~ s/.*:://;
  my $crv = $Contextual::Return::Value;
  my $propiedad = $method;
  foreach my $item (@{$self->items}) {
    if($item->key eq $propiedad) {
      return $item if want('OBJECT');
      return $item->valor($fecha);
    }
  }
  die "No se encontro Persona::$propiedad";
}

sub tiene {
  my $self = shift;
  my $propiedad = shift;
  my $tiene = scalar grep {$_->key eq $propiedad} @{$self->items};
  return $tiene ? 1 : 0;
}

sub items {
  my $self = shift;
  return $self->{_items};  
}

sub entorno {
  my $self = shift;
  my $entorno = shift;
  $self->{_entorno} = $entorno if defined $entorno;
  return $self->{_entorno};  
}


sub nacimiento {
  my $self = shift;
  my $nacimiento = [grep {$_->key eq 'nacimiento'} @{$self->items}]->[0];
  return $nacimiento->valor;
}

sub edad {
  my $self = shift;
  return $Persona::Fabrica::ano_base - Saga::dt($self->nacimiento)->year;
}

sub zodiaco {
  my $self = shift; 
  return zodiac_of($self->nacimiento)
}

sub alterar {
  my $self = shift; 
  my $params = shift;
  my $alteracion = Alteracion->new({
    persona => $self,
    fecha => $params->{fecha},
    alteracion => $params->{alteracion},
    key => $params->{key},
    temporal => $params->{temporal},
    duracion => $params->{duracion},
  });
  push @{$self->entorno->items}, $alteracion;

}

sub t {
  my $self = shift;
  my $key = shift;
  return Saga::t($self->$key,$self->sexo);  
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= sprintf("%s, %s\n%s, %s, %s,\n%s,\n%s\n", 
    $self->nombre,
    $self->edad, 
    $self->ascendente_erotica->t,
    $self->positivos->t,
    $self->negativos->t,
    $self->acentos->t,
    join(', ', map {"$_: ". $self->$_} qw(cuerpo mente espiritu sentidos sociabilidad animo)),
  );
  return $str;
}

1;
