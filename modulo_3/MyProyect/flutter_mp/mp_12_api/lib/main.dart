import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'pantalla_paso1.dart';
import 'pantalla_paso1_personal.dart';
import 'pantalla_paso2.dart';
import 'pantalla_paso_2_personal.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const PantallaUnicaApi()),
    GoRoute(path: '/operacion-cruda', builder: (_, __) => const PantallaPaso1()),
    GoRoute(path: '/personal-crudo', builder: (_, __) => const PantallaPaso1User()),
    GoRoute(path: '/operaciones-dto', builder: (_, __) => const PantallaPaso2()),
    GoRoute(path: '/personal-dto', builder: (_, __) => const PantallaPaso2Personal()),
  ],
);

void main() => runApp(const ProviderScope(child: AppHttp()));

class AppHttp extends StatelessWidget {
  const AppHttp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MP 12 - API aeroportuaria',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
    );
  }
}

class PantallaUnicaApi extends StatelessWidget {
  const PantallaUnicaApi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MP 12 · API aeroportuaria')),
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
                const _Seccion(
                  titulo: '1. http.get + FutureBuilder sin DTO',
                  descripcion: 'Consulta una operación aeroportuaria y trabaja directamente con Map<String, dynamic>.',
                  child: SizedBox(
                    height: 470,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaPaso1(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '2. Personal aeroportuario sin DTO',
                  descripcion: 'Consulta un registro de personal y lee el JSON directamente.',
                  child: SizedBox(
                    height: 560,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaPaso1User(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '3. Lista de operaciones con TodoDto',
                  descripcion: 'Convierte cada elemento JSON en un objeto tipado antes de mostrarlo.',
                  child: SizedBox(
                    height: 620,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaPaso2(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: '4. Lista de personal con TodoDtoUser',
                  descripcion: 'Usa fromJson para transformar y presentar registros de personal aeroportuario.',
                  child: SizedBox(
                    height: 650,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                      child: PantallaPaso2Personal(),
                    ),
                  ),
                ),
                const _Seccion(
                  titulo: 'Flujo completo del módulo',
                  descripcion: 'Los archivos de pantalla, DTO y consumo HTTP se revisan juntos en este resumen.',
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Chip(avatar: Icon(Icons.http), label: Text('http.get')),
                      Chip(avatar: Icon(Icons.hourglass_top), label: Text('FutureBuilder')),
                      Chip(avatar: Icon(Icons.data_object), label: Text('fromJson')),
                      Chip(avatar: Icon(Icons.warning_amber), label: Text('Errores HTTP')),
                      Chip(avatar: Icon(Icons.list_alt), label: Text('ListView')),
                    ],
                  ),
                ),
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    FilledButton.icon(
                      onPressed: () => context.go('/operaciones-dto'),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Abrir operaciones a pantalla completa'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/personal-dto'),
                      icon: const Icon(Icons.people_alt_outlined),
                      label: const Text('Abrir personal a pantalla completa'),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
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
          Icon(Icons.cloud_sync_outlined, size: 48),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Consumo de API en una sola pantalla', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('FutureBuilder, validación HTTP, JSON y DTO aplicados a operaciones y personal aeroportuario.'),
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
