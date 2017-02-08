package Situacion::Actor;
use Data::Dumper;
use fields qw(_items _persona _stash);
sub new {
  my $class = shift;
  my $params = shift || {};
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    eval {
      $self->{'_'.$key} = $params->{$key};
    };
    if($@) {
      $self->{'_stash'}->{$key} = $params->{$key}; 
    }
  }
  $self;
}

our $AUTOLOAD;

sub AUTOLOAD {
  my $method = $AUTOLOAD;
  my $self = shift;
  my $valor = shift;
  $method =~ s/.*:://;

  my $propiedad = $method;
  if ($self->persona->tiene($propiedad)) {
    return $self->persona->$propiedad;
  }
  if ( exists $self->stash->{$propiedad} && not defined $valor) {
    return $self->stash->{$propiedad};
  }
  if ( defined $valor) {
    $self->stash->{$propiedad} = $valor;
    return $self->stash->{$propiedad};
  }
  die "No se encontro Actor::$propiedad";
}

sub persona {
  my $self = shift;
  return $self->{_persona};
}

sub stash {
  my $self = shift;
  return $self->{_stash};
}


1;