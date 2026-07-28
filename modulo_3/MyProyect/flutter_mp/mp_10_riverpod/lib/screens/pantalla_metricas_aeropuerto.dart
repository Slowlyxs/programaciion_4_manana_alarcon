import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/metrica_aeropuerto.dart';
import '../providers/metricas_aeropuerto_provider.dart';

class PantallaMetricasAeropuerto extends ConsumerWidget {
  const PantallaMetricasAeropuerto({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricasAsync = ref.watch(metricasAeropuertoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Métricas de aeropuertos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar',
            onPressed: () =>
                ref.read(metricasAeropuertoProvider.notifier).recargar(),
          ),
        ],
      ),
      body: metricasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 8),
              Text('Error: $e'),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () =>
                    ref.read(metricasAeropuertoProvider.notifier).recargar(),
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (metricas) => ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: metricas.length,
          itemBuilder: (_, i) => _TarjetaMetrica(metrica: metricas[i]),
        ),
      ),
    );
  }
}

class _TarjetaMetrica extends StatelessWidget {
  final MetricaAeropuerto metrica;

  const _TarjetaMetrica({required this.metrica});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pistaCritica = metrica.ocupacionPista > 85;
    final terminalCritica = metrica.ocupacionTerminal > 90;
    final esCritico = pistaCritica || terminalCritica;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: esCritico ? cs.errorContainer : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_airport,
                  color: esCritico ? cs.error : cs.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    metrica.aeropuerto,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${metrica.vuelosActivos} vuelos',
                  style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _Barra('Pista', metrica.ocupacionPista, pistaCritica),
            const SizedBox(height: 8),
            _Barra('Terminal', metrica.ocupacionTerminal, terminalCritica),
          ],
        ),
      ),
    );
  }
}

class _Barra extends StatelessWidget {
  final String label;
  final double valor;
  final bool critica;

  const _Barra(this.label, this.valor, this.critica);

  @override
  Widget build(BuildContext context) {
    final color = critica ? Colors.red : Colors.green;
    return Row(
      children: [
        SizedBox(width: 62, child: Text(label, style: const TextStyle(fontSize: 12))),
        Expanded(
          child: LinearProgressIndicator(
            value: valor / 100,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${valor.toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
