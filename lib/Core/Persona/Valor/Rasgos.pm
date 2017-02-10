package Persona::Valor::Rasgos;
use Data::Dumper;
use base qw(Persona::Valor);
use fields qw();

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

sub positivos {
  my $self = shift;
  return $self->{_valor}->{positivos};
}

sub negativos {
  my $self = shift;
  return $self->{_valor}->{negativos};
}

sub t {
  my $self = shift;
  my $str = join (', ',
    join(', ', map {Saga::t($_, $self->persona->sexo)} @{$self->positivos}),
    join(', ', map {Saga::t($_, $self->persona->sexo)} @{$self->negativos}),
  );
  return $str;
}

1;