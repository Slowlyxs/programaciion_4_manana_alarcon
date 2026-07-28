// lib/models/aeropuerto.dart
class Aeropuerto {
  final String id;
  final String nombre;
  final String ciudad;
  final int    pistas;
  final bool   internacional;
  bool         favorito;

  Aeropuerto({
    required this.id,
    required this.nombre,
    required this.ciudad,
    required this.pistas,
    required this.internacional,
    this.favorito = false,
  });
}