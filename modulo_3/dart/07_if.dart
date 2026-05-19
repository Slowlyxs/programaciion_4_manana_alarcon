import 'dart:io';
void main() {
  // Forma básica
  int temperatura = 38;

  if (temperatura > 37.5) {
    print('Fiebre');
  } else if (temperatura > 36) {
    print('Normal');
  } else {
    print('Hipotermia');
  }

  // Operador ternario — para decisiones de una línea
  // condición ? valorSiVerdadero : valorSiFalso
  String estado = temperatura > 37.5 ? 'Con fiebre' : 'Sin fiebre';
  print(estado);

  // null-aware con ternario
  String? ciudad;
  String display = ciudad != null ? ciudad.toUpperCase() : 'Sin ciudad';

  // Forma más concisa con ??
  String display2 = ciudad?.toUpperCase() ?? 'Sin ciudad';
  print(display2);  // Sin ciudad



  print('Ingrese el segundo numero: ');
  int numero  = int.parse(stdin.readLineSync()!);

  if ( numero < 0){
    print('EL numero es negativo');
  } else{
    print('EL numero es positivo');
  }

  print('Ingrese su nota: ');
  int nota  = int.parse(stdin.readLineSync()!);
  
  if ( nota >= 7){
    print('Aprobado');
  } else{
    print('Reprobado');
  }
}