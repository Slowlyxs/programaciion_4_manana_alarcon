void main() {

  final vuelo = 'AV101';

  final pasajeros = 120;

  // Interpolación
  print('Vuelo: $vuelo');

  // Expresión
  print('El vuelo ${vuelo.toLowerCase()} tiene ${pasajeros + 10} pasajeros registrados');

  // Multilínea
  final informacion = '''
Vuelo: $vuelo
Pasajeros: $pasajeros
Disponible: ${pasajeros < 150 ? 'Si' : 'No'}
  ''';

  print(informacion);

  // Raw string
  final ruta = r'C:\Aeropuerto\Vuelos';

  print(ruta);

  // Concatenación
  final mensaje = 'Código del vuelo: ' + vuelo;

  print(mensaje);

  // Métodos String
  print('aeropuerto'.toUpperCase());

  print('  Vuelo Internacional  '.trim());

  print('Aeropuerto'.contains('puerto'));

  print('Terminal'.replaceAll('e', 'E'));

  print('Quito,Guayaquil,Cuenca'.split(','));

  print('Aeropuerto'.substring(0, 4));

  print('Vuelo'.startsWith('Vue'));

  print('AV1'.padLeft(6, '0'));
}