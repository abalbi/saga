use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Persona::Valor" => sub {
  context "Persona::Valor::new" => sub {
    context "CUANDO tengo un nuevo valor con params en un hash" => sub {
      my $valor = Persona::Valor->new({key => 'key', valor => 3});
      it "ENTONCES debe devolverme un valor con los parametros definidos" => sub {
        is $valor->key, 'key';
        is $valor->valor, 3;
      };
    };
  };
  context "Persona::Valor::new" => sub {
    context "CUANDO tengo un nuevo valor con params en un hash" => sub {
      my $valor = Persona::Valor->new(key => 'key');
      it "ENTONCES debe devolverme un valor con los parametros definidos" => sub {
        is $valor->key, 'key';
      };
    };
  };
  context "Persona::Valor::normalizar" => sub {
    context "CUANDO normalizo un valor" => sub {
      my $valor = Persona::Valor->new();
      it "ENTONCES debe devolverme ese mismo valor" => sub {
        is $valor->normalizar(3), 3;
      };
    };
  };
  context "Persona::Valor::alteraciones" => sub {
    context "alteraciones numericas" => sub {
      context "CUANDO cuando agrego alteraciones" => sub {
        my $valor = Persona::Valor->new(valor => 2);
        $valor->alterar({fecha => DateTime->new(year => 1990)->datetime, alteracion => '+3'});
        $valor->alterar({fecha => DateTime->new(year => 2000)->datetime, alteracion => '+3'});
        it "ENTONCES el valor se debe alterar segun la fecha" => sub {
          is $valor->valor, 8;
          is $valor->valor(DateTime->new(year => 1980)->datetime), 2;
          is $valor->valor(DateTime->new(year => 1991)->datetime), 5;
          is $valor->valor(DateTime->new(year => 2001)->datetime), 8;
        };
      };
      context "CUANDO cuando agrego alteraciones a temporales" => sub {
        my $valor = Persona::Valor->new(valor => 2);
        $valor->alterar({fecha => DateTime->new(year => 1990)->datetime, alteracion => '+4', temporal => 1}),
        $valor->alterar({fecha => DateTime->new(year => 2000)->datetime, alteracion => '+3'});
        it "ENTONCES el valor se debe alterar segun la fecha" => sub {
          is $valor->valor,    5;
          is $valor->temporal, 6;
        };
      };
      context "CUANDO cuando agrego alteraciones con duracion" => sub {
        my $valor = Persona::Valor->new(valor => 2);
        $valor->alterar({fecha => DateTime->new(year => 1990)->datetime, alteracion => '+3', duracion => '2y'}),
        $valor->alterar({fecha => DateTime->new(year => 2000)->datetime, alteracion => '+3'});
        it "ENTONCES el valor se debe alterar segun la fecha" => sub {
          is $valor->valor, 5;
          is $valor->valor(DateTime->new(year => 1980)->datetime), 2;
          is $valor->valor(DateTime->new(year => 1991)->datetime), 5;
          is $valor->valor(DateTime->new(year => 1995)->datetime), 2;
          is $valor->valor(DateTime->new(year => 2001)->datetime), 5;
        };
      };
      context "CUANDO cuando agrego alteraciones a temporales con duracion" => sub {
        my $valor = Persona::Valor->new(valor => 2);
        $valor->alterar({temporal => 1, fecha => DateTime->new(year => 1990)->datetime, alteracion => '+3', duracion => '2y'}),
        $valor->alterar({temporal => 1, fecha => DateTime->new(year => 2000)->datetime, alteracion => '+3'});
        it "ENTONCES el valor se debe alterar segun la fecha" => sub {
          is $valor->valor, 2;
          is $valor->valor(DateTime->new(year => 1980)->datetime), 2;
          is $valor->valor(DateTime->new(year => 1991)->datetime), 2;
          is $valor->valor(DateTime->new(year => 1995)->datetime), 2;
          is $valor->valor(DateTime->new(year => 2001)->datetime), 2;
          is $valor->temporal, 5;
          is $valor->temporal(DateTime->new(year => 1980)->datetime), 2;
          is $valor->temporal(DateTime->new(year => 1991)->datetime), 5;
          is $valor->temporal(DateTime->new(year => 1995)->datetime), 2;
          is $valor->temporal(DateTime->new(year => 2001)->datetime), 5;
        };
      };
    };
    context "alteraciones string" => sub {
      context "CUANDO cuando agrego alteraciones" => sub {
        my $valor = Persona::Valor->new(valor => 'rojo');
        $valor->alterar({temporal => 1, fecha => DateTime->new(year => 1990)->datetime, alteracion => 'verde'}),
        $valor->alterar({fecha => DateTime->new(year => 2000)->datetime, alteracion => 'amarillo'});
        it "ENTONCES el valor se debe alterar segun la fecha" => sub {
          is $valor->valor, 'amarillo';
          is $valor->valor(DateTime->new(year => 1980)->datetime), 'rojo';
          is $valor->valor(DateTime->new(year => 1991)->datetime), 'rojo';
          is $valor->temporal(DateTime->new(year => 1991)->datetime), 'verde';
          is $valor->valor(DateTime->new(year => 2001)->datetime), 'amarillo';
        };
      };
    };
  };
  context "Persona::Valor::t" => sub {
    context "CUANDO tradusco un valor scalar" => sub {
      my $valor = Persona::Valor->new(valor => 'gat[a|o]', persona => Persona->new({sexo => 'f'}),);
      it "ENTONCES debe devolverme el valor traducido" => sub {
        is $valor->t, 'gata';
      };
    };
    context "CUANDO tradusco un valor array" => sub {
      my $valor = Persona::Valor->new(valor => ['gat[a|o]', 'perr[a|o]'], persona => Persona->new({sexo => 'f'}),);
      it "ENTONCES debe devolverme el valor traducido" => sub {
        is $valor->t, 'gata, perra';
      };
    };
  };
};


