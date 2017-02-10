package Alteracion;
use fields qw(_fecha _persona _key _alteracion _duracion _temporal);
use Data::Dumper;

sub new {
  my $class = shift;
  my $params = Saga::params(@_);
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}

sub persona {
  my $self = shift;
  return $self->{_persona};
}

sub key {
  my $self = shift;
  return $self->{_key};
}

sub fecha {
  my $self = shift;
  return $self->{_fecha};
}

sub alteracion {
  my $self = shift;
  return $self->{_alteracion};
}

sub temporal {
  my $self = shift;
  return $self->{_temporal};
}

sub duracion {
  my $self = shift;
  return $self->{_duracion};
}

sub tiene { 0 }
1;
