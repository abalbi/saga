package Situacion::Actor;
use Data::Dumper;
use fields qw(_persona _stash _entorno _fecha);
sub new {
  my $class = shift;
  my $params = Saga::params(@_);
  my $self = fields::new($class);
  $self->{_stash} = {};
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
  if(not exists $self->stash->{$propiedad}) {
    if ($self->persona->tiene($propiedad)) {
      my $valor = $self->persona->$propiedad;
      $self->stash->{$propiedad} = $valor;
    } else {
      $self->stash->{$propiedad} = undef;      
    }
  }
  if(defined $valor) {
    $self->stash->{$propiedad} = $valor; 
  }
  return $self->stash->{$propiedad};
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