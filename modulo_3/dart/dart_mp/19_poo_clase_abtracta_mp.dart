abstract class OperacionVuelo {
  String get nombre;
  double calcularTiempo();
  double calcularDistancia();

  void describir() {
    print('$nombre — tiempo: ${calcularTiempo().toStringAsFixed(2)}, '
          'distancia: ${calcularDistancia().toStringAsFixed(2)}');
  }
}

class VueloCorto extends OperacionVuelo {
  final double km;
  VueloCorto(this.km);

  @override String get nombre => 'Vuelo corto ($km km)';
  @override double calcularTiempo() => km / 600;
  @override double calcularDistancia() => km;
}

class VueloLargo extends OperacionVuelo {
  final double km;
  VueloLargo(this.km);

  @override String get nombre => 'Vuelo largo ($km km)';
  @override double calcularTiempo() => km / 900;
  @override double calcularDistancia() => km;
}

void main() {
  final ops = <OperacionVuelo>[
    VueloCorto(500),
    VueloLargo(8000)
  ];

  for (final o in ops) {
    o.describir();
  }
}