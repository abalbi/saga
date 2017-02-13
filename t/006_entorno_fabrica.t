use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;
#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover
Saga::load('Libido');

describe "Entorno::Fabrica" => sub {
  context "Entorno::Fabrica::hacer" => sub {
    context "CUANDO ejecuto hacer" => sub {
      my $entorno = Entorno::Fabrica->hacer;
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $entorno, 'Entorno';
      };
    };
  };
};


