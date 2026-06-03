void main() {
  final protocolos = ['HTTP', 'HTTPS', 'FTP', 'SSH', 'SMTP'];

  // for-in — la forma idiomática para recorrer listas
  for (final protocolo in protocolos) {
    print(protocolo);
  }

  // forEach con lambda — alternativa funcional
  protocolos.forEach((p) => print(p.toLowerCase()));

  // for-in sobre un Map
  final puertos = {'HTTP': 80, 'HTTPS': 443, 'SSH': 22, 'FTP': 21};
  for (final entrada in puertos.entries) {
    print('${entrada.key} → puerto ${entrada.value}');
  }

}