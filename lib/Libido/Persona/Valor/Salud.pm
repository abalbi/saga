package Libido::Persona::Valor::Salud;

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
  return 0 if $valor <= 0;
  return $valor;  
}

1;