import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/aeropuerto.dart';

class AeropuertosNotifier extends Notifier<List<Aeropuerto>> {
  @override
  List<Aeropuerto> build() => [
        Aeropuerto(id: '1', nombre: 'Mariscal Sucre', ciudad: 'Quito', pistas: 2, internacional: true, favorito: true),
        Aeropuerto(id: '2', nombre: 'José Joaquín de Olmedo', ciudad: 'Guayaquil', pistas: 2, internacional: true),
        Aeropuerto(id: '3', nombre: 'Mariscal Lamar', ciudad: 'Cuenca', pistas: 1, internacional: false),
        Aeropuerto(id: '4', nombre: 'Eloy Alfaro', ciudad: 'Manta', pistas: 1, internacional: false),
      ];

  void toggleFavorito(String id) {
    state = state
        .map(
          (a) => a.id == id
              ? Aeropuerto(
                  id: a.id,
                  nombre: a.nombre,
                  ciudad: a.ciudad,
                  pistas: a.pistas,
                  internacional: a.internacional,
                  favorito: !a.favorito,
                )
              : a,
        )
        .toList();
  }

  void eliminar(String id) {
    state = state.where((a) => a.id != id).toList();
  }

  void agregar(Aeropuerto aeropuerto) {
    state = [...state, aeropuerto];
  }
}

final aeropuertosProvider =
    NotifierProvider<AeropuertosNotifier, List<Aeropuerto>>(
  AeropuertosNotifier.new,
);

final busquedaProvider = StateProvider<String>((ref) => '');

final aeropuertosFiltradosProvider = Provider<List<Aeropuerto>>((ref) {
  final aeropuertos = ref.watch(aeropuertosProvider);
  final q = ref.watch(busquedaProvider).trim().toLowerCase();

  if (q.isEmpty) return aeropuertos;

  return aeropuertos.where((a) {
    return a.nombre.toLowerCase().contains(q) ||
        a.ciudad.toLowerCase().contains(q);
  }).toList();
});
