package Persona;
use Want;
use strict;
use Data::Dumper;
use fields qw(_items _entorno);

sub new {
  my $class = shift;
  my $params;
  if(scalar @_) {
    if(ref $_[0] eq 'HASH') {
      $params = $_[0];
    } else {
      $params = {@_};
    }

  }
  my $self = fields::new($class);
  $self->{_items} = [];
  foreach my $key (sort keys %$params) {
    next if $key eq 'entorno';
    my $valor = $params->{$key};
    $valor = Saga::despachar('Persona::Valor')->new({key => $key, valor => $valor}) if not ref $valor;
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

sub alterar {
  my $self = shift;
  my $params = shift;
  my $key = $params->{key};
  $self->$key->alterar($params);
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= sprintf("%s, %s\n%s, %s\n%s,\n%s,\n%s\n", 
    $self->nombre,
    $self->edad, 
    $self->ascendente_erotica->t,
    $self->rasgos->t,
    $self->acentos->t,
    join(', ', map {"$_: ". $self->$_} qw(cuerpo mente espiritu sentidos sociabilidad animo)),
  );
  return $str;
}

1;
