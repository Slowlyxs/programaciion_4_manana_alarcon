import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/metrica_aeropuerto.dart';

class MetricasNotifier extends AsyncNotifier<List<MetricaAeropuerto>> {
  @override
  Future<List<MetricaAeropuerto>> build() => _fetch();

  Future<List<MetricaAeropuerto>> _fetch() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return const [
      MetricaAeropuerto(
        aeropuerto: 'Mariscal Sucre · UIO',
        ocupacionPista: 72.5,
        ocupacionTerminal: 64.0,
        vuelosActivos: 18,
      ),
      MetricaAeropuerto(
        aeropuerto: 'José Joaquín de Olmedo · GYE',
        ocupacionPista: 88.1,
        ocupacionTerminal: 91.2,
        vuelosActivos: 22,
      ),
      MetricaAeropuerto(
        aeropuerto: 'Mariscal Lamar · CUE',
        ocupacionPista: 42.4,
        ocupacionTerminal: 51.0,
        vuelosActivos: 7,
      ),
    ];
  }

  Future<void> recargar() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }
}

final metricasAeropuertoProvider =
    AsyncNotifierProvider<MetricasNotifier, List<MetricaAeropuerto>>(
  MetricasNotifier.new,
);
