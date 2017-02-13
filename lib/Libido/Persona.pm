package Persona;
use strict;
use Data::Dumper;
use DateTime::Format::Strptime;
use Zodiac::Tiny qw(zodiac_of);
use fields qw();


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
  return zodiac_of(Saga::dt($self->nacimiento));
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
