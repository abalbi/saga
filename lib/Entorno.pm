package Entorno;
use Data::Dumper;
use fields qw(_items);
sub new {
  my $class = shift;
  $class = ref $class if ref $class;
  my $self = fields::new($class);
  $self->{_items} = [];
  $self;
}

sub cantidad_personas {
  my $self = shift;
  return 5;
}

sub cantidad_situaciones {
  my $self = shift;
  return 10;
}


sub items {
  my $self = shift;
  return $self->{_items};  
}

sub personas {
  my $self = shift;
  return [grep {$_->isa('Persona')} @{$self->items}];
}

sub alteraciones {
  my $self = shift;
  return [grep {$_->isa('Alteracion')} @{$self->items}];
}

sub situaciones {
  my $self = shift;
  return [grep {$_->isa('Situacion')} @{$self->items}];
}


sub describir {
  my $self = shift;
  my $str = '';
  foreach my $persona (@{$self->personas}) {
    $str .= $persona->describir."\n";
  }
  foreach my $situacion (@{$self->situaciones}) {
    $str .= $situacion->describir."\n";
  }
  return $str;
}

sub buscar_crear {
  my $self = shift;
  my $params = shift;
  my $temp = $self->buscar($params);
  if(scalar @$temp) {
    return Saga::azar($temp);
  } else {
    my $persona = Persona::Fabrica->hacer($params);
    push @{$self->items}, $persona;
    return $persona;
  }
}

sub buscar {
  my $self = shift;
  my $params = shift;
  my $items = [];
  foreach my $item (@{$self->items}) {
    my $boo = 1;
    foreach my $key (sort keys %$params) {
      my $param = $params->{$key};
      if($item->tiene($key)) {
        if($param =~ qr/^\!(.+)/) {
          $boo = 0 if $item->$key eq $1;
        } else {
          $boo = 0 if $item->$key ne $param;
        }
      }
      if($key eq 'package') {
        $boo = 0 if !$item->isa($param);
      }
    }
    push @$items, $item if $boo;
  }
  return $items; 
}
1;
