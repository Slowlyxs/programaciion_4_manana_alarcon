  import 'dart:io';
  void main() {
  
  
  print('Ingrese su nota: ');
  double nota  = double.parse(stdin.readLineSync()!);
  
  if ( nota >= 7){
    print('Aprobado');
  } else{
    print('Reprobado');
  }
  }