use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;
Saga::load('Libido');
#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Situacion::Fabrica" => sub {
  context "Situacion::Fabrica::hacer" => sub {
    context "CUANDO ejecuto hacer" => sub {
      my $entorno = Entorno->new;
      my $fecha = DateTime->now;
      my $situacion = Saga::despachar('Situacion::Fabrica')->hacer(entorno => $entorno, fecha => $fecha->datetime);
      it "ENTONCES debe devolverme una Situacion con los parametros definidos" => sub {
        isa_ok $situacion, 'Situacion';
      };
    };
  };
  context "Situacion::Fabrica::hacer_actores" => sub {
    context "CUANDO hago actores con parametros" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $fecha = DateTime->now;
      my $situacion = Saga::despachar('Situacion::Fabrica')->hacer(entorno => $entorno, fecha => $fecha->datetime);
      my $personas = [
        Saga::despachar('Persona::Fabrica')->hacer,
        Saga::despachar('Persona::Fabrica')->hacer,
      ];
      my $actores = $situacion->hacer_actores($personas);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is scalar @{$actores}, 2;
      };
    };
    context "CUANDO hago actores con parametros y entorno" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $fecha = DateTime->now;
      my $situacion = Saga::despachar('Situacion::Fabrica')->hacer(entorno => $entorno, fecha => $fecha->datetime);
      my $personas = [Saga::despachar('Persona::Fabrica')->hacer];
      my $actores = $situacion->hacer_actores($personas);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is scalar @{$actores}, 2;
      };
    };
  };
  context "Situacion::Fabrica::hacer_situacion" => sub {
    context "CUANDO hago una situacion" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $fecha = DateTime->now;
      my $situacion = Saga::despachar('Situacion::Fabrica')->hacer_situacion($entorno, $fecha, 'Libido::Situacion::Seduccion');
      it "ENTONCES debe devolver un situacion" => sub {
        is $situacion->fecha, $fecha->datetime;
        is $situacion->entorno, $entorno;
      };
    };
  };

};


