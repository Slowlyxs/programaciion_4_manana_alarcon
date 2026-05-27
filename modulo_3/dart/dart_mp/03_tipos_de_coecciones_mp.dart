void main() {

  // List
  List<String> vuelos = ['Quito', 'Guayaquil', 'Cuenca'];

  var puertas = [1, 2, 3, 4];

  print(vuelos[0]);
  print(vuelos.length);

  vuelos.add('Manta');

  vuelos.remove('Guayaquil');

  // Map
  Map<String, String> pilotos = {
    'AV101': 'Carlos',
    'AV102': 'Luis',
    'AV103': 'Maria',
  };

  print(pilotos['AV101']);

  print(pilotos['AV200']);

  pilotos['AV104'] = 'Andrea';

  // Set
  Set<String> terminales = {
    'Norte',
    'Sur',
    'Internacional'
  };

  terminales.add('Norte');

  print(terminales.length);

  // Spread operator
  var vuelosNacionales = ['Quito', 'Cuenca'];

  var vuelosInternacionales = ['Bogota', 'Lima'];

  var todosLosVuelos = [
    ...vuelosNacionales,
    ...vuelosInternacionales
  ];

  print(todosLosVuelos);

  // Collection if
  bool mostrarCarga = true;

  var tiposVuelos = [
    'Pasajeros',
    'Privados',
    if (mostrarCarga) 'Carga'
  ];

  print(tiposVuelos);

  // Collection for
  var horarios = [
    for (var i = 1; i <= 5; i++) 'Vuelo $i'
  ];

  print(horarios);
}