class Vuelo {
  final String codigo;
  final String origen;
  final String destino;
  final int puerta;
  final bool internacional;

  Vuelo({
    required this.codigo,
    required this.origen,
    required this.destino,
    required this.puerta,
    this.internacional = false,
  });

  Vuelo.local()
      : codigo = 'V-LOCAL',
        origen = 'UIO',
        destino = 'GYE',
        puerta = 1,
        internacional = false;

  Vuelo.internacional({required this.codigo, required this.origen, required this.destino})
      : puerta = 10,
        internacional = true;

  factory Vuelo.desdeRuta(String ruta) {
    final partes = ruta.split('-');
    final o = partes[0];
    final d = partes[1];
    return Vuelo(
      codigo: '$o$d',
      origen: o,
      destino: d,
      puerta: 5,
      internacional: true,
    );
  }

  @override
  String toString() =>
      '$codigo: $origen → $destino | Puerta $puerta | ${internacional ? "Int" : "Nac"}';
}

void main() {
  final v1 = Vuelo(codigo: 'AV101', origen: 'UIO', destino: 'CUE', puerta: 3);
  final v2 = Vuelo.local();
  final v3 = Vuelo.internacional(codigo: 'AV202', origen: 'UIO', destino: 'MIA');
  final v4 = Vuelo.desdeRuta('UIO-MAD');

  print(v1);
  print(v2);
  print(v3);
  print(v4);
}