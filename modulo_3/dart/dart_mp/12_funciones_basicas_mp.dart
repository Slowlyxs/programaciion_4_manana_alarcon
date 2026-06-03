// Sintaxis completa — preferida para funciones públicas
int sumar(int a, int b) {
  return a + b;
}

// Sintaxis de flecha — cuando el cuerpo es una sola expresión
int multiplicar(int a, int b) => a * b;

// void — cuando no se devuelve nada
void imprimirSeparador(String titulo) {
  print('─── $titulo ───');
}

// Retorna String explícitamente
String formatearPrecio(double precio) =>
    '\$${precio.toStringAsFixed(2)}';

// Dart infiere el retorno como String
formatearPrecioSinTipo(double precio) =>
    '\$${precio.toStringAsFixed(2)}';

void main() {
  String construirUrl(String host, String ruta, [int? puerto]) {
  if (puerto != null) {
    return 'https://$host:$puerto$ruta';
  }
  return 'https://$host$ruta';
}

// Con valor por defecto — evita el chequeo de null
String construirUrlV2(String host, String ruta, [int puerto = 443]) {
  return 'https://$host:$puerto$ruta';
}
  print(sumar(5, 3));                 // 8
  print(multiplicar(4, 6));           // 24
  imprimirSeparador('Inicio');        // ─── Inicio ───

  print(formatearPrecio(12.5));       // $12.50
  print(formatearPrecioSinTipo(7));   // $7.00
  print(construirUrl('api.ejemplo.com', '/usuarios'));          // https://api.ejemplo.com/usuarios
  print(construirUrl('api.ejemplo.com', '/usuarios', 8080));   // https://api.ejemplo.com:8080/usuarios
  print(construirUrlV2('api.ejemplo.com', '/productos'));       // https://api.ejemplo.com:443/productos

}