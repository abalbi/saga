package Saga;
use strict;
use Data::Dumper;
use DateTime;
use DateTime::Format::Strptime;
our $srand = 24170986;
our $srand_asignado = 0;
use Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(azar t);
use Log::Log4perl;

use Core::Alteracion;
use Core::Entorno;
use Core::Entorno::Fabrica;
use Core::Persona;
use Core::Persona::Fabrica;
use Core::Persona::Valor;
use Core::Situacion;
use Core::Situacion::Actor;
use Core::Situacion::Fabrica;

our $modulo = undef;
our $mapa = {};

Log::Log4perl->init("log.conf");

sub logger {
  return Log::Log4perl->get_logger(__PACKAGE__);
}

sub despachar {
  my $pkg = shift;
  my $objeto;
  my $clase;
  return $mapa->{$pkg} if exists $mapa->{$pkg};
  if(not defined $clase) {
    if(defined $modulo) {
      eval "use ".$modulo."::".$pkg.";" if not defined $clase && defined $modulo;
      if(!$@) {
        $clase = "$modulo::$pkg";
      } else {
        logger()->warn("No se encontro $modulo::$pkg")  
      }
    }
    $clase = $pkg if not defined $clase;
  }
  $mapa->{$pkg} = $clase;
  logger()->trace("Despachando... $clase");
  return $clase;
}

sub load {
  $modulo = shift;
  $mapa = {};
  my $dirname = "./lib/$modulo/Situacion";
  logger()->info("Cargando modulo $modulo");
  opendir ( DIR, $dirname ) || die "Error in opening dir $dirname\n";
  while( (my $filename = readdir(DIR))){
    next if $filename =~ /^\.+$/;
    $filename =~ s/\.pm//;
    despachar('Situacion::'.$filename);
  }
  closedir(DIR);
}

sub barra {
  my $valor = shift;
  return $valor if $valor !~ /^\d+$/;
  my $tamano = shift;
  return ('=' x $valor).(' ' x ($tamano - $valor));
}

sub fecha_base {
  return DateTime->now->datetime;
}

sub params {
  my (@params) = @_; 
  my $params;
  if(scalar @params == 1 && ref $params[0] eq 'HASH') {
    $params = $params[0];
  } elsif (scalar @params > 1 && !ref $params[0]) {
    $params = {@params};
  }
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

sub codes2seg {
  my $codes = shift;
  my $seg = $codes;
  $seg =~ s/d/ * 24 * 60 * 60/g;
  $seg =~ s/y/ * 365 * 24 * 60 * 60/g;
  $seg = eval $seg;
  return $seg;
}

sub seg2codes {
  my $total = shift;
  my $seg = $total;
  return $seg . 's' if $seg <= 59;
  my $min = 0;
  while($seg > 59) {
    $min++;
    $seg -= 60;
  }
  return $min .'m '.$seg.'s'
}
1;
