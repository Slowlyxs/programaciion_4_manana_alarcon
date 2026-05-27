import 'dart:io';

void main() {

  // Estado del vuelo
  int retraso = 40;

  if (retraso > 30) {

    print('Vuelo retrasado');

  } else if (retraso > 0) {

    print('Vuelo próximo a salir');

  } else {

    print('Vuelo puntual');
  }

  // Operador ternario
  String estado = retraso > 30
      ? 'Retraso confirmado'
      : 'Sin retraso';

  print(estado);

  // Null safety
  String? terminal;

  String resultado = terminal != null
      ? terminal.toUpperCase()
      : 'Sin terminal';

  print(resultado);

  // Forma corta
  String resultado2 = terminal?.toUpperCase() ?? 'Sin terminal';

  print(resultado2);

  // Número de pasajeros
  print('Ingrese la cantidad de pasajeros:');

  int pasajeros = int.parse(stdin.readLineSync()!);

  if (pasajeros < 0) {

    print('Cantidad inválida');

  } else {

    print('Cantidad correcta');
  }

  // Nivel de ocupación
  print('Ingrese el nivel de ocupacion del vuelo:');

  int ocupacion = int.parse(stdin.readLineSync()!);

  if (ocupacion >= 70) {

    print('Vuelo lleno');

  } else {

    print('Vuelo disponible');
  }
}