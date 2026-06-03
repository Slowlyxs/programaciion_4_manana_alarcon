void main() {
  final pasajerosCuadrado = (int n) => n * n;
  print(pasajerosCuadrado(7));

  final calcularTarifa = (double precio, double pct) {
    final d = precio * (pct / 100);
    return precio - d;
  };
  print(calcularTarifa(100.0, 15.0));

  final vuelos = [3, 1, 4, 1, 5, 9, 2, 6];
  vuelos.sort((a, b) => b.compareTo(a));
  print(vuelos);
}