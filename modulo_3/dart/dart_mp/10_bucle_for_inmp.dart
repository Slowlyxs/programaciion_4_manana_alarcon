void main() {
  final protocolos = ['HTTP', 'HTTPS', 'FTP', 'SSH', 'SMTP'];

  for (final p in protocolos) {
    print(p);
  }

  for (final p in protocolos) {
    print(p.toLowerCase());
  }

  final puertos = {'HTTP': 80, 'HTTPS': 443, 'SSH': 22, 'FTP': 21};

  for (final e in puertos.entries) {
    print('${e.key} → puerto ${e.value}');
  }
}