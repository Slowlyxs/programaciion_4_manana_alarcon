// lib/models/servidor_ssh.dart
class ServidorSSH {
  final String id;
  final String nombre;
  final String ip;
  final int    puerto;
  final String usuario;
  final String so;
  final bool   ssl;
  final String servicio;
  bool         favorito;    // mutable — puede cambiar sin recrear el objeto

  ServidorSSH({
    required this.id,
    required this.nombre,
    required this.ip,
    required this.puerto,
    required this.usuario,
    required this.so,
    required this.ssl,
    required this.servicio,
    this.favorito = false,
  });
}