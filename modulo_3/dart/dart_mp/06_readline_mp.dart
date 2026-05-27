import 'dart:io';

void main() {

  print('Ingrese el destino del vuelo:');

  String? destino = stdin.readLineSync();

  print('Destino registrado: $destino');

  print('Ingrese el numero de pasajeros:');

  int pasajeros = int.parse(stdin.readLineSync()!);

  print('Pasajeros: $pasajeros');

  print('Ingrese el peso del equipaje:');

  double equipaje = double.parse(stdin.readLineSync()!);

  print('Peso del equipaje: $equipaje');

  print('Ingrese la cantidad de vuelos nacionales:');

  int nacionales = int.parse(stdin.readLineSync()!);

  print('Ingrese la cantidad de vuelos internacionales:');

  int internacionales = int.parse(stdin.readLineSync()!);

  int total = nacionales + internacionales;

  print('Total de vuelos: $total');
}