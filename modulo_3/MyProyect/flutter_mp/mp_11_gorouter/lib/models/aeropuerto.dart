class Aeropuerto {
  final String id;
  final String codigoIata;
  final String nombre;
  final String ciudad;
  final int pistas;
  final bool internacional;

  const Aeropuerto({
    required this.id,
    required this.codigoIata,
    required this.nombre,
    required this.ciudad,
    required this.pistas,
    required this.internacional,
  });
}

const aeropuertosSimulados = [
  Aeropuerto(
    id: '1',
    codigoIata: 'UIO',
    nombre: 'Mariscal Sucre',
    ciudad: 'Quito',
    pistas: 2,
    internacional: true,
  ),
  Aeropuerto(
    id: '2',
    codigoIata: 'GYE',
    nombre: 'José Joaquín de Olmedo',
    ciudad: 'Guayaquil',
    pistas: 2,
    internacional: true,
  ),
  Aeropuerto(
    id: '3',
    codigoIata: 'CUE',
    nombre: 'Mariscal Lamar',
    ciudad: 'Cuenca',
    pistas: 1,
    internacional: false,
  ),
];
