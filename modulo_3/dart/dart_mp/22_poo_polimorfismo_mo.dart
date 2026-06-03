abstract class Operacion {
  String get nombre;
  double calcular();
}

class VueloLocal extends Operacion {
  final double km;
  VueloLocal(this.km);
  @override String get nombre => 'Vuelo local';
  @override double calcular() => km * 0.5;
}

class VueloInternacional extends Operacion {
  final double km;
  VueloInternacional(this.km);
  @override String get nombre => 'Vuelo internacional';
  @override double calcular() => km * 0.8;
}

class VueloCarga extends Operacion {
  final double kg;
  VueloCarga(this.kg);
  @override String get nombre => 'Vuelo carga';
  @override double calcular() => kg * 0.3;
}

void imprimirOperacion(Operacion o) {
  print('${o.nombre}: ${o.calcular().toStringAsFixed(2)}');
}

void main() {
  final ops = <Operacion>[
    VueloLocal(500),
    VueloInternacional(8000),
    VueloCarga(2000),
  ];

  for (final o in ops) {
    imprimirOperacion(o);
  }

  final mayor = ops.reduce((a, b) => a.calcular() > b.calcular() ? a : b);
  print('\nMayor operación: ${mayor.nombre}');
}