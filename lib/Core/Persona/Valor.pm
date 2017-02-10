package Persona::Valor;
use Data::Dumper;
use strict;
use fields qw(_key _valor _persona _alteraciones);
sub new {
  my $class = shift;
  my $params = Saga::params(@_);
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

sub alteraciones {
  my $self = shift;
  $self->{_alteraciones} = [] if not exists $self->{_alteraciones};
  return $self->{_alteraciones};
}


sub valor {
  my $self = shift;
  my $fecha = shift;
  my $temporal = shift;
  $fecha = Saga::dt($fecha) if defined $fecha;
  $fecha = Saga::dt(Saga::fecha_base()) if not defined $fecha;
  my $alteraciones = $self->alteraciones;
  my $valor;
  $valor = $self->{_valor};
  if(scalar @$alteraciones) {
    foreach my $alteracion (@$alteraciones) {
      next if $alteracion->temporal != $temporal;
      my $fecha_alteracion = Saga::dt($alteracion->fecha);
      next if DateTime->compare($fecha_alteracion, $fecha) > 0;
      if($alteracion->duracion) {
        my $fecha_vencimiento = DateTime->from_epoch(epoch => (Saga::dt($alteracion->fecha)->epoch + Saga::tiempo($alteracion->duracion)));
        next if DateTime->compare($fecha, $fecha_vencimiento) > 0;
      }
      if($self->{_valor} =~ /^\d+$/) {
        $valor = $self->valor_numerico($valor, $alteracion->alteracion);
      } else {
        $valor = $self->valor_otros($valor, $alteracion->alteracion);
      }
    }
  }
  return $self->normalizar($valor);
}

sub valor_numerico {
  my $self = shift;
  my $valor = shift;
  my $alteracion = shift;
  $valor += $alteracion;
  return $valor;
}

sub valor_otros {
  my $self = shift;
  my $valor = shift;
  my $alteracion = shift;
  $valor = $alteracion;
  return $valor;
}

sub temporal {
  my $self = shift;
  my $fecha = shift;
  return $self->valor($fecha,1)  
}

sub persona {
  my $self = shift;
  my $persona = shift;
  $self->{_persona} = $persona if defined $persona;
  return $self->{_persona};
}

sub alterar {
  my $self = shift;
  my $params = shift;
  my $alteracion = Alteracion->new($params);
  push @{$self->alteraciones}, $alteracion;
}

sub t {
  my $self = shift;
  return Saga::t($self->valor, $self->persona->sexo);	
}
1;