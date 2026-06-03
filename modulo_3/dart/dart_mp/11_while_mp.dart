void main() {
  int paquetes = 0;
  int buffer = 1024;

  while (buffer > 0) {
    final t = buffer > 256 ? 256 : buffer;
    paquetes++;
    buffer -= t;
    print('Paquete $paquetes: $t bytes (restante: $buffer)');
  }

  int reintentos = 0;
  bool ok = false;

  do {
    reintentos++;
    print('Intento de conexión #$reintentos...');
    if (reintentos == 3) ok = true;
  } while (!ok && reintentos < 5);

  print(ok
      ? 'Conectado tras $reintentos intentos'
      : 'No se pudo conectar');
}