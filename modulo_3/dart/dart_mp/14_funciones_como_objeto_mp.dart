int duplicarEquipaje(int n) => n * 2;
int triplicarEquipaje(int n) => n * 3;

void main() {
  int Function(int) operacion;

  operacion = duplicarEquipaje;
  print(operacion(5));

  operacion = triplicarEquipaje;
  print(operacion(5));

  final procesos = <int Function(int)>[
    duplicarEquipaje,
    triplicarEquipaje
  ];

  for (final fn in procesos) {
    print(fn(10));
  }
}