class Avion {
  final String id;
  final String modelo;
  String pista;
  bool _activo = false;

  Avion({
    required this.id,
    required this.modelo,
    required this.pista,
  });

  bool get activo => _activo;
  String get estado => _activo ? 'en servicio' : 'fuera de servicio';

  set estadoActivo(bool v) {
    _activo = v;
    print('$modelo: ${v ? "activo" : "inactivo"}');
  }

  void despegar() {
    _activo = true;
    print('$modelo despegando desde pista $pista');
  }

  void aterrizar() {
    _activo = false;
    print('$modelo aterrizó');
  }

  String resumen() =>
      'ID: $id | Modelo: $modelo | Pista: $pista | Estado: $estado';

  @override
  String toString() => 'Avion($modelo, $pista, $estado)';
}

void main() {
  final avion = Avion(
    id: 'AV-001',
    modelo: 'Boeing 737',
    pista: 'A1',
  );

  avion.despegar();
  print(avion.estado);
  print(avion.resumen());
  print(avion);

  avion.estadoActivo = false;
  print(avion.activo);
}