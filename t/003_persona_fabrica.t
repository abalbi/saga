use strict;
use lib 'lib';
use Test::More qw(no_plan);
use Test::More::Behaviour;
use Test::Deep;
use Data::Dumper;

use Saga;

#cover -delete; PERL5OPT=-MDevel::Cover=+inc,/Volumes/UFS prove -v -I../lib "$@" && cover

describe "Persona::Fabrica" => sub {
  context "Persona::Fabrica::dar_nacimiento" => sub {
    context "CUANDO ejecuto dar_nacimiento" => sub {
      my $persona = Persona::Fabrica->hacer;
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $persona, 'Persona';
      };
    };
  };
  context "Persona::Fabrica::dar_nacimiento" => sub {
    context "CUANDO ejecuto dar_nacimiento" => sub {
      my $params = {};
      Persona::Fabrica->dar_nacimiento($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{nacimiento}, 'Persona::Valor';
        isa_ok Saga::dt($params->{nacimiento}->valor), 'DateTime';
      };
    };
  };
  context "Persona::Fabrica::dar_sexo" => sub {
    context "CUANDO ejecuto dar_sexo" => sub {
      my $params = {};
      Persona::Fabrica->dar_sexo($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{sexo}, 'Persona::Valor';
      };
    };
  };
  context "Persona::Fabrica::dar_nombre" => sub {
    context "CUANDO ejecuto dar_nombre" => sub {
      my $params = {
        sexo => Persona::Valor->new(key => 'sexo', valor => 'f')
      };
      Persona::Fabrica->dar_nombre($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{nombre}, 'Persona::Valor';
        like $params->{nombre}->valor, qr/\w+/;
      };
    };
  };
  context "Persona::Fabrica::dar_ascendente_erotica" => sub {
    context "CUANDO ejecuto dar_ascendente_erotica" => sub {
      my $params = {
        sexo => Persona::Valor->new(key => 'sexo', valor => 'f')
      };
      Persona::Fabrica->dar_ascendente_erotica($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{ascendente_erotica}, 'Persona::Valor';
        like $params->{ascendente_erotica}->valor, qr/\w+/;
        is scalar @{$params->{elecciones_erotica}->valor}, 5;
      };
    };
  };
  context "Persona::Fabrica::dar_aptitudes" => sub {
    context "CUANDO ejecuto dar_aptitudes" => sub {
      my $params = {
        sexo => Persona::Valor->new(key => 'sexo', valor => 'f')
      };
      Persona::Fabrica->dar_aptitudes($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{cuerpo}, 'Persona::Valor';
        like $params->{cuerpo}->valor, qr/^\d+$/;
        isa_ok $params->{mente}, 'Persona::Valor';
        like $params->{mente}->valor, qr/^\d+$/;
        isa_ok $params->{espiritu}, 'Persona::Valor';
        like $params->{espiritu}->valor, qr/^\d+$/;
        isa_ok $params->{sentidos}, 'Persona::Valor';
        is $params->{sentidos}->valor, int(($params->{cuerpo}->valor + $params->{mente}->valor)/2);
        isa_ok $params->{sociabilidad}, 'Persona::Valor';
        is $params->{sociabilidad}->valor, int(($params->{mente}->valor + $params->{espiritu}->valor)/2);
      };
    };
  };
  context "Persona::Fabrica::dar_rasgos" => sub {
    my $params = {};
    Persona::Fabrica->dar_aptitudes($params);
    Persona::Fabrica->dar_animo($params);
    context "CUANDO ejecuto dar_rasgos" => sub {
      Persona::Fabrica->dar_rasgos($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{rasgos}, 'Persona::Valor::Rasgos';
        ok scalar @{$params->{rasgos}->positivos};
        ok scalar @{$params->{rasgos}->negativos};
      };
    };
  };
  context "Persona::Fabrica::dar_acentos" => sub {
    my $params = {};
    Persona::Fabrica->dar_aptitudes($params);
    Persona::Fabrica->dar_animo($params);
    context "CUANDO ejecuto dar_acentos" => sub {
      Persona::Fabrica->dar_acentos($params);
      it "ENTONCES debe devolverme una persona con los parametros definidos" => sub {
        isa_ok $params->{acentos}, 'Persona::Valor';
        ok scalar @{$params->{acentos}->valor};
        ok exists $params->{acentos}->valor->[0]->{key};
        ok exists $params->{acentos}->valor->[0]->{valor};
      };
    };
  };
};


