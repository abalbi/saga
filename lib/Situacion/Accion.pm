package Situacion::Accion;
use Data::Dumper;
use fields qw(_key _ascendentes _tipo);
sub new {
  my $class = shift;
  my $params = shift || {};
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}

our $AUTOLOAD;



1;