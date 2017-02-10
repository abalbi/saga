use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Situacion::Fabrica" => sub {
  context "Situacion::Fabrica::hacer" => sub {
    context "CUANDO ejecuto hacer" => sub {
      my $entorno = Entorno->new;
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer($entorno, {fecha => $fecha->datetime});
      it "ENTONCES debe devolverme una Situacion con los parametros definidos" => sub {
        isa_ok $situacion, 'Situacion';
      };
    };
  };
  context "Situacion::Fabrica::hacer_actores" => sub {
    context "CUANDO hago actores con parametros" => sub {
      my $params = {};
      my $personas = [
        Persona::Fabrica->hacer,
        Persona::Fabrica->hacer,
      ];
      my $actores = Situacion::Fabrica->hacer_actores($personas);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is scalar @{$actores}, 2;
      };
    };
    context "CUANDO hago actores con parametros y entorno" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $personas = [Persona::Fabrica->hacer];
      my $actores = Situacion::Fabrica->hacer_actores($personas, $entorno);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is scalar @{$actores}, 2;
      };
    };
  };
  context "Situacion::Fabrica::hacer_situacion" => sub {
    context "CUANDO hago una situacion" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $actores = Situacion::Fabrica->hacer_actores([
        Persona::Fabrica->hacer,
      ], $entorno);
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer_situacion($entorno, $actores, $fecha);
      it "ENTONCES debe devolver un situacion" => sub {
        is $situacion->fecha, $fecha->datetime;
        is $situacion->actores, $actores;
        is $situacion->entorno, $entorno;
      };
    };
  };
  context "Situacion::Fabrica::hacer_calentando_motores" => sub {
    context "CUANDO hago un hacer_calentando_motores" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $actores = Situacion::Fabrica->hacer_actores([
        Persona::Fabrica->hacer,
      ], $entorno);
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer_situacion($entorno, $actores, $fecha);
      Situacion::Fabrica->hacer_calentando_motores($situacion);
      it "ENTONCES debe devolver un situacion" => sub {
        ok scalar @{$situacion->log};
      };
    };
  };
  context "Situacion::Fabrica::hacer_a_toda_maquina" => sub {
    context "CUANDO hago un hacer_a_toda_maquina" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $actores = Situacion::Fabrica->hacer_actores([
        Persona::Fabrica->hacer,
      ], $entorno);
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer_situacion($entorno, $actores, $fecha);
      Situacion::Fabrica->hacer_a_toda_maquina($situacion);
      it "ENTONCES debe devolver un situacion" => sub {
        ok scalar @{$situacion->log};
      };
    };
  };
  context "Situacion::Fabrica::hacer_subidon_final" => sub {
    context "CUANDO hago un hacer_subidon_final" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $actores = Situacion::Fabrica->hacer_actores([
        Persona::Fabrica->hacer,
      ], $entorno);
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer_situacion($entorno, $actores, $fecha);
      Situacion::Fabrica->hacer_subidon_final($situacion);
      it "ENTONCES debe devolver un situacion" => sub {
        ok scalar @{$situacion->log};
      };
    };
  };
  context "Situacion::Fabrica::hacer_petite_morte" => sub {
    context "CUANDO hago un hacer_petite_morte" => sub {
      my $params = {};
      my $entorno = Entorno->new;
      my $persona = Persona::Fabrica->hacer;
      my $actores = Situacion::Fabrica->hacer_actores([$persona], $entorno);
      my $fecha = DateTime->now;
      my $situacion = Situacion::Fabrica->hacer_situacion($entorno, $actores, $fecha);
      $actores->[0]->puntos_placer(56);
      Situacion::Fabrica->hacer_petite_morte($situacion);
      it "ENTONCES debe devolver un situacion" => sub {
        ok scalar @{$situacion->log};
        ok scalar @{$persona->animo->alteraciones};
        ok $persona->animo->temporal != $persona->animo;
      };
    };
  };

};


