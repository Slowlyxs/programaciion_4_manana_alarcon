// lib/models/aeropuerto.dart
class Aeropuerto {
  final String id;
  final String nombre;
  final String ciudad;
  final int    pistas;
  final String operador;
  final String categoria;
  final bool   internacional;
  final String estado;
  bool         favorito;    // mutable — puede cambiar sin recrear el objeto

  Aeropuerto({
    required this.id,
    required this.nombre,
    required this.ciudad,
    required this.pistas,
    required this.operador,
    required this.categoria,
    required this.internacional,
    required this.estado,
    this.favorito = false,
  });
}