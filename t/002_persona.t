use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;
Saga::load('Libido');

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Persona" => sub {
  context "Persona::new" => sub {
    context "CUANDO tengo una nueva persona con nombre" => sub {
      my $persona = Saga::despachar('Persona')->new(nombre => 'Juana');
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is $persona->nombre, 'Juana';
      };
    };
  };
  context "Persona::AUTOLOAD" => sub {
    context "CUANDO tengo una nueva persona con nombre" => sub {
      my $persona = Saga::despachar('Persona')->new(nombre => 'Juana', animo => 1, sexo => 'f');
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        is $persona->nombre, 'Juana';
        is $persona->animo, 1;
        is $persona->nombre->t, 'Juana';
      };
    };
  };
  context "Persona::tiene" => sub {
    context "CUANDO tengo una nueva persona con nombre" => sub {
      my $persona = Saga::despachar('Persona')->new(nombre => 'Juana', animo => 1, sexo => 'f');
      it "ENTONCES debe decirme si tiene o no tiene atributos" => sub {
        ok $persona->tiene('nombre');
        is $persona->tiene('no_tiene'), 0;
      };
    };
  };
  context "Persona::edad" => sub {
    context "CUANDO tengo una nueva persona con nacimiento" => sub {
      my $nacimiento = DateTime->new(year => 1970);
      my $persona = Saga::despachar('Persona')->new(nombre => 'Juana', nacimiento => $nacimiento->datetime, sexo => 'f');
      it "ENTONCES debe decirme la edad y el zodiaco" => sub {
        ok $persona->nacimiento;
        is $persona->edad, int((Saga::dt(Saga::fecha_base())->epoch + $nacimiento->epoch)/(60*60*24*365));
        is $persona->zodiaco, 'capricornus';
      };
    };
  };
};


