use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Persona" => sub {
  context "CUANDO tengo una nueva persona con nombre" => sub {
    my $persona = Persona->new({nombre => 'Melissa'});
    it "ENTONCES el hacer me debe devolver recibir un entorno" => sub {
      is $persona->nombre, 'Melissa';
    };
  };
};


