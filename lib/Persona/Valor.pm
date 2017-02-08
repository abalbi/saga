package Persona::Valor;
use Data::Dumper;
use fields qw(_key _valor _persona);
sub new {
  my $class = shift;
  my $params = shift || {};
  my $self = fields::new($class);
  foreach my $key (sort keys %$params) {
    $self->{'_'.$key} = $params->{$key};
  }
  $self;
}

sub key {
  my $self = shift;
  return $self->{_key};
}

sub normalizar {
  my $self = shift;
  my $valor = shift;
  return $valor;  
}

sub valor {
  my $self = shift;
  my $fecha = shift;
  my $mod = 0;
  return $self->{_valor} if $self->{_valor} !~ /^\d+$/;
  if($self->persona && defined $fecha) {
    my $entorno = $self->persona->entorno;
    foreach my $alteracion (@{$entorno->alteraciones}) {
      next if $alteracion->temporal;
      next if $alteracion->persona ne $self->persona;
      next if $alteracion->key ne $self->key;
      my $fecha_vencimiento = DateTime->from_epoch(epoch => (Saga::dt($alteracion->fecha)->epoch + Saga::tiempo($fecha, $alteracion->duracion)));
      next if $fecha_vencimiento->epoch <= $fecha->epoch;
      $mod += $alteracion->alteracion if Saga::dt($alteracion->fecha)->epoch <= $fecha->epoch;
    }
  }
  return $self->normalizar($self->{_valor} + $mod);
}

sub temporal {
  my $self = shift;
  my $fecha = shift;
  my $mod = 0;
  return $self->{_valor} if $self->{_valor} !~ /^\d+$/;
  if($self->persona && defined $fecha) {
    my $entorno = $self->persona->entorno;
    foreach my $alteracion (@{$entorno->alteraciones}) {
      next if !$alteracion->temporal;
      next if $alteracion->persona ne $self->persona;
      next if $alteracion->key ne $self->key;
      my $fecha_vencimiento = DateTime->from_epoch(epoch => (Saga::dt($alteracion->fecha)->epoch + Saga::tiempo($fecha, $alteracion->duracion)));
      next if $fecha_vencimiento->epoch <= $fecha->epoch;
      $mod += $alteracion->alteracion if Saga::dt($alteracion->fecha)->epoch <= $fecha->epoch;
    }
  }
  return $self->normalizar($self->{_valor} + $mod);
}


sub persona {
  my $self = shift;
  my $persona = shift;
  $self->{_persona} = $persona if defined $persona;
  return $self->{_persona};
}

sub t {
  my $self = shift;
  if(ref $self->valor eq 'ARRAY') {
  	return join ', ', map {
  	  if(ref $_ eq 'HASH') {
  	  	Saga::t($_->{key}, $self->persona->sexo) . ": " . Saga::t($_->{valor}, $self->persona->sexo)
  	  } else {
  	  	Saga::t($_, $self->persona->sexo)
  	  }
  	} @{$self->valor};
  }
  return Saga::t($self->valor, $self->persona->sexo);	
}
1;