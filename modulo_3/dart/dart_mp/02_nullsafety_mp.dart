void main() {

  // Variable no nullable
  String vuelo = 'Quito';

  // vuelo = null; // Error

  // Variable nullable
  String? terminal = null;

  terminal = 'Terminal Norte';

  // Null safety
  String? piloto;

  // Safe call
  print(piloto?.length);

  // Operador ??
  String resultado = piloto ?? 'Sin piloto asignado';

  print(resultado);

  // Non-null assertion
  // String pilotoSeguro = piloto!;

  // Validación con if
  if (terminal != null) {
    print(terminal.length);
  }

  // late
  late String codigoVuelo;

  codigoVuelo = 'AV102';

  print(codigoVuelo);
}