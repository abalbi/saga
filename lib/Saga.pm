package Saga;
use strict;
use Data::Dumper;
our $srand = 24170986;
our $srand_asignado = 0;
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(azar t);

use Alteracion;
use Entorno;
use Entorno::Fabrica;
use Persona;
use Persona::Fabrica;
use Persona::Valor;
use Persona::Valor::Animo;
use Situacion;
use Situacion::Accion;
use Situacion::Actor;
use Situacion::Fabrica;

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

sub dt {
  my $datetime = shift;
  return DateTime::Format::Strptime->new(pattern => '%FT%T')->parse_datetime($datetime);
}

sub tiempo {
  my $fecha = shift;
  my $tiempo = shift;
  $tiempo =~ s/d/ * 24 * 60 * 60/g;
  return eval $tiempo;
}

1;
