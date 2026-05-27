void main() {

  // SWITCH TRADICIONAL
  String estadoVuelo = 'RETRASADO';

  switch (estadoVuelo) {

    case 'ACTIVO':
      print('Vuelo en curso');
      break;

    case 'EMBARQUE':
      print('Pasajeros abordando');
      break;

    case 'RETRASADO':
      print('Vuelo retrasado');
      break;

    case 'CANCELADO':
      print('Vuelo cancelado');
      break;

    case 'FINALIZADO':
      print('Vuelo finalizado');
      break;

    default:
      print('Estado desconocido');
  }

  // SWITCH COMO EXPRESIÓN
  String descripcion = switch (estadoVuelo) {

    'ACTIVO' => 'El vuelo está en curso',

    'EMBARQUE' => 'El embarque está habilitado',

    'RETRASADO' => 'El vuelo tiene demora',

    'CANCELADO' => 'El vuelo fue cancelado',

    'FINALIZADO' => 'El vuelo terminó',

    _ => 'Estado no registrado',
  };

  print(descripcion);

  // MÚLTIPLES VALORES
  int puerta = 5;

  String terminal = switch (puerta) {

    1 || 2 || 3 => 'Terminal Norte',

    4 || 5 || 6 => 'Terminal Sur',

    7 || 8 || 9 => 'Terminal Internacional',

    _ => 'Puerta desconocida',
  };

  print(terminal);

  // GUARDS CON WHEN
  double equipaje = 32.5;

  String mensaje = switch (equipaje) {

    double p when p >= 40 =>
      'Equipaje excedido',

    double p when p >= 30 =>
      'Equipaje pesado',

    double p when p >= 20 =>
      'Equipaje permitido',

    _ =>
      'Equipaje ligero',
  };

  print(mensaje);

  // SWITCH CON TIPOS
  Object respuesta = {
    'vuelo': 'AV101',
    'destino': 'Quito',
    'pasajeros': 120
  };

  String resultado = switch (respuesta) {

    Map<String, dynamic> m when m.containsKey('error') =>
      'Error: ${m['error']}',

    Map<String, dynamic> m =>
      'Vuelo: ${m['vuelo']} - Destino: ${m['destino']}',

    List<dynamic> lista =>
      '${lista.length} vuelos registrados',

    String texto =>
      'Mensaje: $texto',

    _ =>
      'Respuesta desconocida',
  };

  print(resultado);
}