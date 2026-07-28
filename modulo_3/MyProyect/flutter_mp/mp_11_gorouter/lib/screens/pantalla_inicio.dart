// lib/screens/pantalla_inicio.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Gestión Aeroportuaria'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.flight_takeoff, size: 64, color: cs.primary),
            const SizedBox(height: 16),
            const Text('Dashboard de Monitoreo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Gestiona aeropuertos, vuelos y operaciones',
                style: TextStyle(color: cs.onSurfaceVariant)),
            const SizedBox(height: 32),
            FilledButton.icon(
              // context.go() — navega SIN apilar (no hay botón "atrás")
              onPressed: () => context.go('/aeropuertos'),
              icon:  const Icon(Icons.local_airport),
              label: const Text('Ver aeropuertos'),
            ),
          ],
        ),
      ),
    );
  }
}