void configurarVuelo({
  required String origen,
  required String destino,
  bool internacional = true,
  int puerta = 1,
}) {
  final tipo = internacional ? 'Internacional' : 'Nacional';
  print('Vuelo $origen → $destino | $tipo | Puerta $puerta');
}

void main() {
  configurarVuelo(
    origen: 'UIO',
    destino: 'MIA',
    internacional: true,
    puerta: 5,
  );

  configurarVuelo(
    origen: 'UIO',
    destino: 'GYE',
  );
}