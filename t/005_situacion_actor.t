use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;
Saga::load('Libido');
#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Situacion::Actor" => sub {
  context "Situacion::Actor::AUTOLOAD" => sub {
    context "CUANDO tengo un actor y pido un atributo de la persona" => sub {
      my $entorno = Entorno->new;
      my $persona = Persona::Fabrica->hacer;
      my $fecha = DateTime->now;
      my $animo_persona = $persona->animo;
      my $actor = Situacion::Actor->new({
        entorno => $entorno,
        persona => $persona,
        fecha => $fecha->datetime,
      });
      it "ENTONCES debe devolverme el valor del atributo de la persona" => sub {
        is $actor->animo, $animo_persona;
      };
    };
    context "CUANDO tengo un actor y le asigno un atributo de la persona" => sub {
      my $entorno = Entorno->new;
      my $persona = Persona::Fabrica->hacer;
      my $animo_persona = $persona->animo;
      my $fecha = DateTime->now;
      my $actor = Situacion::Actor->new({
        entorno => $entorno,
        persona => $persona,
        fecha => $fecha->datetime,
      });
      $actor->animo(8);
      it "ENTONCES debe devolverme el valor del actor sin alterar a la persona" => sub {
        ok $actor->animo != $persona->animo;
        is $persona->animo, $animo_persona;
        is $actor->animo, 8;
      };
    };
    context "CUANDO tengo un actor y le asigno un atributo que no tiene la persona" => sub {
      my $entorno = Entorno->new;
      my $persona = Persona::Fabrica->hacer;
      my $animo_persona = $persona->animo;
      my $fecha = DateTime->now;
      my $actor = Situacion::Actor->new({
        entorno => $entorno,
        persona => $persona,
        fecha => $fecha->datetime,
      });
      $actor->puntos_placer(8);
      it "ENTONCES debe devolverme el valor del atributo del actor" => sub {
        is $actor->puntos_placer, 8;
      };
    };
  };

};


