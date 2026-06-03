void main() {
  final tarifas = [29.99, 49.50, 15.00, 99.99];

  final tarifasFinales = tarifas.map((t) => t * 1.15);
  print(tarifasFinales.toList());

  final rutas = ['/salidas', '/llegadas', '/equipaje'];
  final panel = rutas.map((r) => 'https://aeropuerto.com$r');
  print(panel.toList());
}