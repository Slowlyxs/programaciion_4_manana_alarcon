void main() {
  // SWITCH TRADICIONAL
  String codigoHttp = '404';

  switch (codigoHttp) {
    case '200':
      print('OK');
      break;
    case '201':
      print('Creado');
      break;
    case '400':
      print('Petición incorrecta');
      break;
    case '401':
      print('No autorizado');
      break;
    case '404':
      print('No encontrado');
      break;
    case '500':
      print('Error del servidor');
      break;
    default:
      print('Código desconocido');
  }

  // SWITCH COMO EXPRESIÓN
  String descripcion = switch (codigoHttp) {
    '200' => 'OK — solicitud exitosa',
    '201' => 'Created — recurso creado',
    '204' => 'No Content — sin contenido',
    '400' => 'Bad Request — datos inválidos',
    '401' => 'Unauthorized — sin autenticación',
    '403' => 'Forbidden — sin permiso',
    '404' => 'Not Found — recurso no existe',
    '500' => 'Internal Server Error',
    '503' => 'Service Unavailable',
    _ => 'Código HTTP desconocido',
  };

  print(descripcion);

  // MÚLTIPLES VALORES EN UNA RAMA
  int codigoNumerico = 404;

  String categoria = switch (codigoNumerico) {
    200 || 201 || 204 => 'Éxito (2xx)',
    301 || 302 || 307 => 'Redirección (3xx)',
    400 || 401 || 403 || 404 => 'Error del cliente (4xx)',
    500 || 502 || 503 => 'Error del servidor (5xx)',
    _ => 'Desconocido',
  };

  print(categoria);

  // GUARDS CON WHEN
  double temperatura = 39.2;

  String alerta = switch (temperatura) {
    double t when t >= 40.0 =>
      '🚨 CRÍTICO — llame a emergencias',
    double t when t >= 38.5 =>
      '🔴 FIEBRE ALTA — consulte médico',
    double t when t >= 37.5 =>
      '🟡 FIEBRE LEVE — descanse',
    double t when t >= 36.0 =>
      '🟢 NORMAL',
    _ =>
      '🔵 HIPOTERMIA — abrígese',
  };

  print(alerta);

  // SWITCH VERIFICANDO TIPOS
  Object respuestaApi = {
    'id': 1,
    'nombre': 'Teclado',
    'precio': 89.99
  };

  String resultado = switch (respuestaApi) {
    Map<String, dynamic> m when m.containsKey('error') =>
      'Error: ${m['error']}',

    Map<String, dynamic> m =>
      'Producto: ${m['nombre']} — \$${m['precio']}',

    List<dynamic> lista =>
      '${lista.length} elementos en la lista',

    String texto =>
      'Texto recibido: $texto',

    _ =>
      'Respuesta desconocida',
  };

  print(resultado);
}