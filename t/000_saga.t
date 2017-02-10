use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Saga" => sub {
  context "Saga::azar" => sub {
    context "CUANDO ejecuto el azar de Util con un numero" => sub {
      my $valor = azar(10);
      it "ENTONCES el hacer me debe devolver un numero mejor o igual al enviado" => sub {
        cmp_ok $valor, '<=', 10;
      };
    };

    context "CUANDO ejecuto el azar de Util sin parametro" => sub {
      my $valor = azar();
      it "ENTONCES debe devolver un undef" => sub {
        is $valor, undef;
      };
    };

    context "CUANDO ejecuto el azar de Util con una ref a un array" => sub {
      my $valor = azar([qw(a b c)]);
      it "ENTONCES el hacer me debe devolver un elemento del array" => sub {
        cmp_deeply $valor, any(qw(a b c));
      };
    };
  };
  context "Saga::load" => sub {
    context "CUANDO ejecuto el azar de Util con un numero" => sub {
      Saga::load('Libido');
      it "ENTONCES el hacer me debe devolver un numero mejor o igual al enviado" => sub {
        
      };
    };
  };

};


