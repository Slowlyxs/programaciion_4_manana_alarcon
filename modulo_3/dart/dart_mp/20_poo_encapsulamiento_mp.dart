class CuentaPasajero {
  final String nombre;
  double _millas;

  CuentaPasajero(this.nombre, double inicial)
      : _millas = inicial;

  double get millas => _millas;

  void acumular(double m) {
    if (m <= 0) throw ArgumentError('Monto inválido');
    _millas += m;
    print('+$m millas. Total: $_millas');
  }

  void canjear(double m) {
    if (m <= 0) throw ArgumentError('Monto inválido');
    if (m > _millas) throw StateError('Millas insuficientes');
    _millas -= m;
    print('-$m millas. Total: $_millas');
  }
}

void main() {
  final c = CuentaPasajero('Juan Pérez', 500.0);

  c.acumular(200.0);
  c.canjear(150.0);
  print(c.millas);
}