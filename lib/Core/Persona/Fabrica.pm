package Persona::Fabrica;
use strict;
use Data::Dumper;

sub logger {
  return Log::Log4perl->get_logger(__PACKAGE__);
}

sub hacer {
	my $self = shift;
	my $params;
	$params = Saga::params(@_);
	my $entorno = $params->{entorno};
	$self->_hacer($params);
	$Data::Dumper::Maxdepth = 3;
	my $persona = Saga::despachar('Persona')->new($params);
	push @{$entorno->items}, $persona if $entorno;
	return $persona;
}

1;
