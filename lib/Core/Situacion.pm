package Situacion;
use Data::Dumper;
use fields qw(_entorno _fecha _fecha_base _actores _log _descripcion _relato);
use Want;

sub logger {
  return Log::Log4perl->get_logger(__PACKAGE__);
}

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

sub puede_random { 1 } 

sub hacer {
  my $self = shift;
  $self->hacer_actores;
  logger->info($self->key, '. Actores: ', join ', ', map {$_->nombre} @{$self->actores});
  $self->_hacer(@_);
  return $self;  
}

sub hacer_actores {
  my $self = shift;
  my $personas = shift;
  my $actores = [];
  $personas = [] if not defined $personas;
  while(scalar @{$personas} < 2) {
    my $params = {
      package => 'Persona'
    };
    if($personas->[0]) {
      $params->{nombre} = "!".$personas->[0]->nombre;
    }
    my $persona = $self->entorno->buscar_crear($params);
    next if scalar grep {$_ eq $persona} @$personas;
    push @$personas, $persona;
  }
  foreach my $persona (@$personas) {
    push @$actores, Saga::despachar('Situacion::Actor')->new({
      persona => $persona,
    });
  }
  $self->actores($actores);
}


sub actores {
  my $self = shift;
  my $actores = shift;
  $self->{_actores} = $actores if defined $actores;
  return $self->{_actores};
}

sub entorno {
  my $self = shift;
  return $self->{_entorno};
}

sub fecha {
  my $self = shift;
  my $valor = shift;
  if(defined $valor) {
  	$self->{_fecha} = $valor;
  }
  if(want('OBJECT')) {
  	return Saga::dt($self->{_fecha});
  }
  return $self->{_fecha};
}

sub fecha_base {
  my $self = shift;
  my $valor = shift;
  if(defined $valor) {
    $self->{_fecha_base} = $valor;
  }
  if(want('OBJECT')) {
    return Saga::dt($self->{_fecha_base});
  }
  return $self->{_fecha_base};
}


sub log {
  my $self = shift;
  my $message = shift;
  my $fecha = Saga::dt($self->fecha);
  my $fecha_str = $fecha->dmy . ' ' .$fecha->day_name . ' ' .$fecha->hms;
  logger->trace($fecha_str .": ".$message) if defined $message;
  return push @{$self->{_log}}, $fecha_str .": ".$message if defined $message;
  return $self->{_log};
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= $self->fecha_base." ".$self->key.". Actores: ".$self->nombres_actores."\n";
  $str .= join '', @{$self->relato};
  return $str;
}

sub relato {
  my $self = shift;
  $self->{_relato} = [] if not defined $self->{_relato};
  return $self->{_relato};
}

sub nombres_actores {
  my $self = shift;
  my $nombres = [map {$_->nombre} @{$self->actores}];
  my $str = '';
  while (scalar @$nombres) {
    $str .= shift @$nombres;
    $str .= ', ' if scalar @$nombres > 2;
    $str .= ' y ' if scalar @$nombres == 1;
  }
  return $str;
}

sub tiene { 0 }
1;
