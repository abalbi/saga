package Situacion;
use Data::Dumper;
use fields qw(_entorno _fecha _fecha_base _actores _log _descripcion);
use Want;

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
  return push @{$self->{_log}}, $fecha_str .": ".$message if defined $message;
  return $self->{_log};
}

sub describir {
  my $self = shift;
  my $str = '';
  $str .= "###########################################################################\n";
  $str .= $self->fecha_base."\n";
  $str .= join("\n", @{$self->log});
  return $str;
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
