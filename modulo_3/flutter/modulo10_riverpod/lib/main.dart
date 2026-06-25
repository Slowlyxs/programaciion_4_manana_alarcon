// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateProvider — estado simple (int, bool, String, enum)
final contadorProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(
    // ProviderScope: contenedor global, siempre envuelve la app
    const ProviderScope(child: AppMonitoreo()),
  );
}

class AppMonitoreo extends StatelessWidget {
  const AppMonitoreo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
      ),
      home: const _PantallaContador(),
    );
  }
}

// ConsumerWidget = StatelessWidget con acceso a providers
class _PantallaContador extends ConsumerWidget {
  const _PantallaContador();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch — lee y se suscribe (reconstruye al cambiar)
    final count = ref.watch(contadorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Servidores conectados')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count', style: Theme.of(context).textTheme.displayLarge),
            const Text('servidores activos'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            // ref.read — lee SIN suscribirse (para callbacks)
            onPressed: () =>
                ref.read(contadorProvider.notifier).state++,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'rem',
            onPressed: () {
              if (ref.read(contadorProvider) > 0) {
                ref.read(contadorProvider.notifier).state--;
              }
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}