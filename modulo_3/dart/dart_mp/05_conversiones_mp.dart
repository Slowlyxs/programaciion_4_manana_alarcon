void main() {

  // Conversiones numéricas
  int pasajeros = 150;

  double pasajerosDecimal = pasajeros.toDouble();

  String pasajerosTexto = pasajeros.toString();

  print(pasajerosDecimal);

  print(pasajerosTexto);

  // String a número
  int terminal = int.parse('5');

  double equipaje = double.parse('25.5');

  print(terminal);

  print(equipaje);

  // Conversión segura
  int? puerta = int.tryParse('ABC');

  double? pista = double.tryParse('12');

  print(puerta);

  print(pista);

  // Verificar tipo
  Object vuelo = 'AV202';

  if (vuelo is String) {
    print(vuelo.length);
  }

  // Cast explícito
  Object aeropuerto = 'Quito';

  String ciudad = aeropuerto as String;

  print(ciudad);

  // Null safety
  String? piloto = null;

  int longitud = piloto?.length ?? 0;

  print(longitud);

  // Números especiales
  print(double.infinity);

  print(double.nan);

  print(double.maxFinite);
}