package Libido::Persona::Valor::Animo;

use base qw(Persona::Valor);
use fields qw(_temperales);

sub new {
  my $class = shift;
  my $params = shift || {};
  my $self = fields::new($class);
  $self = $self->SUPER::new($self);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}


sub normalizar {
  my $self = shift;
  my $valor = shift;
  return 10 if $valor >= 10;
  return 1 if $valor <= 1;
  return $valor;  
}

1;