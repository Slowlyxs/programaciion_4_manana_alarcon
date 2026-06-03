class Vehiculo {
  final String nombre;
  final int capacidad;

  Vehiculo(this.nombre, this.capacidad);

  String operar() => '...';

  void presentarse() {
    print('Soy $nombre, capacidad $capacidad y hago: ${operar()}');
  }
}

class Avion extends Vehiculo {
  Avion(super.nombre, super.capacidad);

  @override
  String operar() => 'Despegando';

  void volar() => print('$nombre está en vuelo');
}

class Helicoptero extends Vehiculo {
  Helicoptero(super.nombre, super.capacidad);

  @override
  String operar() => 'Elevando';

  void aterrizar() => print('$nombre aterriza verticalmente');
}

void main() {
  final a = Avion('Boeing 737', 180);
  final h = Helicoptero('H125', 6);

  a.presentarse();
  h.presentarse();

  a.volar();
  h.aterrizar();
}