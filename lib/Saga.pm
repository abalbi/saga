package Saga;
use strict;
use Data::Dumper;
our $srand = 24170986;
our $srand_asignado = 0;
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(azar t);

use Core::Alteracion;
use Core::Entorno;
use Core::Entorno::Fabrica;
use Core::Persona;
use Core::Persona::Fabrica;
use Core::Persona::Valor;
use Core::Persona::Valor::Animo;
use Core::Persona::Valor::Rasgos;
use Core::Situacion;
use Core::Situacion::Actor;
use Core::Situacion::Fabrica;


sub load {
  my $modulo = shift;
  require $modulo . '/Loader.pm';
}

sub fecha_base {
  return DateTime->now->datetime;
}

sub params {
  my $params = {@_} if scalar @_ > 1;
  $params = shift if scalar @_ == 1;
  return $params;
}

sub t {
  my $valor = shift;
  my $sexo = shift;
  if(ref $valor eq 'ARRAY') {
    return join ', ', map {
      if(ref $_ eq 'HASH'){
        Saga::t($_->{key}, $sexo) . ": " . Saga::t($_->{valor}, $sexo)
      } else {
        Saga::t($_, $sexo)
      }
    } @{$valor};
  }
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

sub dt {
  my $datetime = shift;
  return DateTime::Format::Strptime->new(pattern => '%FT%T')->parse_datetime($datetime);
}

sub tiempo {
  my $tiempo = shift;
  $tiempo =~ s/d/ * 24 * 60 * 60/g;
  $tiempo =~ s/y/ * 365 * 24 * 60 * 60/g;
  return eval $tiempo;
}

1;
