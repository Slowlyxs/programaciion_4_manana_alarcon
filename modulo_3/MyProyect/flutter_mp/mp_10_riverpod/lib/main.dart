import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'screens/pantalla_aeropuertos.dart';
import 'screens/pantalla_busqueda.dart';
import 'screens/pantalla_dashboard.dart';
import 'screens/pantalla_metricas_aeropuerto.dart';

final contadorProvider = StateProvider<int>((ref) => 4);

void main() => runApp(const ProviderScope(child: AppAeropuertos()));

class AppAeropuertos extends StatelessWidget {
  const AppAeropuertos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MP 10 - Riverpod aeroportuario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const PantallaUnicaRiverpod(),
    );
  }
}

class PantallaUnicaRiverpod extends ConsumerWidget {
  const PantallaUnicaRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cantidad = ref.watch(contadorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('MP 10 · Riverpod aeroportuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Cabecera(),
                const SizedBox(height: 18),
                _Seccion(
                  titulo: '1. ProviderScope y StateProvider',
                  descripcion: 'Estado simple para controlar el número de aeropuertos conectados.',
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 18,
                      runSpacing: 12,
                      children: [
                        Icon(Icons.hub_outlined, size: 54, color: Theme.of(context).colorScheme.primary),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('$cantidad', style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold)),
                            const Text('aeropuertos conectados'),
                          ],
                        ),
                        IconButton.filledTonal(
                          onPressed: cantidad > 0
                              ? () => ref.read(contadorProvider.notifier).state--
                              : null,
                          icon: const Icon(Icons.remove),
                          tooltip: 'Desconectar uno',
                        ),
                        IconButton.filled(
                          onPressed: () => ref.read(contadorProvider.notifier).state++,
                          icon: const Icon(Icons.add),
                          tooltip: 'Conectar uno',
                        ),
                      ],
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '2. NotifierProvider',
                  descripcion: 'Lista mutable con agregar, eliminar y marcar aeropuertos favoritos.',
                  child: SizedBox(
                    height: 590,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaAeropuertos(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '3. Provider derivado',
                  descripcion: 'Búsqueda reactiva que se recalcula cuando cambia el texto o la lista.',
                  child: SizedBox(
                    height: 590,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaBusqueda(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '4. AsyncNotifierProvider',
                  descripcion: 'Carga asíncrona con estados loading, data y error para métricas operativas.',
                  child: SizedBox(
                    height: 590,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaMetricasAeropuerto(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '5. Navegación controlada por Riverpod',
                  descripcion: 'NavigationBar con índice guardado en un StateProvider.',
                  child: SizedBox(
                    height: 620,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaDashboard(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Cabecera extends StatelessWidget {
  const _Cabecera();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.account_tree_outlined, size: 48),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Riverpod en una sola pantalla', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('StateProvider, NotifierProvider, providers derivados, AsyncNotifier y navegación reactiva.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Seccion extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final Widget child;

  const _Seccion({required this.titulo, required this.descripcion, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(titulo, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(descripcion, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
            const Divider(height: 28),
            child,
          ],
        ),
      ),
    );
  }
}
