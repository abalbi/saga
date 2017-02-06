use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Entorno::Fabrica" => sub {
  context "CUANDO ejecuto hacer" => sub {
    my $entorno = Entorno::Fabrica->hacer();
    it "ENTONCES el hacer me debe devolver recibir un entorno" => sub {
      isa_ok $entorno, 'Entorno';
    };
  };
};


